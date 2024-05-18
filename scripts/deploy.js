// scripts/deploy.js
async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);
  const systemAddress = deployer.address;

  const MyContract = await ethers.getContractFactory("Router");
  const myContract = await MyContract.deploy(systemAddress);
  console.log("Contract deployed to address:", myContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
