const path = require("path");

module.exports = {
    contracts_build_directory: path.join(__dirname, "src/contracts"),
    compilers: {
        solc: {
            version: "0.5.10",
        }
    },
    networks: {
        development: {
            host: "127.0.0.1",
            port: 8545,
            network_id: "*",
        }
    }
};