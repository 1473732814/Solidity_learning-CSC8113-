// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
// pragma solidity ^0.8.0;
// pragma solidity >=0.8.0 <0.9.0;

contract SimpleStorage {
    // boolean, uint, int, address, bytes
    bool hasFavoriteNumber = true; 
    uint256 favoriteNumber = 5; 
    string favoriteNumberInText = "Five"; 
    int256 favoriteInt = -5; 
    address myAddress = 0xbab4b26bADEc52A17FeB95f6D8790c10C6FD922b; 
    bytes32 favoriteBytes = "dog";

}