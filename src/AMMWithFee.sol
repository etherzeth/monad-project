// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AMMWithFee {
    uint256 public reserve0;
    uint256 public reserve1;
    uint256 public fee = 1; // 1%
    uint256 public totalFeesCollected;
    address public feeCollector;

    event LiquidityAdded(uint256 amount0, uint256 amount1);
    event Swapped(uint256 amount0In, uint256 amount1In, uint256 amount0Out, uint256 amount1Out);

    constructor() {
        feeCollector = msg.sender;
    }

    function addLiquidity(uint256 amount0, uint256 amount1) public {
        reserve0 += amount0;
        reserve1 += amount1;
        emit LiquidityAdded(amount0, amount1);
    }

    function swap(uint256 amount0In, uint256 amount1In) public returns (uint256 amount0Out, uint256 amount1Out) {
        require(amount0In > 0 || amount1In > 0, "Invalid amount");
        require(reserve0 > 0 && reserve1 > 0, "Insufficient reserves");

        uint256 feeAmount0 = (amount0In * fee) / 100;
        uint256 feeAmount1 = (amount1In * fee) / 100;

        uint256 amount0InAfterFee = amount0In - feeAmount0;
        uint256 amount1InAfterFee = amount1In - feeAmount1;

        amount0Out = amount0InAfterFee * reserve1 / reserve0;
        amount1Out = amount1InAfterFee * reserve0 / reserve1;

        reserve0 += amount0In;
        reserve1 += amount1In;

        totalFeesCollected += feeAmount0 + feeAmount1;

        emit Swapped(amount0In, amount1In, amount0Out, amount1Out);
    }

    function removeLiquidity(uint256 amount0, uint256 amount1) public returns (uint256, uint256) {
        require(reserve0 >= amount0 && reserve1 >= amount1, "Insufficient Liquidity");
        reserve0 -= amount0;
        reserve1 -= amount1;
        return (amount0, amount1);
    }
}