<template>
  <div class="modal-mask" v-if="show">
    <div class="modal-container">
      <div class="modal-header">
        <slot name="header">
          Default Header
        </slot>
      </div>
      <div class="modal-body">
        <slot name="body">
          Default Body
        </slot>
      </div>
      <div class="modal-footer">
        <slot name="footer">
          <button @click="closeModal">Close</button>
        </slot>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    show: {
      type: Boolean,
      required: true
    }
  },
  methods: {
    closeModal() {
      this.$emit('close');
    }
  }
};
</script>

<style scoped>
.modal-mask {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
}

.modal-container {
  background-color: #fff;
  padding: 20px;
  border-radius: 8px;
  max-width: 80%;
}

.modal-header {
  text-align: center;
  font-size: 18px;
  margin-bottom: 10px;
}

.modal-body {
  margin-bottom: 20px;
}

.modal-footer {
  text-align: right;
}
</style>
