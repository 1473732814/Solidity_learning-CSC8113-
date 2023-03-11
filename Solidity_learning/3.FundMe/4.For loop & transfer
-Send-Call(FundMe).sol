// SPDX-License-Identifier: MIT


// Library
// Libraries are similar to contracts, but you can't declare any state variable and you can't send ether.
// A library is embedded into the contract if all library functions are internal.
// Otherwise the library must be deployed and then linked before the contract is deployed.

pragma solidity ^0.8.7;

import "./PriceConverter.sol";

// import "./AggregatorV3Interface.sol"

contract FundMe {

    using PriceConverter for uint256;
    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;


    function fund() public  payable {
        // msg.value.getConversionRate();
        require(msg.value.getConversionRate() >= minimumUsd,"Didn't send enough!"); // 1e18 == 1 * 10 * 18 == 1000000000000000000 wei

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;

    }

    


    // Withdraw funds 
    // For loop

    function withdraw() public {
        //for loop
        for(uint256 i = 0; i < funders.length; i ++ ){

            //code
           address funder =  funders[i];
           addressToAmountFunded[funder] = 0 ;
        }
        // reset the arry
        funders = new address[](0);
        // actually withdraw the funds

    // transfer (2300 gas, throws error)
    // send (2300 gas, returns bool)
    // call (forward all gas or set gas, returns bool)

        // //transfer  :  roll back if execution fails       
        // payable(msg.sender).transfer(address(this).balance);   // msg.sender = address ; payable(msg.sender) = payable address
        // //send : return  bool , Using "require" roll backe 
        // bool sendSuccess = payable(msg.sender).send(address(this).balance); 
        // require(sendSuccess,"Send failed");
        
        // Recommended call
        //call : return  bool or bytes , Using "require" roll backe 
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess,"Call failed");

    }
    
}