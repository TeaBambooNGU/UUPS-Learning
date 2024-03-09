// SPDX-License-Identifier: MIT LICENSE
pragma solidity ^0.8.20;

import {ERC20Upgradeable} from"@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import {ERC20PermitUpgradeable} from"@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20PermitUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";


contract TANGV2 is Initializable, ERC20Upgradeable, ERC20PermitUpgradeable, OwnableUpgradeable, UUPSUpgradeable{
    
    error UUPSUnauthorizedUpdate();
    using Strings for string;
    
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address initialOwner) initializer public {
        __ERC20_init("TANGToken", "TANG");
        __ERC20Permit_init("TANGToken");
        __Ownable_init(initialOwner);
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        view
        onlyOwner
        override
    {
        if(ERC20Upgradeable(newImplementation).name().equal("TANGToken")){
            revert UUPSUnauthorizedUpdate();
        }
    }

    function getVersion() external pure returns (uint256){
        return 2;
    }

}