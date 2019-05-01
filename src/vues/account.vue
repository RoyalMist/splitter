<template>
    <div class="container">
        <div class="row">
            <div class="column">
                <button @click="myBalance()" class="button">My Balance</button>
            </div>
            <div class="column">
                <label>
                    <input placeholder="Address" type="text" v-model="address">
                </label>
            </div>
            <div class="column">
                <button @click="getBalance(address)" class="button">Get Balance</button>
            </div>
        </div>
        <div class="row" v-if="balance > 0">
            <div class="column">
                <h1>Balance: {{balance}}</h1>
            </div>
        </div>
    </div>
</template>

<script>
    import web3 from '../web3';

    export default {
        name: "account",
        props: {
            splitter: Object
        },
        data() {
            return {balance: 0, address: ""}
        },
        methods: {
            getBalance: async (address) => {
                let accounts = await web3.eth.getAccounts();
                console.log(address, accounts);
            },
            myBalance: async () => {
                let accounts = await web3.eth.getAccounts();
                console.log(accounts);
                //let balance = await this.splitter.consultBalance(accounts[0]);
                //console.log(balance);
            }
        }
    }
</script>

<style scoped>

</style>