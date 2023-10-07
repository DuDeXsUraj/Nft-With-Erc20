// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./MyToken.sol";

contract MyNFT is ERC721, Ownable {
    IERC20 public erc20Token;
    uint256 public tokenIdCounter;
    uint256 public constant mintingPrice = 100 * 10**18; // Set the fixed minting price to 100 tokens

    constructor(address _erc20TokenAddress) ERC721("MyNFT", "MNFT") {
        erc20Token = IERC20(_erc20TokenAddress);
        tokenIdCounter = 0;
    }

    function mintNFT() external {
        require(erc20Token.transferFrom(msg.sender, address(this), mintingPrice), "Transfer failed");
        _safeMint(msg.sender, tokenIdCounter);
        tokenIdCounter++;
    }
}
