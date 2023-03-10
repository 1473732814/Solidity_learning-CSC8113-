// SPDX-License-Identifier: MIT

//1. Importing Contracts into other Contracts

pragma solidity ^0.8.7;

//step1:
import "./SimpleStorage.sol"; 

contract StorageFactory {
    


    // Mode I 
    // //step 2
    // SimpleStorage public simpleStorage;
    
    // //step 3
    // function createSimpleStorageContract() public {
    //     simpleStorage = new SimpleStorage();
    // }

    // Mode II
    
    //step 2
    SimpleStorage[] public simpleStorageArray;
    
    //step 3
    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

}