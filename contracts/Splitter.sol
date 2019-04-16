pragma solidity 0.5.7;

import "./Suspendable.sol";

contract Splitter is Suspendable {
    address payable private firstFriend;
    address payable private secondFriend;

    event LogFriendAdded(address who);
    event LogSplit(address first, address second, uint howmuch);

    modifier areFriendsThere() {
        require(firstFriend != address(0x0) && secondFriend != address(0x0));
        _;
    }

    function setFirstFriend(address payable who) public isOwner ifRunning {
        firstFriend = who;
        emit LogFriendAdded(who);
    }

    function setSecondFriend(address payable who) public isOwner ifRunning {
        secondFriend = who;
        emit LogFriendAdded(who);
    }

    function viewFriends() view public returns (address first, address second) {
        first = firstFriend;
        second = secondFriend;
    }

    function getBalance() public view returns (uint balance) {
        balance = address(this).balance;
    }

    function split() public payable areFriendsThere isOwner ifRunning returns (bool status) {
        uint splitAmount = getBalance() / 2;
        firstFriend.transfer(splitAmount);
        secondFriend.transfer(splitAmount);
        emit LogSplit(firstFriend, secondFriend, splitAmount);
        status = true;
    }
}