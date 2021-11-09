// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.8;

contract Election {

    string public name;
    uint public candidatesCount;
    uint public votersCount;

    // mapping entre le votant et son vote
    mapping(address => Vote) public voters;

    // constructeur
    constructor(string memory _name) public{
        name = _name;
    }
    // This struct represents a candidate
    struct Candidate {
        string name;
        uint id;
        uint votesCount;
    }

    event VoteEvent(uint id, address voterAddress);

    // This struct describes a vote
    struct Vote {
        bool hasVoted;
    }

    // This mapping indexes all candidates
    mapping(uint => Candidate) public candidates;

    // Adds a new candidate to this election
    function addCandidate(string calldata _name) external {
        require (checkNotEmptyName(_name),"The candidate name must not be empty");
        candidates[candidatesCount] = Candidate(_name,candidatesCount,0);
        candidatesCount++;

    }

    // Check if a string isn't empty
    function checkNotEmptyName(string memory _name) private pure returns (bool) {
        return bytes(_name).length > 0;
    }

    // Handles a vote
    function vote(uint _id) public {
        require(checkNotEmptyName(candidates[_id].name),"Candidate ID is too high");
        require(!voters[msg.sender].hasVoted,"You have already voted");
        voters[msg.sender].hasVoted = true;
        votersCount++;
        candidates[_id].votesCount++;
        emit VoteEvent(_id, msg.sender);
    }

    // Gets a candidate's result
    function voteResultForACandidate(uint _id) view public returns (string memory _name, uint _votesCount) {
        return (candidates[_id].name,candidates[_id].votesCount);
    }

    // Counts all votes that occurred in this election
    function countVotes() view public returns (uint totalVotesCount) {
        return votersCount;
    }

}
