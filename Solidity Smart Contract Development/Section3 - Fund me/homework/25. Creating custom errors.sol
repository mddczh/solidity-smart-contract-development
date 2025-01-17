// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract X {
    error ZeroAddress();

    function test() public view {
        if (msg.sender == address(0)) {
        revert ZeroAddress();
        }
    }
}