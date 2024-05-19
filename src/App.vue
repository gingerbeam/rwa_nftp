<template>
  <div id="app">
    <my-component></my-component>
  </div>
</template>

<script>
import MyComponent from './components/ConnectWallet.vue';

export default {
  name: 'App',
  components: {
    MyComponent
  }
  // methods: {
  //   async createRoomMethod() {
  //     try {
  //       this.message = await createRoom();
  //     } catch (error) {
  //       console.error('Error fetching message 1:', error);
  //     }
  //   },
  //   async rentRoomMethod() {
  //     try {
  //       this.message = await rentRoom();
  //     } catch (error) {
  //       console.error('Error fetching message 2:', error);
  //     }
  //   }
  // }
}
</script>

<style>
/* CSS 样式 */
</style>

