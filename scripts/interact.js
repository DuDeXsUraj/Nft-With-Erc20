const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log(`Deployer's address: ${deployer.address}`);

  // Replace with the addresses of your deployed contracts
  const tokenAddress = "0xe660f73Cf5554Cb7c9B06780F9BC1B08134e3eDc";
  const nftAddress = "0x127B9f60ad727069A6A6176E46bBD4CE53B9AB7E";

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