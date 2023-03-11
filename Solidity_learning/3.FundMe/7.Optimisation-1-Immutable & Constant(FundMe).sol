// SPDX-License-Identifier: MIT


// USing Immutable & Constant, instead of storing these variables in a memory slot,
// stores them directly in the contract bytecode

pragma solidity ^0.8.7;

import "./PriceConverter.sol";

// import "./AggregatorV3Interface.sol"

contract FundMe {

    using PriceConverter for uint256;
    // USing  Immutable & Constant Reduce Gas 
    // non-Immutable & Constant 825,536 gas
    // Using Immutable & Constant : 781750 gas

   // Using Constant : 806001 gas
    uint256 public constant  MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    // non-immutable : 806001 gas
    //immutable : 781750 gas
    address public  immutable  OWNER;

    //Constructors : Creating a contract will be called once immediately
    constructor(){
        OWNER = msg.sender;
    }


    function fund() public  payable {
        // msg.value.getConversionRate();
        require(msg.value.getConversionRate() >= MINIMUM_USD,"Didn't send enough!"); // 1e18 == 1 * 10 * 18 == 1000000000000000000 wei

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;

    }

    
    // Withdraw funds 
    function withdraw() public onlyOwner{
        //Ensure that the withdraw function can only be called by the contract owner ----- BY   modifier

        require(msg.sender == OWNER,"Sender is not owner!!");
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

    // Modifier
    modifier onlyOwner {
        require(msg.sender == OWNER,"Sender is not owner!!");
        _; //Underlined code to run the rest of the code
    }
    
    
}