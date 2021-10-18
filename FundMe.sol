//SPDX-License-Identifier: MIT 

pragma solidity >=0.6.6 <0.9.0;


import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe {
    // Checking for overflow
    using SafeMathChainlink for uint256;
    
    mapping(address => uint256) public addresstoAmountFunded;
    address owner;
    address[] public funders;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function fund() payable public {
        uint256 minimumUSD = 50 * 10 ** 18;
        require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more ETH!");
        addresstoAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
        
        // What if we want to set a min of the amount one can send in USD
        // Need to find the conversion rate fo ETH-USD. But that needs an oracle.
    }
    
    
    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }
    
    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        // Converting to Wei Way lol
         return uint256(answer * 10000000000);
    }
    
    // Convert 1 GWei (suppose) to eth/usd
    function getConversionRate(uint256 _ethAmount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethamountInUSD = (ethPrice * _ethAmount)/1000000000000000000;
        return ethamountInUSD;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner of the contract can withdraw funds sent!");
        // This means run the require statement first and then the rest of the code below _;
        _;
    }
    
    function withdraw() payable onlyOwner public {
        // We need to limit this so that only the owner can call it otherwise everyone will call it and withdraw money
        // from this contract. Owner comes from Constructor

        msg.sender.transfer(address(this).balance);
        
        // Set all the mappings of everyone funded to 0
        for( uint256 fundersIndex = 0; fundersIndex < funders.length; fundersIndex++){
            addresstoAmountFunded[funders[fundersIndex]] = 0;
        }
        
        // Clear the existing array of funders
        funders = new address[](0);
         
     }
}
