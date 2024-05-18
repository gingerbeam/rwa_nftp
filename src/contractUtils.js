// src/contractUtils.js
import Web3 from 'web3';
import MyContractAbi from './contracts/Router.json'; // 替换为你的合约 ABI 文件路径

const web3 = new Web3(process.env.VUE_APP_RPC_URL);
const contractAddress = process.env.VUE_APP_CONTRACT_ADDRESS;
const contract = new web3.eth.Contract(MyContractAbi, contractAddress);

export const rentRoom = async () => {
  return await contract.methods.rentRoom().call();
};

export const createRoom = async () => {
  return await contract.methods.createRoom().call();
};
