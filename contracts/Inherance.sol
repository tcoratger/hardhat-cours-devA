// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract A {
    function fonctionA() public pure virtual returns (string memory) {
        return "contrat A";
    }

    function fonctionA1() public pure returns (string memory) {
        return "contrat A fonctionA1";
    }
}

contract B is A {
    function fonctionA() public pure virtual override returns (string memory) {
        return "contrat B";
    }
}

contract C is A {
    function fonctionA() public pure virtual override returns (string memory) {
        return "contrat C";
    }
}

contract D is B, C {
    function fonctionA()
        public
        pure
        virtual
        override(B, C)
        returns (string memory)
    {
        return super.fonctionA();
    }
}

contract E is C, B {
    function fonctionA()
        public
        pure
        virtual
        override(C, B)
        returns (string memory)
    {
        return super.fonctionA();
    }
}
