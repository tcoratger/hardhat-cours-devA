// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract MultiSig {
    event Depot(address sender, uint montant);
    event SubmitTransaction(
        address owner,
        uint transactionIndex,
        address destinataire,
        uint valeur
    );
    event ConfirmTransaction(address owner, uint index);
    event AnnulerConfirmationTransaction(address owner, uint index);
    event ExecuterTransaction(address owner, uint index);

    address[] public owners;
    mapping(address => bool) public isOwner;
    uint public immutable nbrConfirmationRequired;

    struct Transaction {
        address to;
        uint value;
        bool executee;
        uint nbrConfirmations;
    }

    Transaction[] public transactions;
    mapping(uint => mapping(address => bool)) public isConfirmed;

    modifier onlyOwner() {
        require(isOwner[msg.sender], "Droit refuse.");
        _;
    }

    modifier isTx(uint index) {
        require(index < transactions.length, "La transaction n'existe pas.");
        _;
    }

    modifier isTxNotExecuted(uint index) {
        require(
            !transactions[index].executee,
            "La transaction a deja ete executee."
        );
        _;
    }

    modifier isTxNotConfirmed(uint index) {
        require(
            !isConfirmed[index][msg.sender],
            "La transaction a deja ete confirmee."
        );
        _;
    }

    constructor(address[] memory _owners, uint nbrConfirmations) {
        require(_owners.length > 0, "Il n'y a aucun proprietaire defini.");
        require(
            nbrConfirmations > 0 && nbrConfirmations <= _owners.length,
            "Le nombre de confirmations propose est invalide."
        );

        nbrConfirmationRequired = nbrConfirmations;

        for (uint i = 0; i < _owners.length; i++) {
            address ownerTmp = _owners[i];

            require(
                ownerTmp != address(0),
                "Un des owners es invalide: adresse nulle."
            );
            require(!isOwner[ownerTmp], "Owner non unique.");

            owners.push(ownerTmp);
            isOwner[ownerTmp] = true;
        }
    }

    function getOwners() public view returns (address[] memory) {
        return owners;
    }

    function getNbrTransactions() public view returns (uint) {
        return transactions.length;
    }

    function getTransactionInformation(
        uint index
    )
        public
        view
        returns (address to, uint value, bool executee, uint nbrConfirmations)
    {
        return (
            transactions[index].to,
            transactions[index].value,
            transactions[index].executee,
            transactions[index].nbrConfirmations
        );
    }

    function depot() public payable {
        emit Depot(msg.sender, msg.value);
    }

    function soumettreTx(address _to, uint _montant) public onlyOwner {
        uint index = transactions.length;

        transactions.push(
            Transaction({
                to: _to,
                value: _montant,
                executee: false,
                nbrConfirmations: 0
            })
        );

        emit SubmitTransaction(msg.sender, index, _to, _montant);
    }

    function confirmerTransaction(
        uint index
    )
        public
        onlyOwner
        isTx(index)
        isTxNotExecuted(index)
        isTxNotConfirmed(index)
    {
        transactions[index].nbrConfirmations += 1;
        isConfirmed[index][msg.sender] = true;
        emit ConfirmTransaction(msg.sender, index);
    }

    function suppressionConfirmation(
        uint index
    ) public onlyOwner isTx(index) isTxNotExecuted(index) {
        require(
            isConfirmed[index][msg.sender],
            "La transaction n'est pas confirmee"
        );

        transactions[index].nbrConfirmations -= 1;
        isConfirmed[index][msg.sender] = false;

        emit AnnulerConfirmationTransaction(msg.sender, index);
    }

    function executerTransaction(
        uint index
    ) public onlyOwner isTx(index) isTxNotExecuted(index) {
        require(
            transactions[index].nbrConfirmations >= nbrConfirmationRequired,
            "Le nombre de confirmations n'est pas suffisant."
        );
        transactions[index].executee = true;

        (bool success, ) = transactions[index].to.call{
            value: transactions[index].value
        }("");
        require(success, "La transaction a echoue");
        emit ExecuterTransaction(msg.sender, index);
    }
}
