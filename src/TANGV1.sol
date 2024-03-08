// SPDX-License-Identifier: MIT LICENSE
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";


contract TANGV1 is ERC20, UUPSUpgradeable, Initializable{

    function initialize() public initializer {
        __ERC20_init("TANGV1", "TANGV1");
        _mint(msg.sender, 1000000000000000000000000000);
    }

    function _authorizeUpgrade(address newImplementation) internal override  {}

    function __ERC20_init(string memory name_, string memory symbol_) internal initializer {
        __Context_init_unchained();
        __ERC20_init_unchained(name_, symbol_);
    }
}