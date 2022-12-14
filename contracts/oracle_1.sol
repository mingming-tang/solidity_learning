// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract EthereumPrice {
    struct FeedPrice {
        address feeder;
        uint price;
    }

    mapping(address => uint) public balances;

    string public publicName;

    uint public currentPrice;

    uint lastUpdateBlockNumber;
    string name;

    FeedPrice[] feedPriceList;

    function feed(uint feedPrice) public {
        feedPriceList.push(FeedPrice({ feeder: msg.sender, price: feedPrice }));
    }

    function getFeedPriceList() public view returns (FeedPrice[] memory) {
        return feedPriceList;
    }

    // function getName() public view returns (string memory) {
    //     return name;
    // }

    // function setName(string memory name_) public {
    //     name = name_;
    // }

    function getLastUpdateBlockNumber() public view returns (uint) {
        return lastUpdateBlockNumber;
    }

    function _updateCurrentPrice() internal {
        require(feedPriceList.length > 0, "feedPriceList length is zero");
        uint priceSum = 0;
        for (uint i = 0; i < feedPriceList.length; i++) {
            priceSum += feedPriceList[i].price;
        }
        uint avgPrice = priceSum / feedPriceList.length;

        for (uint i = 0; i < feedPriceList.length; i++) {
            uint diff = 0;
            if (feedPriceList[i].price > avgPrice) {
                diff = feedPriceList[i].price - avgPrice;
            }else {
                diff = avgPrice = feedPriceList[i].price;
            }
            address feeder = feedPriceList[i].feeder;
            uint feederBalance = balances[feeder];
            if (diff > 10) {
                uint fine = 10;
                if (feeder.balance >= fine) {
                    balances[feeder] = feederBalance - fine;
                }
            }else {
                balances[feeder] = feederBalance + 20;
            }
        }
        currentPrice = avgPrice;

    }

    function update() public {
        require(lastUpdateBlockNumber!=block.number, "lastUpdateBlockNumber equal current block number");
        _updateCurrentPrice();
        uint senderBalance = balances[msg.sender];
        balances[msg.sender] = senderBalance + 1;
        delete feedPriceList;
        lastUpdateBlockNumber = block.number;
    }

    function balance() public view returns (uint) {
        return balances[msg.sender];
    }

    function balanceOf(address user) public view returns (uint) {
        return balances[user];
    }
}
