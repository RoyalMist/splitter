pragma solidity 0.5.7;

import "./Ownable.sol";

contract Suspendable is Ownable {
    bool isRunning;

    event LogSuspendable(address who);

    constructor() public {
        isRunning = true;
    }


}
