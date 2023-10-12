# Smart Contract swapping Bitcoin for Avalance Atomically

**Language**: Solidity <br/>
**Date**: Jun 2023 <br/>
**Repository**: [github.com/awest25/Avalanche-Coin-Swap](https://github.com/awest25/Avalanche-Coin-Swap)

## Overview
The `AtomicSwapAvalance` contract is an Ethereum smart contract enabling trustless swapping of Bitcoin for a fictitious coin, Avalance. Utilizing the power of cryptographic hash functions, this smart contract ensures that both parties involved in the swap are honest, thereby making the transaction secure and tamper-proof.

This is achieved through a mechanism wherein a party deposits Bitcoin and creates a cryptographic secret. The other party then matches the deposit with Avalance. The original party then reveals the secret to redeem the Avalance, and the other party can then use the revealed secret to redeem the Bitcoin.

## Key Features
- **Trustless Swap**: Ensures that neither party can cheat the other during the swap process.
- **Hashed Secret**: Uses a cryptographic hash for security and validation.
- **Timed Transactions**: Incorporates a refund mechanism based on time, safeguarding participants against potential stalls in the process.
- **Dual Participation**: Initially, one party deposits and the other party participates by matching the deposit.
- **Redemption**: A redeem function that verifies the secret against its hash and transfers the locked coins.

## Technical Stack
- **Blockchain**: Ethereum.
- **Smart Contract Language**: Solidity v0.8.18.
- **Development Environment**: Remix IDE.
- **Network**: Ethereum Mainnet or Testnet (for development/testing purposes).

## Getting Started
1. Clone the repo: `git clone https://github.com/awest25/AtomicSwapAvalance.git`
2. Install the necessary tools: Truffle, Ganache, or your preferred Ethereum development environment.
3. Compile the smart contract using: `truffle compile` (if using Truffle).
4. Deploy the contract to the Ethereum network: `truffle migrate --reset` (if using Truffle).
5. Interact with the contract functions using Remix or through a web3 provider in your application.

## Important Notes
- This contract assumes that swaps between Ethereum and other blockchains (like Bitcoin) are facilitated off-chain or via other means. This smart contract only represents the Ethereum side of the transaction.
- As always, before deploying or integrating, make sure to run comprehensive tests and perhaps get the contract audited for any potential vulnerabilities.
