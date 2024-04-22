require("@nomicfoundation/hardhat-toolbox");

const NEXT_PUBLIC_POLYGON_MUMBAI_RPC =
  "https://polygon-mumbai.g.alchemy.com/v2/0awa485pp03Dww2fTjrSCg7yHlZECw-K";
const NEXT_PUBLIC_PRIVATE_KEY = "36da8bb76145ca03280c7881f4139b663ed79c2d361d7dd9c4280ed235b90556";
/** @type import('hardhat/config').HardhatUserConfig */

module.exports = {
  solidity: "0.8.17",
  defaultNetwork: "polygon_mumbai",
  networks: {
    hardhat: {},
    polygon_mumbai: {
      url: NEXT_PUBLIC_POLYGON_MUMBAI_RPC,
      accounts: [`0x${NEXT_PUBLIC_PRIVATE_KEY}`],
    },
  },
};
