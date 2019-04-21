const Splitter = artifacts.require("./Splitter.sol");

contract("Splitter", async accounts => {
    let alice;
    let bob;
    let carol;
    let splitter;

    beforeEach('setup contract for each test', async function () {
        alice = accounts[0];
        bob = accounts[1];
        carol = accounts[2];
        splitter = await Splitter.new({from: alice});
    });

    it("Should allow the owner to transfer ownership", async () => {
        assert.isOk(await splitter.changeOwnership(carol, {from: alice}));
    });

    it("Should disallow a random user to obtain ownership", async () => {
        try {
            await splitter.changeOwnership(bob, {from: bob});
        } catch (e) {
            assert.notEqual(e.message.indexOf("revert"), -1, 'This should be a revert error');
        }
    });
});