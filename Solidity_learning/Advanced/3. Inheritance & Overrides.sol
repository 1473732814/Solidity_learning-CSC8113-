// SPDX-License-Identifier: MIT
// 3.  Inheritance & Overrides
pragma solidity ^0.8.7;

// step 1
import "./SimpleStorage.sol";

// Inheritance : use "is" keywords
contract ExtraStorage is SimpleStorage {
    // Overrides: use "virtual"  , "override"  Keywords
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}
