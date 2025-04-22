// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/AMM.sol";

contract AMMTest is Test {
    AMM amm;

    function setUp() public {
        amm = new AMM();
    }

    function testAddLiquidity() public {
        amm.addLiquidity(100, 100);
        assertEq(amm.reserve0(), 100);
        assertEq(amm.reserve1(), 100);

    }

    function testSwap() public {
        amm.addLiquidity(100, 100);
        (uint256 amount0Out, uint amount1Out) = amm.swap(10, 0);
        assert(amount0Out > 0);
        assert(amount1Out == 0);
    }
}