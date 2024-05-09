// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    address private contractAddress = 0x85E4Fb433E2A490a00CDc0A9E0779355f3b81164;
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        // address mostRecentlyDeployedBasicNft = DevOpsTools
        //     .get_most_recent_deployment("BasicNft", block.chainid);
        // console.log("get address ", mostRecentlyDeployedBasicNft);
        // mintNftOnContract(mostRecentlyDeployedBasicNft);
        mintNftOnContract(contractAddress);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(PUG);
        vm.stopBroadcast();
    }
}
