// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract X {
    uint256 public i;

    receive() external payable {
        i += 1;
    }

    fallback() external payable {
        i += 10;
    }
}