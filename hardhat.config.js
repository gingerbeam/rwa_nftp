require('@openzeppelin/hardhat-upgrades');
require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    scrollTestnet: {
      url: process.env.SCROLL_TESTNET_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
};
