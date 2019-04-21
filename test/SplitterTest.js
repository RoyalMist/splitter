const Splitter = artifacts.require("./Splitter.sol");

contract("Splitter", async accounts => {
    it("Should put the caller as owner", async () => {
        let instance = await Splitter.deployed();
        console.log(accounts);
        assert.equal(10, 20 / 2);
    });
});