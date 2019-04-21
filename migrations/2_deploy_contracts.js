const Math = artifacts.require("Math");
const Splitter = artifacts.require("Splitter");

module.exports = async function (deployer) {
    await deployer.deploy(Math);
    await deployer.link(Math, Splitter);
    await deployer.deploy(Splitter);
};