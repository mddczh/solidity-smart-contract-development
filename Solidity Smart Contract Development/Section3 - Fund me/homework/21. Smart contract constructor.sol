// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract X {
    address public owner;
    constructor() {
        owner = msg.sender;
    }

    function withdrawOnlyFirstAccountRemix() public {
        require(owner == msg.sender, "not owner");
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "call failed");
    }
}