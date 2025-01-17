// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import {SimpleStorage} from "./SimpleStorage.sol";
contract AddFiveStorage is SimpleStorage {
    function store(uint256 _newFavoriteNumber) public override {
        myFavoriteNumber = _newFavoriteNumber + 5;
    }
}

