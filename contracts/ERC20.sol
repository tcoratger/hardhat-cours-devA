// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ERC20 {
    uint public totalSupply;
    string public constant name = "Mon Token";
    string public constant symbol = "MT";
    uint public constant decimals = 18;
    address private immutable owner;

    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowance;

    event Transfer(
        address indexed from,
        address indexed to,
        uint indexed amount
    );
    event Approval(
        address indexed owner,
        address indexed spender,
        uint indexed amount
    );

    constructor(uint initialSupply) {
        totalSupply = initialSupply;
        balances[msg.sender] = initialSupply;
        owner = msg.sender;
    }

    function mint(address to, uint amount) public {
        require(
            to != address(0),
            "L'adresse 0 n'est pas autorise pour le mint."
        );
        require(
            msg.sender == owner,
            "Seul le proprietaire du contrat est autorise a effectue cette operation."
        );
        balances[to] += amount;
        totalSupply += amount;
        emit Transfer(address(0), to, amount);
    }

    function burn(uint amount) public {
        require(balances[msg.sender] >= amount, "Solde insuffisant.");
        balances[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    function getTotalSupply() public view returns (uint) {
        return totalSupply;
    }

    function balanceOf(address account) public view returns (uint) {
        return balances[account];
    }

    function transfer(address to, uint amount) public returns (bool) {
        require(
            to != address(0),
            "Le transfert vers l'adresse nulle n'est pas autorise."
        );
        require(balances[msg.sender] >= amount, "Solde insuffisant.");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint amount) public returns (bool) {
        require(spender != address(0), "L'adresse nulle n'est pas autorisee.");
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function getAllowance(
        address account,
        address spender
    ) public view returns (uint) {
        return allowance[account][spender];
    }

    function transferFrom(
        address from,
        address to,
        uint amount
    ) public returns (bool) {
        require(
            from != address(0),
            "Le transfert depuis l'adresse nulle n'est pas autorise."
        );
        require(
            to != address(0),
            "Le transfert vers l'adresse nulle n'est pas autorise."
        );
        require(balances[from] >= amount, "Solde insuffisant.");
        require(
            allowance[from][msg.sender] >= amount,
            "Pas les droits pour transferer ce montant."
        );

        allowance[from][msg.sender] -= amount;

        balances[from] -= amount;
        balances[to] += amount;

        emit Transfer(from, to, amount);

        return true;
    }
}
