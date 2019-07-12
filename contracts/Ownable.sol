pragma solidity 0.5.10;

contract Ownable {
    address private owner;

    event LogOwnerChanged(address previous, address current);

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor () public {
        owner = msg.sender;
    }

    function getOwner() public view returns (address who) {
        who = owner;
    }

    function changeOwnership(address newOwner) public onlyOwner {
        emit LogOwnerChanged(owner, newOwner);
        owner = newOwner;
    }
}