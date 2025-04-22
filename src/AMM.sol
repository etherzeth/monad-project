// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AMM {
    uint256 public reserve0;
    uint256 public reserve1;

    // Add liquidity function
    function addLiquidity(uint256 amount0, uint256 amount1) public {
        reserve0 += amount0;
        reserve1 += amount1;
    }
    // Swap function (simplified for demo)
    function swap(uint256 amount0In, uint256 amount1In) public returns (uint256 amount0Out, uint256 amount1Out) {
        // Slippage check, formula for swaop
        require(reserve0 > 0 && reserve1 > 0, "Insufficient liquidity to perform swap");

        // Swap calculation, adjust based on logic
        amount0Out = amount0In * reserve1 / reserve0;
        amount1Out = amount1In * reserve0 / reserve1;

        reserve0 += amount0In;
        reserve1 += amount1In;
        
        return (amount0Out, amount1Out);
    }

    // Remove liquidity (simplified)
    function removeLiquidity(uint256 amount0, uint256 amount1) public returns(uint256 amount0Out, uint256 amount1Out) {
        require(reserve0 >= amount0 && reserve1 >= amount1, "Insufficient Liquidity");

        reserve0 -= amount0;
        reserve1 -= amount1;

        return (amount0, amount1);
    }
        
    
}