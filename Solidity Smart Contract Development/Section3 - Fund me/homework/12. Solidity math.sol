//SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;
import {FundMe} from "Solidity Smart Contract Development/Section3 - Fund me/FundMe.sol";

contract X {
    function convertUsdToEth(uint256 usdAmount, uint256 ethPrice) public pure returns(uint256) {
        // 2000
        return usdAmount * 1e18 / ethPrice;
    }
}