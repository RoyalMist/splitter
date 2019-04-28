const truffleAssert = require('truffle-assertions');
const assert = require("chai").assert;
const splitterContract = artifacts.require("./Splitter.sol");

contract("Splitter", async (accounts) => {
    let alice;
    let bob;
    let carol;
    let currentOwner; //Used for cleanup in afterEach.
    let splitter;

    beforeEach('setup contract for each test', async () => {
        alice = accounts[0];
        bob = accounts[1];
        carol = accounts[2];
        currentOwner = alice;
        splitter = await splitterContract.new({from: currentOwner});
    });

    /*
     * Ownable part.
     */
    it("should allow the owner to transfer ownership", async () => {
        let ownership = await splitter.changeOwnership(carol, {from: currentOwner});
        currentOwner = carol;
        truffleAssert.eventEmitted(ownership, 'LogOwnerChanged', (ev) => {
            return ev.previous === alice && ev.current === carol;
        });
    });

    it("should disallow a random user to change ownership", async () => {
        await truffleAssert.fails(splitter.changeOwnership(carol, {from: bob}));
    });

    /*
     * Suspendable part.
     */
    it("should be possible to the owner to suspend the splitter", async () => {
        let suspend = await splitter.suspend({from: currentOwner});
        truffleAssert.eventEmitted(suspend, 'LogSuspend', (ev) => {
            return ev.who === currentOwner;
        });
    });

    it("should be possible to the owner to wake up the splitter", async () => {
        await splitter.suspend({from: currentOwner});
        let suspend = await splitter.wakeUp({from: currentOwner});
        truffleAssert.eventEmitted(suspend, 'LogWakeUp', (ev) => {
            return ev.who === currentOwner;
        });
    });

    it("should be impossible to a non owner to suspend or wake up the splitter", async () => {
        await truffleAssert.fails(splitter.suspend({from: bob}));
        await truffleAssert.fails(splitter.wakeUp({from: bob}));
    });

    it('should fail the splitFunds call when contract is suspended', async () => {
        await splitter.suspend({from: currentOwner});
        await truffleAssert.fails(splitter.splitFunds(bob, carol, {from: alice, value: 10}));
    });

    it('should fail the withdraw call when contract is suspended', async () => {
        await splitter.suspend({from: currentOwner});
        await truffleAssert.fails(splitter.withdraw({from: alice}));
    });

    /*
     * Splitter part.
     */
    it('should be impossible to split 0 wei', async () => {
        await truffleAssert.fails(splitter.splitFunds(bob, carol, {from: alice, value: 0}));
    });

    it('should be impossible to split an amount to incorrect addressees', async () => {
        const zeroAddress = "0x0000000000000000000000000000000000000000";
        await truffleAssert.fails(splitter.splitFunds(zeroAddress, zeroAddress, {from: alice, value: 10}));
        await truffleAssert.fails(splitter.splitFunds(bob, zeroAddress, {from: alice, value: 10}));
        await truffleAssert.fails(splitter.splitFunds(zeroAddress, carol, {from: alice, value: 10}));
    });

    it('should split in two equal parts to the correct targets the amount', async () => {
        let result = await splitter.splitFunds(bob, carol, {from: alice, value: 10});
        truffleAssert.eventEmitted(result, 'LogLoad', (ev) => {
            return ev.initiator === alice && ev.howMuch === 10 && ev.remainder === 0;
        });

        let bobBalance = await splitter.consultBalance(bob);
        let carolBalance = await splitter.consultBalance(carol);
        assert.equal(bobBalance, 5);
        assert.equal(carolBalance, 5);
    });
});
