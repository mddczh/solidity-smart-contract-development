// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Mapping {
    mapping(string => uint256) addressToBalance;

    function add(string calldata _key, uint256 value) public {
        addressToBalance[_key] = value;
    }

    function retrieve(string calldata _key) public view returns (uint256) {
        return addressToBalance[_key];
    } 
}