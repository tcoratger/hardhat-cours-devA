import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: {
    compilers: [{ version: "0.8.20" }],
  },
  networks: {
    eth: { chainId: 1, url: "https://rpc.ankr.com/eth/" },
    polygon: { chainId: 137, url: "https://rpc.ankr.com/polygon" },
  },
};

export default config;
