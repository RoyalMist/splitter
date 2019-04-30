<template>
    <div class="container">
        <div class="row">
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
    let balance = 0;

    export default {
        name: "account",
        data: balance,
        methods: {
            getBalance: (address) => {
                alert(address);
            }
        }
    }
</script>

<style scoped>

</style>