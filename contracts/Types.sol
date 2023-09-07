// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Types {
    bool public testBool = true;
    bool public defautBool;

    uint public monUint = 32;
    uint256 public monUint1 = 32;
    uint8 public monUint2 = 32;
    uint public defautUint;

    int public monint = -32;
    int256 public monint1 = 32;
    int8 public monint2 = 32;
    int public defautInt;

    int public maxInt = type(int).max;
    int public minInt = type(int).min;

    address public addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public defautAddr;

    // Constantes
    address public constant constAddr =
        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    address public immutable MonAddressIm;

    constructor(uint monUnitInit, address monAddressInit) {
        defautUint = monUnitInit;
        MonAddressIm = monAddressInit;
    }
}
