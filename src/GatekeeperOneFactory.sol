// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./base/Level.sol";
import "./13-GatekeeperOne.sol";

contract GatekeeperOneFactory is Level {
    function createInstance(
        address _player
    ) public payable override returns (address) {
        _player;
        GatekeeperOne instance = new GatekeeperOne();
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address _player
    ) public view override returns (bool) {
        GatekeeperOne instance = GatekeeperOne(_instance);
        return instance.entrant() == _player;
    }
}
