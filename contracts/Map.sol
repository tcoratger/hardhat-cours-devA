// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Map {
    mapping(address => uint) public monMap;
    mapping(address => mapping(uint => bool)) public monMap1;

    function get(address addr) public view returns (uint) {
        return monMap[addr];
    }

    function set(address addr, uint valeur) public {
        monMap[addr] = valeur;
    }

    function remove(address addr) public {
        delete monMap[addr];
    }

    function get1(address addr, uint monInt) public view returns (bool) {
        return monMap1[addr][monInt];
    }

    function set1(address addr, uint monInt, bool valeur) public {
        monMap1[addr][monInt] = valeur;
    }

    function remove1(address addr, uint monInt) public {
        delete monMap1[addr][monInt];
    }
}
