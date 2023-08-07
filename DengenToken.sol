// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    enum PlayerNFT {
        Diamond,
        Platinum,
        Gold,
        Silver,
        Bronze
    }

    mapping(PlayerNFT => uint256) private nftPrices;

    constructor() ERC20("Degen", "DGN") {
        // Initial supply to the contract deployer
        _mint(msg.sender, 100); // Minting 100 tokens initially
        nftPrices[PlayerNFT.Diamond] = 500;
        nftPrices[PlayerNFT.Platinum] = 200;
        nftPrices[PlayerNFT.Gold] = 100;
        nftPrices[PlayerNFT.Silver] = 50;
        nftPrices[PlayerNFT.Bronze] = 25;
    }

    // Minting new tokens: Only the contract owner (creator) can mint new tokens.
    function mintTokens(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Transferring tokens: Players can transfer their tokens to other addresses.
    function transferTokens(address recipient, uint256 amount) external {
        require(recipient != address(0), "Invalid recipient address");
        _transfer(msg.sender, recipient, amount);
    }

    // Redeeming tokens: Players can redeem their tokens for items in the in-game store.
    function redeemTokens(PlayerNFT choice) external {
        uint256 price = nftPrices[choice];
        require(price > 0, "Invalid selection");

        uint256 playerBalance = balanceOf(msg.sender);
        require(playerBalance >= price, "Insufficient tokens");

        _burn(msg.sender, price); // Burning the tokens from player's account
        _mint(owner(), price); // Minting the tokens to the contract owner
    }

    // Checking token balance: Players can check their token balance at any time.
    function checkBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    // Burning tokens: Anyone should be able to burn tokens they own and no longer need.
    function burnTokens(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    // The contract owner can set the price for each player NFT in tokens.
    function setNftPrice(PlayerNFT player, uint256 price) external onlyOwner {
        require(price > 0, "Price must be greater than zero");
        nftPrices[player] = price;
    }

    // The contract owner can withdraw accumulated tokens from the contract.
    function withdrawTokens(uint256 amount) external onlyOwner {
        require(amount > 0, "Amount must be greater than zero");
        require(amount <= balanceOf(address(this)), "Insufficient contract balance");
        _transfer(address(this), msg.sender, amount);
    }

    // Get the price of a specific player NFT.
    function getNftPrice(PlayerNFT player) external view returns (uint256) {
        return nftPrices[player];
    }

    // Function to get the details of a player NFT.
    function getPlayerNFTDetails(PlayerNFT player) external pure returns (string memory) {
        if (player == PlayerNFT.Diamond) {
            return "Diamond player NFT";
        } else if (player == PlayerNFT.Platinum) {
            return "Platinum player NFT";
        } else if (player == PlayerNFT.Gold) {
            return "Gold player NFT";
        } else if (player == PlayerNFT.Silver) {
            return "Silver player NFT";
        } else if (player == PlayerNFT.Bronze) {
            return "Bronze player NFT";
        } else {
            return "Invalid player NFT";
        }
    }
}
