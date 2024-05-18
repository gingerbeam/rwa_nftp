<template>
  <div class="container" :style="`background-image: url(${require('@/assets/img-bg.jpg')});`">
    <button @click="connectWallet" class="connect-button" :class="{ 'connected': connected }">
      {{ connected ? 'Connected' : 'Connect to MetaMask' }}
    </button>
    <div v-if="connected" class="account-info">
      <p class="address">Address: {{ accountAddress }}</p>
      <p class="balance">FT Balance: {{ ftBalance }} FT</p>
    </div>
    <div class="product-gallery">
      <div v-for="(item, index) in images" :key="index" class="product-item">
        <img :src="require(`@/assets/${item.img}`)" alt="Product Image" />
        <p>{{ item.name }}</p>
        <p>基本价格: {{ item.price }}ft/天</p>
        <p>出租日期: {{ item.rentalPeriod }}</p>
        <button @click="showPopup(index)" :disabled="!connected" :class="{ 'disabled': !connected }">查看详情</button>
      </div>
    </div>
    <div class="popup" v-if="showModal">
    <div class="popup-content">
      <span class="close" @click="closePopup">&times;</span>
      <h2>确认租赁</h2>
      <p>请选择租赁起止日期:</p>
      <input type="date" v-model="startDate" />
      <input type="date" v-model="endDate" />
      <button @click="confirmRent">确认租赁</button>
      <p v-if="totalCost">估价: {{ totalCost }} FT</p>
    </div>
  </div>
  </div>
</template>

<script>
import enableEthereum from '@/utils/web3';

export default {
  data() {
    return {
      images: [
        { img: 'img1.jpg', name: '房间 1', price: 20, rentalPeriod: '3月-7月' },
        { img: 'img2.jpg', name: '房间 2', price: 30, rentalPeriod: '2月-8月' },
        { img: 'img3.jpg', name: '房间 3', price: 50, rentalPeriod: '5月-7月' }
      ],
      connected: false,
      accountAddress: '',
      ftBalance: 0,
      showModal: false , // 新增变量用于控制弹窗显示与隐藏
      startDate: '',
      endDate: '',
      selectedItemIndex: null
    };
  },
  methods: {
    async connectWallet() {
      try {
        const web3 = await enableEthereum();
        if (web3) {
          const accounts = await web3.eth.getAccounts();
          this.connected = true;
          this.accountAddress = accounts[0];
          const balance = await web3.eth.getBalance(this.accountAddress);
          this.ftBalance = web3.utils.fromWei(balance, 'ether');
        }
      } catch (error) {
        console.error("Error connecting to MetaMask", error);
      }
    },

    showPopup(index) {
      this.showModal = true;  // 设置弹窗显示为 true
      this.selectedItemIndex = index;  // 记录用户选择的物品索引
    },

    closePopup() {
      this.showModal = false;  // 关闭弹窗
    },

    confirmRent() {
      // 在这里处理确认租赁的逻辑
      // 可以使用this.selectedItemIndex和this.startDate、this.endDate来获取用户选择的物品索引、租赁起止日期
      if (this.selectedItemIndex !== null && this.startDate && this.endDate) {
        const item = this.images[this.selectedItemIndex];
        const price = item.price;
        const days = (new Date(this.endDate) - new Date(this.startDate)) / (1000 * 60 * 60 * 24);
        this.totalCost = price * days;
        this.showModal = false;  // 关闭弹窗
      }
    }
  },
  computed: {
    totalCost() {
      if (this.startDate && this.endDate) {
        const item = this.images[this.selectedItemIndex];
        const price = item.price;
        const days = (new Date(this.endDate) - new Date(this.startDate)) / (1000 * 60 * 60 * 24);
        return price * days;
      }
      return 0;
    }
  }
  
};
</script>
<style scoped>
.container {
  position: relative;
  width: 100%;
  height: 100vh;
  background-image: url("@/assets/img-bg.jpg");
  background-size: cover;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 20px;
  box-sizing: border-box;  /* 让 padding 不影响容器的宽度和高度 */
}

.connect-button {
  position: absolute;
  top: 20px;
  right: 20px;
}

.product-gallery {
  border-top: 2px solid #ccc;
  padding-top: 20px;
  margin-top: 20px;
}

.product-item {
  padding: 20px;
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  text-align: center;
  transition: transform 0.3s ease;
}

.product-item:hover {
  transform: translateY(-5px);
}


.connect-button.connected {
  background-color: #4CAF50;  /* Green color indicates connection success */
}

.product-gallery {
  display: flex;
  gap: 20px;
  margin-top: 20px;
}

.product-item p {
  font-size: 16px;
  font-weight: bold;
  color: #333;
  margin-top: 10px;
}

img {
  width: 200px;
  height: auto;
  border-radius: 5px;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

button {
  margin-top: 10px;
  padding: 5px 10px;
  border: none;
  background-color: #007bff;
  color: white;
  border-radius: 5px;
  cursor: pointer;
}

button.disabled {
  opacity: 0.5;
  cursor: not-allowed;
}
.account-info {
  position: absolute;
  top: 20px;
  left: 20px;
  color: white;
  font-family: 'Arial', sans-serif; /* 设置字体为可爱美观的字体 */
}

.account-info p {
  margin: 5px 0; /* 调整段落之间的间距 */
}

.address {
  font-size: 18px; /* 调整地址信息字体大小 */
  font-weight: bold; /* 加粗字体 */
}

.balance {
  font-size: 16px; /* 调整余额信息字体大小 */
  font-weight: bold; /* 加粗字体 */
  font-style: italic; /* 斜体字体 */
}
.popup {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
}

.popup-content {
  background: #fff;
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  text-align: center;
  position: relative;
}

.close {
  position: absolute;
  top: 10px;
  right: 10px;
  cursor: pointer;
}
</style>
