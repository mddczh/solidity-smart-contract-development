// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract X {
    modifier onlyAfter(uint256 _time) {
        require(_time > block.timestamp, "time < block timestamp");
        _;
    }

    function run(uint256 _time) public onlyAfter(_time) {
        // function logic
    }
}