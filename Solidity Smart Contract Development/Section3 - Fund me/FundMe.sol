// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
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
