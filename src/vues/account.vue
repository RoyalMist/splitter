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
    export default {
        name: "account",
        props: {
            splitter: Object,
            account: String
        },
        data() {
            return {balance: 0, address: ""}
        },
        methods: {
            getBalance: async function (address) {
                this.balance = await this.$props.splitter.consultBalance.call(address);
            },
            myBalance: async function () {
                this.balance = await this.$props.splitter.consultBalance.call(this.$props.account);
            }
        }
    }
</script>

<style scoped>

</style>