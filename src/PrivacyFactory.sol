// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./base/Level.sol";
import "./12-Privacy.sol";

contract PrivacyFactory is Level {
    function createInstance(address) public payable override returns (address) {
        bytes32[3] memory data;
        data[0] = keccak256(abi.encodePacked(tx.origin, "0"));
        data[1] = keccak256(abi.encodePacked(tx.origin, "1"));
        data[2] = keccak256(abi.encodePacked(tx.origin, "2"));
        Privacy instance = new Privacy(data);
        return address(instance);
    }

    function validateInstance(
        address payable _instance,
        address
    ) public view override returns (bool) {
        Privacy instance = Privacy(_instance);
        return instance.locked() == false;
    }
}
