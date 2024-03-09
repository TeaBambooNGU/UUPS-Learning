// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {TANGV1} from "src/TANGV1.sol";
import {TANGV2} from "src/TANGV2.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployTANG is Script {


    function run() public returns(address _tangV1Proxy, address _tangV1, address _tangV2){
        vm.startBroadcast(makeAddr("admin"));
        TANGV1 tangV1 = new TANGV1();
        TANGV2 tangV2 = new TANGV2();
        ERC1967Proxy tangV1Proxy = new ERC1967Proxy(address(tangV1), abi.encodeWithSignature("getVersion()"));
        vm.stopBroadcast();
        return (address(tangV1Proxy), address(tangV1), address(tangV2));
    }
}