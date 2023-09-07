// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Paiement {
    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    function depot() public payable {}

    function retirer() public {
        uint montant = address(this).balance;
        (bool success, ) = owner.call{value: montant}("");
        require(success, "La transaction a echoue");
    }

    function envoyer(address payable to, uint montant) public {
        (bool success, ) = to.call{value: montant}("");
        require(success, "La transaction a echoue");
    }
}
