module.exports = {
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