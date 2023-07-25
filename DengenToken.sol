//Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
//Transferring tokens: Players should be able to transfer their tokens to others.
//Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
//Checking token balance: Players should be able to check their token balance at any time.
//Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {

    constructor() ERC20("Degen", "DGN") {}

        function mint(address to, uint256 amount) public onlyOwner{
            _mint(to, amount);
        }
        function transferTokens(address _reciever, uint amount) external{
            require(balanceOf(msg.sender) >= amount, "you are not owner");
            approve(msg.sender, amount);
            transferFrom(msg.sender, _reciever, amount);
        }
        function checkBalance() external view returns(uint){
           return balanceOf(msg.sender);
        }
        function burnTokens(uint amount) external{
            require(balanceOf(msg.sender)>= amount, "You do not have enough Tokens");
            _burn(msg.sender, amount);
        }
        function gameStore() public pure returns(string memory) {
            return "(1)diamond player NFT   (2)platinum player nft    (3)gold player nft  (4)silver player nft    (5)bronze player nft ";
        }
        function reedemTokens(uint choice) external payable{
            require(choice<=3,"Invalid selection");
            if(choice ==1){
                require(balanceOf(msg.sender)>=500, "Tokens are not enough");
                approve(msg.sender, 500);
                transferFrom(msg.sender, owner(), 500);
            }
            else if(choice ==2){
                require(balanceOf(msg.sender)>=200, "Tokens are not enough");
                approve(msg.sender, 200);
                transferFrom(msg.sender, owner(), 200);
            }
            else if(choice ==3){
                require(balanceOf(msg.sender)>=100, "Tokens are not enough");
                approve(msg.sender, 100);
                transferFrom(msg.sender, owner(), 100);
            }
            else if(choice ==4){
                require(balanceOf(msg.sender)>=50, "Tokens are not enough");
                approve(msg.sender, 50);
                transferFrom(msg.sender, owner(), 50);
            }
            else {
                require(balanceOf(msg.sender)>=25, "Tokens are not enough");
                approve(msg.sender, 25);
                transferFrom(msg.sender, owner(), 25);
            }

        }

}
