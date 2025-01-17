// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract X {
    uint256 public constant MONEY = 99999999;

    uint256 public immutable i_money;

    constructor(uint256 _money) {
        i_money = _money;
    }
}