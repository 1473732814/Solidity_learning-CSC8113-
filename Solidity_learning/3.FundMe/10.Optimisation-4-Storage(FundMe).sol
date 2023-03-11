// SPDX-License-Identifier: MIT


// Stroage :
//https://github.com/crytic/evm-opcodes
//Use Storage Optimisation to save gas.

pragma solidity ^0.8.7;

import "./PriceConverter.sol";

error NotOwner();

contract FundMe {

    using PriceConverter for uint256;

    uint256 public constant  MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;


    address public  immutable  OWNER;


    constructor(){
        OWNER = msg.sender;
    }


    function fund() public  payable {

        require(msg.value.getConversionRate() >= MINIMUM_USD,"Didn't send enough!"); // 1e18 == 1 * 10 * 18 == 1000000000000000000 wei

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;

    }

    
    // // Withdraw funds 
    // function withdraw() public onlyOwner{
    //     require(msg.sender == OWNER,"Sender is not owner!!");
    //     //for loop
    //     for(uint256 i = 0; i < funders.length; i ++ ){

    //        address funder =  funders[i];
    //        addressToAmountFunded[funder] = 0 ;
    //     }
    //     // reset the arry
    //     funders = new address[](0);
    //     // actually withdraw the funds

    //     // Recommended call
    //     //call : return  bool or bytes , Using "require" roll backe 
    //     (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
    //     require(callSuccess,"Call failed");

    // }

    // cheaper Withdraw funds 
    function cheaperWithdraw() public onlyOwner{
        require(msg.sender == OWNER,"Sender is not owner!!");
        
        address[] memory newfunders = funders;
        //for loop
        for(uint256 i = 0; i < newfunders.length; i ++ ){

           address funder =  newfunders[i];
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
        //require(msg.sender == OWNER,"Sender is not owner!!");

        if(msg.sender != OWNER){
            revert  NotOwner();
        }
        _; 
    }


    //receive()  
    receive() external payable {
        fund();
    } 
    //fallback()
    fallback() external payable {
        fund();
    } 
    
}