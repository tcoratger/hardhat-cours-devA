// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Visibilite {
    uint private uintPrive = 1;
    uint internal uintInterne = 1;
    uint public uintPublic = 1;

    function fonctionPrivee() private pure returns (string memory) {
        return "Ma fonction privee";
    }

    function fonctionInterne() internal pure returns (string memory) {
        return "Ma fonction interne";
    }

    function fonctionExterne() external pure returns (string memory) {
        return "Ma fonction externe";
    }

    function fonctionPublique() public pure returns (string memory) {
        return "Ma fonction publique";
    }
}

contract Visibilite1 is Visibilite {}
