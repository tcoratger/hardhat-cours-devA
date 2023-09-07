// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Magasin {
    address public proprietaire;
    string[] public listeProduits;

    modifier uniqProprietaire() {
        require(
            msg.sender == proprietaire,
            "Uniquement le proprietaire est autorise a executer cette action."
        );
        _;
    }

    constructor() {
        proprietaire = msg.sender;
    }

    function ajoutProduit(string memory _nomProduit) public uniqProprietaire {
        listeProduits.push(_nomProduit);
    }

    function getTotalProduits() public view returns (uint) {
        return listeProduits.length;
    }

    function getProduit(uint index) public view returns (string memory) {
        require(index < listeProduits.length, "L'index n'est pas valide.");
        return listeProduits[index];
    }
}
