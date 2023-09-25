const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log(`Deploying MyToken from ${deployer.address}`);

  const MyToken = await ethers.getContractFactory("MyToken");
  const myToken = await MyToken.deploy();

  console.log(`MyToken address: ${myToken.address}`);

  console.log(`Deploying MyNFT from ${deployer.address}`);

  // Use myToken.address as myTokenAddress
  const myTokenAddress = myToken.address;

  const MyNFT = await ethers.getContractFactory("MyNFT");
  const myNFT = await MyNFT.deploy(myTokenAddress);

  console.log(`MyNFT address: ${myNFT.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
