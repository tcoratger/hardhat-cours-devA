// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Enum {
    enum MonEnum {
        Encours,
        Effectue,
        Stop
    }

    MonEnum public monenum;

    function get() public view returns (MonEnum) {
        return monenum;
    }

    function effectue() public {
        monenum = MonEnum.Effectue;
    }

    function reset() public {
        delete monenum;
    }
}

contract Structure {
    struct MaStructure {
        string text;
        bool completed;
    }

    MaStructure[] public mastructArr;

    modifier validIndex(uint index) {
        require(index < mastructArr.length, "L'index est hors tableau.");
        _;
    }

    function creation(string calldata _text) public {
        mastructArr.push(MaStructure(_text, true));
        mastructArr.push(MaStructure(_text, false));
        mastructArr.push(MaStructure({text: _text, completed: false}));
    }

    // fonction 1: va chercher le texte et le booleen à un index donné
    // fonction 2: va updater le texte et le booleen à un index donné

    function getInfo(
        uint i
    ) public view validIndex(i) returns (string memory, bool) {
        // require(i < mastructArr.length, "L'index est hors tableau.");
        return (mastructArr[i].text, mastructArr[i].completed);
    }

    function updateInfo(
        uint i,
        string calldata _text,
        bool valeur
    ) public validIndex(i) {
        //require(i < mastructArr.length, "L'index est hors tableau.");
        mastructArr[i] = MaStructure(_text, valeur);
    }
}
