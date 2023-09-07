// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract MonApp {
    // Fonction 1: 3 arguments et qu'elle retourne le double de chacun (uint)
    // Fonction 2: Une boucle qui s'incrémente jusqu'à 3*CONSTANT
    // Fonction 3: Adresse constante en début de contrat. Retourner true si j'appelle avec l'adresse de la constante et false sinon.

    uint public constant maConstante = 56;
    address public constant monAddress =
        0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C;

    function fonction1(
        uint a,
        uint b,
        uint c
    ) public pure returns (uint, uint, uint) {
        return (2 * a, 2 * b, 2 * c);
    }

    function fonction1Bis(
        uint a,
        uint b,
        uint c
    ) public pure returns (uint x, uint y, uint z) {
        x = 2 * a;
        y = 2 * b;
        z = 2 * c;
    }

    function fonction1BisBis(
        uint a,
        uint b,
        uint c
    ) public pure returns (uint x, uint y, uint z) {
        return (2 * a, 2 * b, 2 * c);
    }

    function fonction2() public pure returns (uint) {
        uint x;
        while (x < 3 * maConstante) {
            x++;
        }
        return x;
    }

    function fonction3() public view returns (bool) {
        return msg.sender == monAddress;
    }
}

contract MyApp {
    uint constant CONSTANT = 10;
    address constant OWNER = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    // Fonction 1: 3 arguments et qu'elle retoume le double de chacun (uint)
    function double(
        uint a,
        uint b,
        uint c
    ) public pure returns (uint, uint, uint) {
        return (a * 2, b * 2, c * 2);
    }

    // Fonction 2: Une boucle qui s'incrémente jusqu'à 3*CONSTANT
    function loop() public pure returns (uint) {
        uint i = 0;
        while (i < CONSTANT * 3) {
            i++;
        }
        return i;
    }

    // Fonction 3: Adresse constante en début de contrat. Retoumer true si rappelle avec l'adresse de la constante et false sinon.
    function isOwner() public view returns (bool) {
        return msg.sender == OWNER;
    }
}
