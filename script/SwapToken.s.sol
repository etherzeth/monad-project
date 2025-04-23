// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC20 } from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract SwapToken {
    address public tokenA;
    address public tokenB;
    address public ammWithFee;

    constructor(address _tokenA, address _tokenB, address _ammWithFee) {
        tokenA = _tokenA;
        tokenB = _tokenB;
        ammWithFee = _ammWithFee;
    }

    // Function to perform token swap in AMM
    function swapTokens(uint256 amountIn, address tokenIn, address tokenOut) public {
        // Transfer tokenIn from sender to AMM contract
        IERC20(tokenIn).transferFrom(msg.sender, ammWithFee, amountIn);

        // Call function to swap in AMM
        (bool success, ) = ammWithFee.call(
            abi.encodeWithSignature("swap(address,address,uint256)", tokenIn, tokenOut, amountIn)
        );
        require(success, "Swap failed");
    }
}
