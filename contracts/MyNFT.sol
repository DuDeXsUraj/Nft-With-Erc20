// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import './MyToken.sol';

contract MyNFT is ERC721, Ownable {
    IERC20 public myToken;
    uint256 public totalSupply;

    constructor(address _tokenAddress) ERC721("MyNFT", "MNFT") {
        myToken = IERC20(_tokenAddress);
    }

    function mint() external {
        require(myToken.transferFrom(msg.sender, address(this), 1), "Transfer failed. Ensure you have approved the token.");
        uint256 tokenId = totalSupply + 1;
        _mint(msg.sender, tokenId);
        totalSupply++;
    }
}
