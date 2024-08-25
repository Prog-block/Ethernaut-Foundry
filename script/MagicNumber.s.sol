// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Script, console} from "forge-std/Script.sol";
import {MagicNumberHack} from "../src/GateKeeperTwo.sol";

contract MagicNumberHack is Script {
    MagicNumberHack public magicNumberHack =
        MagicNumberHack(0x3649efAEd133DE90ecbAe3F71145B4a2428b170b);

    function run() external {
        vm.startBroadcast();

        bytes
            memory code = "\x60\x0a\x60\x0c\x60\x00\x39\x60\x0a\x60\x00\xf3\x60\x2a\x60\x80\x52\x60\x20\x60\x80\xf3";
        address solver;

        assembly {
            solver := create(0, add(code, 0x20), mload(code))
        }
        magicNumberHack.setSolver(solver);

        vm.stopBroadcast();
    }
}
