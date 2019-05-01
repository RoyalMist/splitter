import Web3 from 'web3';

if (window.ethereum) {
    window.web3 = new Web3(ethereum);
    try {
        ethereum.enable();
    } catch (error) {
        console.error(error);
    }
} else if (window.web3) {
    window.web3 = new Web3(web3.currentProvider);
} else {
    console.log(
        'You should install MetaMask!'
    );
}

export default web3;