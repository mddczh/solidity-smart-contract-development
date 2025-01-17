// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract X {
    uint256[] public numbers;
    function pushNumbers() public {
        for (uint256 i = 1; i <= 10; i++) {
            numbers.push(i);
        }
    }

    function x() public view returns(uint256[] memory) {
        return numbers;
    }
}