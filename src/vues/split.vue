<template>
    <div class="container">
        <div class="row">
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
        data() {
            return {
                firstAddress: "",
                secondAddress: ""
            }
        },
        methods: {
            split: (firstAddress, secondAddress) => {
                alert(firstAddress);
                alert(secondAddress);
            }
        }
    }
</script>

<style scoped>

</style>