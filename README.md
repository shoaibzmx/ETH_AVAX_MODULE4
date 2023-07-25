# DegenToken Smart Contract

DegenToken is an ERC20 token smart contract designed for a gaming platform. It allows the platform owner to mint new tokens as rewards, players to transfer tokens, redeem tokens for in-game items, check their token balance, and burn tokens when they are no longer needed.

## Requirements

- Solidity Compiler (>=0.8.18)
- OpenZeppelin Contracts (version specified in the import statements)
- Hardhat (for testing and deployment)

## Functionality

1. Minting new tokens:
   - Only the owner of the contract can mint new tokens.
   - The `mint(address to, uint256 amount)` function allows the owner to create new tokens and send them to the specified address.

2. Transferring tokens:
   - Players can transfer their tokens to others using the `transferTokens(address _receiver, uint amount)` function.
   - Before transferring, the sender must have a sufficient balance to complete the transfer.

3. Redeeming tokens:
   - Players can redeem their tokens for in-game items in the store using the `reedemTokens(uint choice)` function.
   - The player selects an item (NFT) from the available options, and the corresponding amount of tokens is transferred from the player's balance to the owner's address.

4. Checking token balance:
   - Players can check their token balance at any time using the `checkBalance()` function.

5. Burning tokens:
   - Anyone can burn their own tokens that they no longer need.
   - The `burnTokens(uint amount)` function allows the token owner to burn a specific amount of tokens from their balance.

## Deploying the Contract

To deploy the DegenToken contract, follow these steps:

1. Install Hardhat and its dependencies:
      npm install --save-dev hardhat
      npm install @openzeppelin/contracts
      npm install hardhat-console

2. Compile the contract:
      npx hardhat compile

3. Run tests (if available) to ensure the contract functions correctly:
       npx hardhat test


4. Deploy the contract on the desired network using Hardhat's deployment scripts.

## Usage

After deploying the contract, the platform owner should be able to interact with the smart contract and mint new tokens as rewards. Players can transfer, check their balances, and burn tokens when needed. The `reedemTokens(uint choice)` function allows players to exchange tokens for in-game items from the store.





   

