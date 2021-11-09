// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.8;

import "../contracts/Election.sol";

contract ElectionCreator {
    uint public electionsCount;
    mapping(uint => address) public electionList;

    // Creates an election contract and emits the according event
    function newElection(string calldata _name) external {
        electionList[electionsCount] = address (new Election(_name));
        electionsCount++;
    }
}
