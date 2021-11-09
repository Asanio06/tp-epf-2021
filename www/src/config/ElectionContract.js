import {ethers} from 'ethers'
import Candidate from "../model/Candidate";

let electionContractJson = require('../../../build/contracts/Election.json')

class ElectionContract {
    constructor(electionAddress, etherSigner) {
        this.contract = new ethers.Contract(
            electionAddress,
            electionContractJson.abi,
            etherSigner
        )
    }

    getName() {
    }

    getCandidatesCount() {
    }

    async getCandidate(index) {
        const candidat = await this.contract.getCandidate(index)
        return new Candidate(candidat.id.toNumber(), candidat.name, candidat.votesCount)
    }

    haveVoted(account) {
    }

    addCandidate(name) {
        this.contract.addCandidate(name);
    }

   async castVote(candidateId) {
        this.contract.vote(candidateId);
    }

    onVote(electionId, candidateId, callback) {
        let filter = this.contract.filters.VoteEvent()
        this.contract.on(filter, (address) => {
            callback(address, electionId, candidateId)
        })
    }
}

export default ElectionContract
