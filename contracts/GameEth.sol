// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract EthGame {
    uint public montantCible = 5 ether;
    address public gagnant;
    uint public balance;

    function deposit() public payable {
        require(
            msg.value == 1 ether,
            "Tu ne peux envoyer qu'1 ether a la fois"
        );

        balance += msg.value;
        require(balance <= montantCible, "Le jeu est fini");

        if (balance == montantCible) {
            gagnant = msg.sender;
        }
    }

    function claimRecompense() public {
        require(msg.sender == gagnant, "Tu n'es pas le gagnant.");

        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "La transaction a echoue");
    }
}
