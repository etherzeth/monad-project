// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/AMMWithFee.sol";

contract AMMWithFeeTest is Test {
    AMMWithFee amm;

    function setUp() public {
        amm = new AMMWithFee();
    }

    function testAddLiquidity() public {
        amm.addLiquidity(1000, 1000);
        assertEq(amm.reserve0(), 1000);
        assertEq(amm.reserve1(), 1000);
    }

    function testSwapWithFee() public {
        amm.addLiquidity(1000, 1000);
        (uint256 amount0Out, uint256 amount1Out) = amm.swap(100, 0);

        assert(amount0Out > 0);
        assertEq(amount1Out, 0);

        assertEq(amm.totalFeesCollected(), 1); // 1% 
    }

    function testSwapWithFeeAmount1In() public {
        amm.addLiquidity(1000, 1000);
        (uint256 amount0Out, uint256 amount1Out) = amm.swap(0, 200);

        assertEq(amount0Out, 0);
        assertGt(amount1Out, 0);

        assertEq(amm.totalFeesCollected(), 2); // 1% dari 200
    }
}