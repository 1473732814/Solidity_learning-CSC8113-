// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
// pragma solidity ^0.8.0;
// pragma solidity >=0.8.0 <0.9.0;

contract SimpleStorage {
    // This gets Initialized to Zero
    uint256 favoriteNumber;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }
    
    // view pure
    function retrieve() public view returns (uint256){
        return favoriteNumber;
    }

    // view pure
    function add() public pure returns (uint256){
        return (1+1);
    }
    
}