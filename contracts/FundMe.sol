// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    // Zksync Sepolia testnet: ETH / USD
    address public constant PIRCE_FEED_ADDRESS =
        0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF;

    function getPrice() internal view returns (uint256) {
        // address
        // abi
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            PIRCE_FEED_ADDRESS
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
        return AggregatorV3Interface(PIRCE_FEED_ADDRESS).version();
    }

    function getDecimals() internal view returns (uint8) {
        return AggregatorV3Interface(PIRCE_FEED_ADDRESS).decimals();
    }
}

contract FundMe {
    error NotOwner();

    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18; // non-constant -> constant: gas 746694 - 726333
    // Cost only applies when called by a contract
    // 2402 gas non-constant
    // 347 gas constant

    address public immutable i_owner; // non-immutable -> immutable: gas 726333 - 703150
    // Cost only applies when called by a contract
    // 2552 gas non-immutable
    // 439 gas immutable

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    constructor() {
        i_owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != i_owner) {
            revert NotOwner();
        } // require -> custom error: gas 703138 - 678985
        // 21503
        _;
    }

    // send funds into our contract
    function fund() public payable {
        // Allow users to send $
        // Hava a minimum $ sent 5$
        // 1.How do we send ETH to this contract?
        // msg.value.getConversionRate() = PriceConverter.getConversionRate(msg.value)
        require(
            msg.value.getConversionRate() > MINIMUM_USD,
            "do not send enough ETH"
        );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    // owner can withdraw funds
    function withdraw() public onlyOwner {
        // reset addressToAmountFunded
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // reset funders
        funders = new address[](0);

        // withdraw
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success, "call failed");
    }

    // what happens if someone sends Ether to this contract without calling the `fund` function?

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
