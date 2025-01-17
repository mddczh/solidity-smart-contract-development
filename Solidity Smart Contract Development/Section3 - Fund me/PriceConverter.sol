// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    // Sepolia testnet: ETH / USD
    address internal constant PRICE_FEED_ADDRESS =
        0x694AA1769357215DE4FAC081bf1f309aDC325306;

    function getPrice() internal view returns (uint256) {
        // address
        // abi
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            PRICE_FEED_ADDRESS
        );
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // Price of ETH terms of USD
        // 2000.00000000 * 10000000000
        return uint256(answer) * 1e10;
    }

    function getConversionRate(uint256 ethAmount)
        internal
        view
        returns (uint256)
    {
        // 1 ETH?
        // 2000_000000000000000000
        uint256 ethPrice = getPrice();
        // 2000_000000000000000000 * 2_000000000000000000 / 1e18
        // 4000_000000000000000000
        // $4000 = 2ETH
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function getVersion() internal view returns (uint256) {
        return AggregatorV3Interface(PRICE_FEED_ADDRESS).version();
    }

    function getDecimals() internal view returns (uint8) {
        return AggregatorV3Interface(PRICE_FEED_ADDRESS).decimals();
    }
}
