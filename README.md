# identity-verification
# Decentralized Identity Verification System

## Overview
This project implements a **Decentralized Identity Verification System** using **Solidity** on the **Edu Chain** blockchain. The smart contract enables secure identity registration, verification, revocation, and management of verifiers and admin roles.

## Smart Contract: `IdentityVerification.sol`
### **Features**
- **Identity Registration**: Users can register their identity details securely.
- **Identity Update**: Registered users can update their identity information.
- **Identity Verification**: Admin and authorized verifiers can verify a user's identity.
- **Identity Revocation**: Users can revoke their identity, or the admin can revoke fraudulent ones.
- **Admin Management**: The admin can change control to a new address.
- **Verifier Management**: The admin can assign or remove verifiers.
- **Timestamps**: Each identity record includes timestamps for tracking registration and updates.

## **Deployed Contract Details**
- **Contract Address**: `0x377b4f05b84e652Cd86337D6dEF0043a02203454`
- **Blockchain Network**: Edu Chain

## **How to Interact**
You can interact with the contract using:
- **Remix IDE**
- **Etherscan (if supported by Edu Chain)**
- **Web3.js / Ethers.js** in a frontend application

### **Example Function Calls**
#### **Register Identity**
```solidity
registerIdentity("John Doe", "1990-01-01", "john@example.com", "+1234567890");
```
#### **Verify Identity** (Admin or Verifier only)
```solidity
verifyIdentity(0xUserAddress);
```
#### **Revoke Identity**
```solidity
revokeIdentity();
```
#### **Change Admin**
```solidity
changeAdmin(0xNewAdminAddress);
```

## **Future Enhancements**
- **Integration with IPFS** for storing additional identity documents.
- **Multi-Signature Verification** for enhanced security.
- **Integration with DID (Decentralized Identity) standards.**

## **Contributing**
Feel free to fork this repository and submit pull requests for improvements!

## **License**
This project is open-source and licensed under the **MIT License**.

