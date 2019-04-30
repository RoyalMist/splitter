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
                <account></account>
            </div>
        </div>
    </div>
</template>

<script>
    import Account from "./account";
    import Split from "./split";

    export default {
        name: "home",
        components: {Split, Account},
    }
</script>

<style lang="stylus" scoped>
    .myDiv
        color: blue
</style>