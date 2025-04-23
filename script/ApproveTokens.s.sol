// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC20 } from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "forge-std/Script.sol";

contract ApproveTokens is Script {
    function run() external {
        // claim private key for .env
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        address tokenA = 0x79EBEB76bf49B478783c7CFb2D51098a0bd5B4F2;
        address amm = 0x8b05aE37CB96998247d4CBf6bC94047ceA477E24;

        vm.startBroadcast(privateKey);

        // Approve TokenA and TokenB to AMM
        IERC20(tokenA).approve(amm, type(uint256).max);

        vm.stopBroadcast();
    }   
}
