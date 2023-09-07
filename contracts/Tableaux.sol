// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Tableaux {
    uint[] public arr;
    uint[] public arr2 = [23, 3, 2];
    uint[50000] public arr3;

    function get(uint i) public view returns (uint) {
        return arr[i];
    }

    function push(uint valeur) public {
        arr.push(valeur);
    }

    function pop() public {
        arr.pop();
    }

    function taille() public view returns (uint) {
        return arr.length;
    }

    function remove(uint i) public {
        delete arr[i];
    }

    function fonction1() public view {
        uint x;
        for (uint i = 0; i < arr3.length; i++) {
            uint a = 3 * x;
            x++;
            uint y = x;
        }
    }
}
