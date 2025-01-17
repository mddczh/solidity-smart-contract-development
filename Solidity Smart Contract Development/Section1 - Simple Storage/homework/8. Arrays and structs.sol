// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract X {
    uint256[] arr1;
    uint256[3] arr2;

    struct Animal {
        string name;
        string color;
    }

    Animal[] public animals;

    constructor() {
        animals.push(Animal("cat", "white"));
        animals.push(Animal({name: "dog", color: "block"}));
        animals.push(Animal({name: "pigg", color: "pink"}));
    }

    function addAnimal(string memory _name, string memory _color) external {
        animals.push(Animal(_name, _color));
    }
}