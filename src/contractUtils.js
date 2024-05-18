// src/contractUtils.js
import Web3 from 'web3';
import MyContractAbi from './contracts/MyContract.json'; // 替换为你的合约 ABI 文件路径

const web3 = new Web3(process.env.VUE_APP_RPC_URL);
const contractAddress = process.env.VUE_APP_CONTRACT_ADDRESS;
const contract = new web3.eth.Contract(MyContractAbi, contractAddress);

export const getMessage1 = async () => {
  return await contract.methods.getMessage1().call();
};

export const getMessage2 = async () => {
  return await contract.methods.getMessage2().call();
};
