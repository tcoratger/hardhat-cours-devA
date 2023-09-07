// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Conditions {
    function monTest(uint x) public pure returns (uint) {
        if (x < 5) {
            return 0;
        } else if (x < 15) {
            return 10;
        } else {
            return 20;
        }
    }

    function monTest1(uint x) public pure returns (uint) {
        return x < 20 ? 10 : 20;
    }

    function monFor() public pure returns (uint) {
        uint compteur;
        for (uint i = 0; i < 30; i++) {
            if (i == 10) {
                continue;
            }
            compteur += 1;
        }
        return compteur;
    }

    function monWhile() public pure returns (uint) {
        uint compteur;
        while (compteur < 100) {
            compteur += 1;
        }
        return compteur;
    }
}
