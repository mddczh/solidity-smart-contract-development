// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

library MathLibrary {
    function sum(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }
}

contract X {
    using MathLibrary for uint256;
    uint256 public a = 1;
    uint256 public  b = 2;
    uint256 public  sumNum = a.sum(b);
}