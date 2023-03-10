// Get funds from users
// Withdraw funds 
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;


import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// import "./AggregatorV3Interface.sol"

contract FundMe {

    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;


    function fund() public  payable {
        // want to be able to set a minimum fund amount in USD
        // 1. How do we sed ETH to this constract?
        //require(msg.value>1e18,"Didn't send enough!"); // 1e18 == 1 * 10 * 18 == 1000000000000000000 wei
        //msg.value: The number of ETH sent by the sender 
        require(getConversionRate(msg.value) >= minimumUsd,"Didn't send enough!"); // 1e18 == 1 * 10 * 18 == 1000000000000000000 wei
        // What is reverting?  : undo any action Beford, and send reifaining gas back
        // msg.sender: sender's Address
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;

    }

    function getPrice() public  view returns (uint256) {
        // ABI
        //Address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int256 price,,,) = priceFeed.latestRoundData();
        // ETH in terms of USD
        // 3000.00000000
        return uint256(price * 1e10);
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public  view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18 ;
        return ethAmountInUsd;
    }


    // function withdraw() {
        
    // }
    
}