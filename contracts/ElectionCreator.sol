// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.8;

import "../contracts/Election.sol";

contract ElectionCreator {
    uint public electionsCount;
    mapping(uint => address) public electionList;

    event ElectionCreated(address electionAddress);

    // Creates an election contract and emits the according event
    function newElection(string calldata _name) external {
        address newElectionAddress = address(new Election(_name));
        electionList[electionsCount] = newElectionAddress;
        electionsCount++;
        emit ElectionCreated(newElectionAddress);
    }
}
