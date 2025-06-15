// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title KipuBank - Contrato de bóveda con límite por depósito y por retiro
contract KipuBank {
    // ========== ERRORES PERSONALIZADOS ==========
    error DepositLimitExceeded(uint256 attempted, uint256 maxAllowed);
    error WithdrawLimitExceeded(uint256 attempted, uint256 limit);
    error InsufficientBalance(uint256 attempted, uint256 available);

    // ========== VARIABLES DE ESTADO ==========
    mapping(address => uint256) private balances;
    mapping(address => uint256) private depositsCount;
    mapping(address => uint256) private withdrawalsCount;

    uint256 public totalDeposited;
    uint256 public immutable depositLimit;
    uint256 public immutable withdrawLimit;

    // ========== EVENTOS ==========
    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    // ========== CONSTRUCTOR ==========
    constructor(uint256 _depositLimit, uint256 _withdrawLimit) {
        depositLimit = _depositLimit;
        withdrawLimit = _withdrawLimit;
    }

    // ========== MODIFICADORES ==========
    /// @notice Asegura que el depósito no exceda el límite permitido
    modifier underDepositLimit(uint256 amount) {
        if (amount > depositLimit) {
            revert DepositLimitExceeded(amount, depositLimit);
        }
        _;
    }

    // ========== FUNCIONES PRINCIPALES ==========

    /// @notice Permite a los usuarios depositar ETH dentro del límite establecido
    function deposit() external payable underDepositLimit(msg.value) {
        balances[msg.sender] += msg.value;
        depositsCount[msg.sender]++;
        totalDeposited += msg.value;

        emit Deposited(msg.sender, msg.value);
    }

    /// @notice Permite a los usuarios retirar ETH hasta un máximo definido
    function withdraw(uint256 amount) external {
        if (amount > withdrawLimit) {
            revert WithdrawLimitExceeded(amount, withdrawLimit);
        }

        if (amount > balances[msg.sender]) {
            revert InsufficientBalance(amount, balances[msg.sender]);
        }

        balances[msg.sender] -= amount;
        withdrawalsCount[msg.sender]++;
        totalDeposited -= amount;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Transfer failed");

        emit Withdrawn(msg.sender, amount);
    }

    // ========== FUNCIONES DE LECTURA ==========

    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }

    function getDepositCount(address user) external view returns (uint256) {
        return depositsCount[user];
    }

    function getWithdrawalCount(address user) external view returns (uint256) {
        return withdrawalsCount[user];
    }
}
