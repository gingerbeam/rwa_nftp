// src/contractUtils.js
import Web3 from 'web3';
import MyContractAbi from './contracts/Router.json'; // 替换为你的合约 ABI 文件路径

const web3 = new Web3(process.env.VUE_APP_RPC_URL);
const contractAddress = process.env.VUE_APP_CONTRACT_ADDRESS;
const contract = new web3.eth.Contract(MyContractAbi, contractAddress);

export const rentRoom = async (roomAddress, roomId, price, startDate, endDate) => {
  const response = await contract.methods.rentRoom(roomAddress, roomId, price, startDate, endDate).send();
  return response;
};

export const createRoom = async (roomId, price, landlord) => {
  const response = await contract.methods.createRoom(roomId, price, landlord).send();
  return response;
};
