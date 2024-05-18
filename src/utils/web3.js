// src/utils/web3.js
import Web3 from 'web3';

let web3;

const enableEthereum = async () => {
  if (window.ethereum) {
    web3 = new Web3(window.ethereum);
    try {
      // 请求用户授权连接MetaMask
      await window.ethereum.enable();
      return web3;
    } catch (error) {
      console.error("User denied account access");
    }
  } else if (window.web3) {
    // 如果用户已安装MetaMask，使用它当前提供的提供者
    web3 = new Web3(window.web3.currentProvider);
  } else {
    console.log('Non-Ethereum browser detected. You should consider trying MetaMask!');
  }
};

export default enableEthereum;

