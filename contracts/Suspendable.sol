pragma solidity 0.5.10;

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

    constructor(bool running) public {
        isRunning = running;
    }

    function suspend() public onlyOwner ifRunning {
        isRunning = false;
        emit LogSuspend(msg.sender);
    }

    function wakeUp() public onlyOwner ifSuspended {
        isRunning = true;
        emit LogWakeUp(msg.sender);
    }
}
