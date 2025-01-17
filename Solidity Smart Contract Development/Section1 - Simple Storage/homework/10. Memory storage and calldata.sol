// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract X {
    // storage
    uint256 i = 256;

    function x(string[] memory arr, string calldata str) internal pure returns (string memory){
        arr[0] = str;
        string memory s = "s";
        arr[1] = s;
        return arr[0];
    }
}