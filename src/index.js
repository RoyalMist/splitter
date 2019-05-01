import Vue from 'vue'
import Home from './home'

require('milligram');

new Vue({
    el: '#app',
    render: h => h(Home)
});
