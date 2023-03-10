// SPDX-License-Identifier: MIT


// pragma solidity ^0.6.0;
// contract SafeMathTest{

//     uint8 public  bigNumber = 255; //checked

//     function add() public {
//         bigNumber = bigNumber + 1;

       
//     }
// }


pragma solidity ^0.8.0;
contract SafeMathTest{

    uint8 public  bigNumber = 255;

    function add() public {
        //bigNumber = bigNumber + 1;

        // unchecked 
        unchecked { bigNumber = bigNumber + 1;}

        //unchecked : can save Gas
    }
}