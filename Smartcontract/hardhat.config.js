require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config()


module.exports = {
  solidity: "0.8.17",
  networks: {
    baobab: {
      url: "https://klaytn-baobab.blockpi.network/v1/rpc/3fd614df10af5487e67aa62d97bc114b51f3a706",
      chainId: 1001,
      accounts: ["0389d72491ccb7092bcd453fd96d28f553820bfac9c59b069efd61ddc0010944"],
      blockConfirmations: 6,
    }
  },
  etherscan: {
    apiKey: {
      baobab: "unnecessary",
    },
    customChains: [
      {
        network: "baobab",
        chainId: 1001,
        urls: {
          apiURL: "https://api-baobab.klaytnscope.com/api",
          browserURL: "https://baobab.klaytnscope.com",
        },
      },
    ]
  },
  sourcify: {
    enabled: false
  }
};