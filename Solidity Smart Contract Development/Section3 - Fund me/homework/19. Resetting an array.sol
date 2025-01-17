// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract X {
    uint256[] public numbers = [1, 2, 3, 4];
    function expensiveReset() public {
        for (uint256 i = 0; i < numbers.length; i++) 
        {
            numbers[i] = 0;
        }
    }
    function x() public view returns(uint256[] memory) {
        return numbers;
    } 
}