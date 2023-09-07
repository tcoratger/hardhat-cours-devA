// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract GestionLocations {
    address public proprietaire;
    address[] public listeLocataires;

    constructor() {
        proprietaire = msg.sender;
    }

    modifier seulementProprietaire() {
        require(
            msg.sender == proprietaire,
            "Seul le proprietaire peut effectuer cette action."
        );
        _;
    }

    function ajouterLocataire(address locataire) public seulementProprietaire {
        listeLocataires.push(locataire);
    }

    function retirerLocataire(address locataire) public seulementProprietaire {
        for (uint i = 0; i < listeLocataires.length; i++) {
            if (listeLocataires[i] == locataire) {
                delete listeLocataires[i];
                break;
            }
        }
    }

    function obtenirListeLocataires() public view returns (address[] memory) {
        return listeLocataires;
    }
}
