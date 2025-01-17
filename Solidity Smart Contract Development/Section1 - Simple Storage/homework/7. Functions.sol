// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract X {

    // In which circumstances a pure function will incur gas costs?
    string public s = "str";
    function p() public pure {
        uint i = 1;
        i += 1;
    }
    // gas 27736   
    function g() public {
        s = "g";
    }
    // gas 27974 
    function gp() public {
        s = "g";
        p();
    }

    function a() private view {}

    function b() external pure {}

    function c() internal view {}
}