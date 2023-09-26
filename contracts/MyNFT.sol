// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./MyToken.sol";

contract MyNFT is ERC721, Ownable {
    IERC20 public myToken;
    uint256 public totalSupply;

    constructor(address _tokenAddress) ERC721("MyNFT", "MNFT") {
        myToken = IERC20(_tokenAddress);
    }

    // Function to mint NFTs
    function mint() external {
        require(myToken.transferFrom(msg.sender, address(this), 1), "Transfer failed. Ensure you have approved the token.");

        uint256 tokenId = totalSupply + 1;

        // Check if the caller is a contract
        if (isContract(msg.sender)) {
            // Mint the NFT to the contract itself
            _mint(msg.sender, tokenId);
        } else {
            // Mint the NFT to the caller (EOA)
            _mint(msg.sender, tokenId);
        }

        totalSupply++;
    }

    // Function to check if an address is a contract
    function isContract(address _addr) internal view returns (bool) {
        uint32 size;
        assembly {
            size := extcodesize(_addr)
        }
        return (size > 0);
    }
}
