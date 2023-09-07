// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Erreur {
    function fonctionRequire(uint i) public pure {
        require(i > 10, "i est plus petit que 10");
    }

    function fonctionRevert(uint i) public pure {
        if (i < 10) {
            revert("i est plus petit que 10.");
        }
    }

    function fonctionAssert(uint i) public pure {
        assert(i == 10);
    }
}
