const path = require("path");

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  contracts_build_directory: path.join(__dirname, "./client/dist/contracts"),
  networks: {
    development: {
      host: 'localhost',
      port: 8546,
      network_id: 1337,
      gasPrice: 134000000000,
      gas: 4612388
    }
  },
  compilers: {
    solc: {
      version: "0.8.2",    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      settings: {          // See the solidity docs for advice about optimization and evmVersion
       optimizer: {
         enabled: true,
         runs: 200
       },
      //  evmVersion: "byzantium"
       }
    }
  },
};
