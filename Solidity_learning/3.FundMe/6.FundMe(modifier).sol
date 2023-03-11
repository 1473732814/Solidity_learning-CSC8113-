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

    address public owner;

    //Constructors : Creating a contract will be called once immediately
    constructor(){
        owner = msg.sender;
    }


    function fund() public  payable {
        // msg.value.getConversionRate();
        require(msg.value.getConversionRate() >= minimumUsd,"Didn't send enough!"); // 1e18 == 1 * 10 * 18 == 1000000000000000000 wei

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;

    }

    
    // Withdraw funds 
    function withdraw() public onlyOwner{
        //Ensure that the withdraw function can only be called by the contract owner ----- BY   modifier

        require(msg.sender == owner,"Sender is not owner!!");
        //for loop
        for(uint256 i = 0; i < funders.length; i ++ ){

           address funder =  funders[i];
           addressToAmountFunded[funder] = 0 ;
        }
        // reset the arry
        funders = new address[](0);
        // actually withdraw the funds

        // Recommended call
        //call : return  bool or bytes , Using "require" roll backe 
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess,"Call failed");

    }

    modifier onlyOwner {
        require(msg.sender == owner,"Sender is not owner!!");
        _; //Underlined code to run the rest of the code
    }
    
    
}