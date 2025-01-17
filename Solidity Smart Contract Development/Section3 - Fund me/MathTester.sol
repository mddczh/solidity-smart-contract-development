// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract X {
    uint8 public bigNum = 255;
    function add() public {
        // bigNum += 1; error
        unchecked {bigNum += 1;} // 0
    }
}