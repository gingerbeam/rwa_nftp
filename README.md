# NomadBnB (previously rwa_nftp)

![NomadBnB LOGO](./logo.jpg "NomadBnB")

## 前端
```
npm install
```

### 启动前端环境
```
npm run serve
```

## 合约

### 安装hardhat环境

#### 安装node和npm
```
node -v
npm -v
```

#### 安装hardhat
```
npm install --save-dev hardhat
```

#### 安装hardhat插件
最好在你的根目录下安装
```
npm install --save-dev @nomiclabs/hardhat-ethers ethers
npm install dotenv
```

### Events contained in .env

你需要先在`.env`中进行配置：
```
SCROLL_TESTNET_URL=https://sepolia-rpc.scroll.io/ # scroll测试网rpc
PRIVATE_KEY=<你的钱包私钥>

VUE_APP_RPC_URL=https://sepolia-rpc.scroll.io/ # scroll测试网rpc
VUE_APP_CONTRACT_ADDRESS=your_contract_address_here  # 部署好的合约的地址
```

### Compile your contract
```
npx hardhat compile
```

### Deploy your constract
```
npx hardhat run scripts/deploy.js --network scrollTestnet
```
控制台会输出部署好的合约在scroll测试网的地址

### 在控制台上测试合约
```
npx hardhat console --network scrollTestnet
// 输入
const MyContract = await ethers.getContractFactory("Router");
const myContract = await MyContract.attach("0xEA6BD948042645C92e6b9b00766FF9c75B476465"); # 合约地址

const roomId = 111;
const price = 1111;
const landlord = <你的钱包地址>;

const message = await myContract.createRoom(roomId, price, landlord);
console.log(message);
```
