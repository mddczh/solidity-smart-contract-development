// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
contract X {
    function getLatestBTCPriceInETH() public view returns(uint256) {
        // sepolia BTC/ETH
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5fb1616F78dA7aFC9FF79e0371741a747D2a7F22);
        uint256 decimal = priceFeed.decimals();
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer) * (10 ** (18 - decimal));
    }
}