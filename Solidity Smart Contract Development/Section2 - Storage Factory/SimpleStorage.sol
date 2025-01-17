// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26; //solidity versions

contract SimpleStorage{
    // favoriteNumber is initialized to 0 if no value is given
    uint256 myFavoriteNumber;

    // uint256[] list_of_favorite_number;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }


    // dynamic array
    Person[] public friendsList; //[]

    // chelsea -> 232
    mapping(string => uint256) nameToFavoriteNumber;

    function store(uint256 _myFavoriteNumber) public virtual {
        myFavoriteNumber = _myFavoriteNumber;
    }

    // view, pure
    function retrieve() public view returns (uint256) {
        return myFavoriteNumber;
    }

    // calldata, memory, storage
    function addPerson(uint256 _favoriteNumber, string calldata _name) public  {
        friendsList.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}