<template>
  <div class="container">
    <div class="row">
      <div class="column">
        <h1>Welcome to Splitter</h1>
      </div>
    </div>
    <div class="row">
      <div class="column">
        <split />
      </div>
      <div class="column">
        <account v-bind:splitter="splitter" v-bind:account="account" />
      </div>
    </div>
  </div>
</template>

<script>
import Account from "./account";
import Split from "./split";
import contract from "truffle-contract";
import Web3 from "web3";
import { constants } from "fs";

export default {
  name: "home",
  components: { Split, Account },
  data() {
    return { splitter: null, account: null };
  },
  async mounted() {
    const mathJson = require("../contracts/Math.json");
    const splitterJson = require("../contracts/Splitter.json");
    const web3 = new Web3(
      new Web3.providers.HttpProvider("http://127.0.0.1:8545")
    );

    let mathContract = contract(mathJson);
    let splitterContract = contract(splitterJson);
    mathContract.setProvider(web3.currentProvider);
    splitterContract.setProvider(web3.currentProvider);
    const accounts = await web3.eth.getAccounts();
    if (accounts.length > 0) {
      this.account = accounts[0];
    }

    await mathContract.deployed();
    this.splitter = await splitterContract.deployed();
    console.log(this.splitter);
  }
};
</script>

<style lang="stylus" scoped>
.myDiv {
  color: blue;
}
</style>