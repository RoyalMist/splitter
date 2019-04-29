<template>
    <div class="myDiv">Hello {{appName}}</div>
</template>

<script>
    export default {
        name: "Splitter",
        data() {
            return {
                appName: "Splitter"
            }
        }
    }
</script>

<style lang="stylus" scoped>
    .myDiv
        color: blue
</style>