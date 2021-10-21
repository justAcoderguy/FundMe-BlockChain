
# Fund Me - BlockChain App

A BlockChain crowd funding smart contract made in solidity. This is also my first hands on exposure to development on a blockchain.\
This smart contract allows anyone to call the fund() function and deposit ethereum (min. 50 USD) into the contract but restricts the withdraw() function to only the owner ( which is decided as soon as the contract is published).\
We use chainlink decentralized oracle to get the ETHUSD conversion rate to check if the amount of eth deposited is 50 USD.



## Main Functions

- Fund
- Withdraw

## Helper Functions and DataStructures
- getPrice()
- getVersion()
- getConversionRate()
---
- addressToAmount - Mapping
- funders - Array of addresses

  
## Screenshot

![App Screenshot](https://github.com/justAcoderguy/FundMe-BlockChain/blob/main/FundeMe.png)


  


[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)


  
## 🛠 Technology
Solidity, Ethereum Network & Testnets, Chainlink Oracle Services

  
