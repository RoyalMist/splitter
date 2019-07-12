pragma solidity 0.5.10;

import "./Suspendable.sol";
import "./Math.sol";

contract Splitter is Suspendable {
    using Math for uint;

    // Map of address and related wealth.
    mapping(address => uint) private balances;

    event LogLoad(address indexed initiator, uint howMuch, uint remainder);
    event LogWithdraw(address indexed who, uint howMuch);
    event LogWithdrawBonus(address indexed who, uint howMuch);

    constructor() Suspendable(true) public {}

    // Loading the contract.
    function splitFunds(address firstRecipient, address secondRecipient) public payable ifRunning {
        require(msg.value > 0, "Please load contract with sufficient funds");
        require(firstRecipient != address(0x0) && secondRecipient != address(0x0), "Please provide valid addresses");
        (uint divided, uint remainder) = msg.value.divide();
        balances[firstRecipient] = balances[firstRecipient].add(divided);
        balances[secondRecipient] = balances[secondRecipient].add(divided);
        if (remainder > 0) {
            address(msg.sender).transfer(remainder);
        }
        emit LogLoad(msg.sender, msg.value, remainder);
    }

    function consultBalance(address who) public view returns (uint balance) {
        balance = balances[who];
    }

    // Withdraw pattern (thanks Rob for the help).
    function withdraw() public ifRunning {
        uint available = balances[msg.sender];
        require(available > 0, "Nothing to withdraw here");
        emit LogWithdraw(msg.sender, available);
        balances[msg.sender] = 0;
        address(msg.sender).transfer(available);
    }

    function kill() external onlyOwner {
        require(address(this).balance <= balances[msg.sender], "Some amount that dopes not belong to you is still to be withdrawn");
        selfdestruct(msg.sender);
    }
}