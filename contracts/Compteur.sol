// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Compteur {
    uint public compte;
    string private alerte = "monAlerte";

    function get() public view returns (uint) {
        uint maVariable = 1;
        return compte + maVariable;
    }

    function incrementer() public {
        compte += 1;
    }

    function decrementer() public {
        compte -= 1;
    }

    function getMyAddress() public view returns (address) {
        return msg.sender;
    }

    function getTimeStamp() public view returns (uint) {
        return block.timestamp;
    }

    //function mesVariables() public {
    //    uint date = block.timestamp;
    //    address moi = msg.sender;
    //}
}
