// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Compteur {
    uint public compte;

    function incrementer() external {
        compte += 1;
    }
}

interface ICompteur {
    function incrementer() external;

    function compte() external view returns (uint);
}

contract MonContrat {
    function incrementerCompteur(address compteur) external {
        ICompteur(compteur).incrementer();
    }
}
