const Math = artifacts.require("Math");
const Splitter = artifacts.require("Splitter");

module.exports = async function (deployer) {
    await deployer.deploy(Math);
    await deployer.deploy(Splitter);
    await deployer.link(Math, Splitter);
};