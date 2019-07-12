pragma solidity 0.5.10;

library Math {

    function add(uint a, uint b) public pure returns (uint res) {
        res = a + b;
        require(res >= a && res >= b, "Something went wrong here");
        return res;
    }

    function divide(uint amount) public pure returns (uint div, uint rem) {
        div = amount / 2;
        rem = amount % 2;
    }
}
