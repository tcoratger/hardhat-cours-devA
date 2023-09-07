// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract WalletPartage {
    address private owner;

    event Depot(address from, uint montant);
    event Retrait(address from, uint montant);
    event Transfer(address from, address to, uint montant);
    event NouveauProprietaire(address proprietaire);
    event ProprietaireSupprime(address proprietaire);

    mapping(address => bool) private owners;

    modifier isProprietairePrincipal() {
        require(msg.sender == owner, "Non proprietaire principal");
        _;
    }

    modifier isProprietaire() {
        require(msg.sender == owner || owners[msg.sender], "Non proprietaire");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addProprietaire(
        address proprietaire
    ) public isProprietairePrincipal {
        owners[proprietaire] = true;
        emit NouveauProprietaire(proprietaire);
    }

    function removeProprietaire(
        address proprietaire
    ) public isProprietairePrincipal {
        owners[proprietaire] = false;
        emit ProprietaireSupprime(proprietaire);
    }

    function depot() public payable {
        emit Depot(msg.sender, msg.value);
    }

    function retrait(uint montant) public isProprietaire {
        require(address(this).balance >= montant, "Solde insuffisant");
        (bool success, ) = msg.sender.call{value: montant}("");
        require(success, "La transaction a echoue");
        emit Retrait(msg.sender, montant);
    }

    function transfert(address payable to, uint montant) public isProprietaire {
        require(address(this).balance >= montant, "Solde insuffisant");
        (bool success, ) = to.call{value: montant}("");
        require(success, "La transaction a echoue");
        emit Transfer(msg.sender, to, montant);
    }
}
