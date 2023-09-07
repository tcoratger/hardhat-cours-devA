// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Location {
    address public proprietaire;
    uint public montantLoyer;
    uint public dureeBail;
    address public locataireActuel;
    uint public dateDebutBail;
    bool public estLouee;

    constructor(uint _montantLoyer, uint _dureeBail) {
        proprietaire = msg.sender;
        montantLoyer = _montantLoyer;
        dureeBail = _dureeBail;
        estLouee = false;
    }

    modifier seulementProprietaire() {
        require(
            msg.sender == proprietaire,
            "Seul le proprietaire est autorise a effectuer cette action."
        );
        _;
    }

    modifier seulementLocataire() {
        require(
            msg.sender == locataireActuel,
            "Seul le locataire est autorise a effectuer cette action"
        );
        _;
    }

    function signerBail(address _locataire) public seulementProprietaire {
        require(!estLouee, "La propriete est deja louee");
        locataireActuel = _locataire;
        dateDebutBail = block.timestamp;
        estLouee = true;
    }

    function payerLoyer() public payable seulementLocataire {
        require(msg.value == montantLoyer, "Montant du loyer incorrect");
    }

    function resilierBail() public seulementProprietaire {
        require(estLouee, "La propriete n'est actuellement pas louee");
        require(
            block.timestamp >= dateDebutBail + dureeBail,
            "La duree du bail n'est pas encore ecoulee"
        );
        estLouee = false;
        locataireActuel = address(0);
    }
}
