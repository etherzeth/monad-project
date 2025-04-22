// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Token.sol"; 

import "forge-std/Script.sol";

contract DeployTokenA is Script {
    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(privateKey);
        new Token("BOB DONGO", "BOBI", 1_000_000 ether);
        vm.stopBroadcast();
    }
}
