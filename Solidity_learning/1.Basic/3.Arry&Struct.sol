// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
// pragma solidity ^0.8.0;
// pragma solidity >=0.8.0 <0.9.0;

contract SimpleStorage {

    uint256 favoriteNumber;

    People public  person = People({favoriteNumber:2,name:"demo"});

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    // uint256[] public anArray;
    People[] public people;


    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        // People memory newPerson = People(_favoriteNumber,_name);
        // people.push(newPerson);
        people.push(People(_favoriteNumber, _name));
    }
}
