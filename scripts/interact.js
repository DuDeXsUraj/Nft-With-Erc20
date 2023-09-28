const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log(`Deployer's address: ${deployer.address}`);

  // Replace with the addresses of your deployed contracts
  const tokenAddress = "0xF648B32f58c3d008c3ebEb7f92Fb38a5eA38a2cd";
  const nftAddress = " 0xd3F9292081674c56dAE1E1fF5eACc748c7745A57";

  const MyToken = await ethers.getContractFactory("MyToken");
  const myToken = MyToken.attach(tokenAddress);

  const MyNFT = await ethers.getContractFactory("MyNFT");
  const myNFT = MyNFT.attach(nftAddress);

  // Approve the NFT contract to spend ERC20 tokens
  const approveTx = await myToken.approve(nftAddress, 1);
  await approveTx.wait();

  // Mint the NFT
  const mintTx = await myNFT.mint();

  await mintTx.wait();

  console.log("NFT minted successfully!");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

  // contract address: 0x127B9f60ad727069A6A6176E46bBD4CE53B9AB7E