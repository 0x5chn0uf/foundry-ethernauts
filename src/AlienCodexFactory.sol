// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./base/Level-05.sol";
import "./19-AlienCodex.sol";

contract AlienCodexFactory is Level {
    function createInstance(address _player) public payable override returns (address) {
        _player;
        return address(new AlienCodex());
    }

    function validateInstance(address payable _instance, address _player) public override returns (bool) {
        // _player;
        AlienCodex instance = AlienCodex(_instance);
        return instance.owner() == _player;
    }
}
