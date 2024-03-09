// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test,console} from "forge-std/Test.sol";
import {TANGV1,TANGV2,DeployTANG,ERC1967Proxy} from "script/deployTANG.s.sol";

contract TANGUpgradeTest is Test {

    TANGV1 tangV1;
    TANGV2 tangV2;
    ERC1967Proxy tangProxy;

    function setUp() public {
        DeployTANG deployTANG = new DeployTANG();
        (address _tangV1Proxy, address _tangV1, address _tangV2) = deployTANG.run();
        tangV1 = TANGV1(_tangV1);
        tangV2 = TANGV2(_tangV2);
        tangProxy = ERC1967Proxy(payable(_tangV1Proxy));
    }


    function testUpgrade() public {
        uint256 version = TANGV1(address(tangProxy)).getVersion();
        console.log("TANGV1 version: ", version);
        assertEq(version, 1);

        vm.prank(TANGV1(address(tangProxy)).owner());
        TANGV1(address(tangProxy)).transferOwnership(msg.sender);

        vm.prank(TANGV1(address(tangProxy)).owner());
        TANGV1(address(tangProxy)).upgradeToAndCall(address(tangV2),abi.encodeWithSignature("initialize(address)",msg.sender));

        version = TANGV1(address(tangProxy)).getVersion();
        console.log("TANGV2 version: ", version);
        assertEq(version, 2);

    }
}