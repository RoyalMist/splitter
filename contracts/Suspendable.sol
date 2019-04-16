pragma solidity 0.5.7;

import "./Ownable.sol";

contract Suspendable is Ownable {
    bool isRunning;

    event LogSuspend(address who);
    event LogWakeUp(address who);

    modifier ifRunning() {
        require(isRunning);
        _;
    }

    modifier ifSuspended() {
        require(!isRunning);
        _;
    }

    constructor() public {
        isRunning = true;
    }

    function suspend() public isOwner ifRunning {
        isRunning = false;
        emit LogSuspend(msg.sender);
    }

    function wakeUp() public isOwner ifSuspended {
        isRunning = true;
        emit LogWakeUp(msg.sender);
    }
}
