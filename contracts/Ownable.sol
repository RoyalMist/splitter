pragma solidity 0.5.6;

contract Ownable {
    address public owner;

    event LogOwnerChanged(address previous, address current);

    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor () public {
        owner = msg.sender;
    }

    function changeOwnership(address newOwner) public isOwner returns (bool success) {
        LogOwnerChanged(owner, newOwner);
        owner = newOwner;
        success = true;
    }
}