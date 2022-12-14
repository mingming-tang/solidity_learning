require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: "https://goerli.infura.io/v3/0b3989b7816f4feeae0d0cc02e3b78dd",
      accounts: ["28f15f13b5d279a55a49c33b9ae78232827fa6a63f5e18a5d35548e31a2d56bb"]
    }
  }
};
