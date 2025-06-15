# 🏦 KipuBank

**KipuBank** is a simple smart contract written in Solidity that functions as a decentralized ETH vault. It allows users to deposit and withdraw ETH, with customizable **limits per deposit and per withdrawal** to ensure responsible usage.

---

## ⚙️ Features

- 💰 **Deposit ETH** up to a maximum amount (`depositLimit`)
- 🏧 **Withdraw ETH** up to a maximum amount (`withdrawLimit`)
- 🔐 Tracks:
  - Per-user ETH balances
  - Number of deposits and withdrawals
- 🔔 Emits events on successful deposits and withdrawals
- 🚫 Reverts with custom errors when limits or balances are violated

---

## 🧱 Contract Details

- **Contract Name:** `KipuBank`
- **License:** MIT
- **Solidity Version:** `^0.8.20`

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone [https://github.com/your-username/KipuBank.git](https://github.com/jorgegmezdev/kipu-bank.git)
cd KipuBank
