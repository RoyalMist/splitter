<template>
    <div class="container">
        <div class="row">
            <div class="column">
                <h1>Welcome to Splitter</h1>
            </div>
        </div>
        <div class="row">
            <div class="column">
                <split></split>
            </div>
            <div class="column">
                <account v-bind:splitter="splitter"></account>
            </div>
        </div>
    </div>
</template>

<script>
    import Account from "./account";
    import Split from "./split";
    import web3 from '../web3';

    export default {
        name: "home",
        components: {Split, Account},
        data() {
            return {splitter: {}}
        },
        beforeMount() {
            const abi = require('../../build/contracts/Splitter.json');
            this.splitter = new web3.eth.Contract(JSON.parse(abi), "0x743a8BfCDf9d2Db6b9A9500393D0F10dA19F278D");
        }
    }
</script>

<style lang="stylus" scoped>
    .myDiv
        color: blue
</style>