<template>
    <div class="myDiv">Hello {{appName}}</div>
</template>

<script>
    export default {
        name: "home",
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