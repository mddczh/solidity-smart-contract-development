// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;


import {SimpleStorage} from "./SimpleStorage.sol";
// import {SimpleStorage, SimpleStorage} from "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public listOfSimpleStorageContracts;

    function createSimpleStorageContract() public {
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        listOfSimpleStorageContracts.push(newSimpleStorageContract);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        // address
        // ABI - Application Binary Interface
        SimpleStorage simpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];
        simpleStorage.store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        SimpleStorage simpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];
        return simpleStorage.retrieve();
    }
}