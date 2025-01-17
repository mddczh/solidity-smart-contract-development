// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract X {
    function callAmount(address _addr, uint256 _amount) public {
        (bool success, ) = payable(_addr).call{value: _amount}("");
        require(success, "call failed");
    }
}