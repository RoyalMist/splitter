<template>
    <div class="container">
        <div class="row">
            <div class="column">
                <h1>Welcome to Splitter</h1>
            </div>
        </div>
        <div class="row">
            <div class="column">
                <split/>
            </div>
            <div class="column">
                <account v-bind:splitter="splitter" v-bind:account="account"/>
            </div>
        </div>
    </div>
</template>

<script>
    import Account from "./account";
    import Split from "./split";
    import contract from 'truffle-contract';
    import Web3 from 'web3';

    export default {
        name: "home",
        components: {Split, Account},
        data() {
            return {splitter: {}, account: ""}
        },
        async mounted() {
            const splitterJson = require("../../build/contracts/Splitter.json");
            if (typeof web3 !== 'undefined') {
                window.web3 = new Web3(web3.currentProvider);
            } else {
                window.web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'));
            }

            let splitterContract = contract(splitterJson);
            splitterContract.setProvider(web3.currentProvider);
            const accounts = await web3.eth.getAccounts();
            if (accounts.length > 0) {
                this.account = accounts[0];
            }

            // TODO: DataCloneError: The object could not be cloned.
            this.splitter = await splitterContract.deployed();
        }
    }
</script>

<style lang="stylus" scoped>
    .myDiv
        color: blue
</style>