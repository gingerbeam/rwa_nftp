<template>
  <div id="app">
    <h1>Message: {{ message }}</h1>
    <button @click="fetchMessage1">Get Message 1</button>
    <button @click="fetchMessage2">Get Message 2</button>
  </div>
</template>

<script>
import { getMessage1, getMessage2 } from './contractUtils';

export default {
  name: 'App',
  data() {
    return {
      message: ''
    };
  },
  methods: {
    async fetchMessage1() {
      try {
        this.message = await getMessage1();
      } catch (error) {
        console.error('Error fetching message 1:', error);
      }
    },
    async fetchMessage2() {
      try {
        this.message = await getMessage2();
      } catch (error) {
        console.error('Error fetching message 2:', error);
      }
    }
  }
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
