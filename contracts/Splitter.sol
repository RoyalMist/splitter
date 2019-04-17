pragma solidity 0.5.7;

import "./Suspendable.sol";

contract Splitter is Suspendable {
    // Our two friends here with a mapping to keep track of their wealth.
    address private firstFriend;
    address private secondFriend;
    mapping(address => uint) balances;

    // To deal with division remainder.
    uint private bonus;

    event LogLoad(address initiator, uint howMuch, uint bonus);
    event LogWithdraw(address who, uint howMuch);

    // Friends are set directly in the constructor and cannot  be changed afterwards. Valid addresses have to be provided for both of them.
    constructor(address _firstFriend, address _secondFriend) public {
        require(_firstFriend != address(0x0) && _secondFriend != address(0x0), "Please provide valid addresses");
        firstFriend = _firstFriend;
        secondFriend = _secondFriend;
    }

    // Small helper here. Mostly to experiment pure functions.
    function divide(uint amount) private pure returns (uint div, uint rem) {
        div = amount / 2;
        rem = amount % 2;
    }

    // Loading the contract.
    function load() public payable isOwner ifRunning {
        require(msg.value > 0, "Please load contract with sufficient funds");
        (uint divided, uint remainder) = divide(msg.value);
        bonus += remainder;
        balances[firstFriend] += divided;
        balances[secondFriend] += divided;

        // If bonus can be divided by 2 without remainder we can then add this bonus to each friend's wealth.
        if (bonus % 2 == 0) {
            uint split_bonus = bonus / 2;
            balances[firstFriend] += split_bonus;
            balances[secondFriend] += split_bonus;
        }

        emit LogLoad(msg.sender, msg.value, bonus);
    }

    // Withdraw pattern (thanks Rob for the help).
    function withdraw() public ifRunning {
        uint available = balances[msg.sender];
        require(available > 0, "Nothing to withdraw here");
        address(msg.sender).transfer(available);
        emit LogWithdraw(msg.sender, available);
    }
}