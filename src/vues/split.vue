<template>
    <div class="container">
        <div class="row">
            <div class="column">
                <label>
                    <input placeholder="Amount" type="text" v-model="amount">
                </label>
            </div>
            <div class="column">
                <label>
                    <input placeholder="First Address" type="text" v-model="firstAddress">
                </label>
            </div>
            <div class="column">
                <label>
                    <input placeholder="Second Address" type="text" v-model="secondAddress">
                </label>
            </div>
            <div class="column">
                <button @click="split(firstAddress, secondAddress)" class="button">Split</button>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "split",
        props: {
            splitter: Object,
            account: String
        },
        data() {
            return {
                amount: 0,
                firstAddress: "",
                secondAddress: ""
            }
        },
        methods: {
            split: (amount, firstAddress, secondAddress) => {
                if (firstAddress !== "" && secondAddress !== "") {
                    this.$props.splitter.splitFunds(firstAddress, secondAddress, {from: this.account, value: amount});
                }
            }
        }
    }
</script>

<style scoped>

</style>