pragma solidity 0.5.7;

import "./Suspendable.sol";
import "./Math.sol";

contract Splitter is Suspendable {
    using Math for uint;

    // Map of address and related wealth.
    mapping(address => uint) balances;

    // To deal with division remainder, contract owner will keep it for him as a gift from users :).
    uint private bonus;

    event LogLoad(address initiator, uint howMuch, uint bonus);
    event LogWithdraw(address who, uint howMuch);
    event LogWithdrawBonus(address who, uint howMuch);

    constructor() Suspendable(true) public {}

    // Loading the contract.
    function splitFunds(address firstRecipient, address secondRecipient) public payable ifRunning {
        require(msg.value > 0, "Please load contract with sufficient funds");
        require(firstRecipient != address(0x0) && secondRecipient != address(0x0), "Please provide valid addresses");
        (uint divided, uint remainder) = msg.value.divide();
        bonus += remainder;
        balances[firstRecipient] = balances[firstRecipient].add(divided);
        balances[secondRecipient] = balances[secondRecipient].add(divided);
        emit LogLoad(msg.sender, msg.value, bonus);
    }

    // Withdraw pattern (thanks Rob for the help).
    function withdraw() public ifRunning {
        uint available = balances[msg.sender];
        require(available > 0, "Nothing to withdraw here");
        address(msg.sender).transfer(available);
        emit LogWithdraw(msg.sender, available);
    }

    // That's owner bonus.
    function withdrawBonus() isOwner ifRunning public {
        require(bonus > 0, "Nothing to withdraw here");
        address(msg.sender).transfer(bonus);
        emit LogWithdrawBonus(getOwner(), bonus);
    }
}