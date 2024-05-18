require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

module.exports = {
  solidity: "0.8.0",
  networks: {
    scrollTestnet: {
      url: process.env.SCROLL_TESTNET_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
};
