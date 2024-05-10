// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {stdJson} from "forge-std/StdJson.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {Script, console2} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";


contract MintBasicNFT is Script {
    string private constant TOKEN_URI =
        "https://ipfs.io/ipfs/QmfNN5LKRtjy4p9eaQbAZMiFzWhn6dtS3u8tf2WVNJX996?filename=BasicNFTMetadata.json";

    function run() external {
        console2.log("Start MintBasicNFT ");
        address recentlyDeployedBasicNFTContract = getDeployedContractAddress();
        console2.log("The returned address is: ", recentlyDeployedBasicNFTContract);
        mintBasicNFT(recentlyDeployedBasicNFTContract);
    }

    function getDeployedContractAddress() private view returns (address) {
        string memory path = string.concat(
            vm.projectRoot(),
            "/broadcast/DeployBasicNft.s.sol/",
            Strings.toString(block.chainid),
            "/run-latest.json"
        );
        string memory json = vm.readFile(path);
        bytes memory contractAddress = stdJson.parseRaw(
            json,
            ".transactions[0].contractAddress"
        );
        return (bytesToAddress(contractAddress));
    }

    function bytesToAddress(
        bytes memory bys
    ) private pure returns (address addr) {
        assembly {
            addr := mload(add(bys, 32))
        }
    }

    function mintBasicNFT(address _basicNFTcontractAddress) public {
        vm.startBroadcast();
        console2.log("Minting of the BasicNFT is about to commence on chain: ", block.chainid);
        console2.log("The passed in tokenURI is: ", TOKEN_URI);
        console2.log("The passed in address is: ", _basicNFTcontractAddress);

        
        BasicNft(_basicNFTcontractAddress).mintNft(TOKEN_URI);
        console2.log("I ran till this point");
        vm.stopBroadcast();

        uint256 yourNFTId = BasicNft(_basicNFTcontractAddress).getTokenCounter() - 1;

        console2.log("The Id of your minted BasicNFT token is: ", yourNFTId);
    }
}



contract MintMoodNft is Script {

    function run() external {
        console2.log("Start MintMoodNft ");
        address recentlyMoodNftContract = getDeployedContractAddress();
        console2.log("The returned address is: ", recentlyMoodNftContract);
        mintNftOnContract(recentlyMoodNftContract);
    }

    function getDeployedContractAddress() private view returns (address) {
        string memory path = string.concat(
            vm.projectRoot(),
            "/broadcast/DeployMoodNft.s.sol/",
            Strings.toString(block.chainid),
            "/run-latest.json"
        );
        string memory json = vm.readFile(path);
        bytes memory contractAddress = stdJson.parseRaw(
            json,
            ".transactions[0].contractAddress"
        );
        return (bytesToAddress(contractAddress));
    }

    function bytesToAddress(
        bytes memory bys
    ) private pure returns (address addr) {
        assembly {
            addr := mload(add(bys, 32))
        }
    }

    function mintNftOnContract(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).mintNft();
        vm.stopBroadcast();
    }
}


contract FlipMoodNft is Script {
    uint256 public constant TOKEN_ID_TO_FLIP = 0;
    function run() external {
        address recentlyMoodNftContract = getDeployedContractAddress();
        flipMoodNft(recentlyMoodNftContract);
    }

    function flipMoodNft(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).flipMood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }


    function getDeployedContractAddress() private view returns (address) {
        string memory path = string.concat(
            vm.projectRoot(),
            "/broadcast/DeployMoodNft.s.sol/",
            Strings.toString(block.chainid),
            "/run-latest.json"
        );
        string memory json = vm.readFile(path);
        bytes memory contractAddress = stdJson.parseRaw(
            json,
            ".transactions[0].contractAddress"
        );
        return (bytesToAddress(contractAddress));
    }

    function bytesToAddress(
        bytes memory bys
    ) private pure returns (address addr) {
        assembly {
            addr := mload(add(bys, 32))
        }
    }

}