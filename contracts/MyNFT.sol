// This contract is used for NFT minting with a fee in paymentToken
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./Token.sol";

contract MyERC721NFT is ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    IERC20 public paymentToken;
    uint256 public mintingFee; // Fee in paymentToken required for minting

    constructor(
        string memory name,
        string memory symbol,
        address _paymentToken,
        uint256 _mintingFee
    ) ERC721(name, symbol) {
        paymentToken = IERC20(_paymentToken);
        mintingFee = _mintingFee;
    }

    function setMintingFee(uint256 _newFee) external onlyOwner {
        mintingFee = _newFee;
    }

    function mintNFT() external {
        require(paymentToken.transferFrom(msg.sender, address(this), mintingFee), "Fee transfer failed");
        
        _mint(msg.sender, _tokenIdCounter.current());
        _tokenIdCounter.increment();
    }
}

