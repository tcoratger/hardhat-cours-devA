import { ethers } from "hardhat";
import { expect } from "chai";
import { Contract } from "ethers";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

describe("Unit test for Multi Signature contracts", () => {
  let admin: SignerWithAddress,
    user1: SignerWithAddress,
    user2: SignerWithAddress,
    user3: SignerWithAddress,
    multiSig: Contract;

  beforeEach(async () => {
    [admin, user1, user2, user3] = await ethers.getSigners();

    const MultiSig = await ethers.getContractFactory(
      "contracts/MultiSig.sol:MultiSig"
    );

    multiSig = await MultiSig.deploy([admin.address, user1.address], 2);

    await multiSig.deployed();
  });

  describe("Initialisation", async () => {
    it("Doit retourner la liste correcte des propriétaires", async function () {
      expect(await multiSig.getOwners()).to.deep.equal([
        admin.address,
        user1.address,
      ]);
    });

    it("Doit retourner le nombre correct de confirmations nécessaires", async function () {
      expect(await multiSig.nbrConfirmationRequired()).to.equal(2);
    });
  });
  describe("Dépôt", async () => {
    it("Doit augmenter la quantité de tokens ETH sur le contrat", async function () {
      await multiSig.depot({ value: 100 });
      expect(await ethers.provider.getBalance(multiSig.address)).to.equal(100);
    });

    it("Doit émettre un évènement dépôt", async function () {
      await expect(await multiSig.depot({ value: 100 }))
        .to.emit(multiSig, "Depot")
        .withArgs(admin.address, 100);
    });
  });

  describe("Soumission d'une transaction", async () => {
    it("Doit émettre une erreur si le signataire n'est pas propriétaire", async function () {
      await expect(
        multiSig.connect(user2).soumettreTx(user3.address, 2)
      ).to.be.revertedWith("Droit refuse.");
    });

    it("Doit ajouter une nouvelle transaction avec les propriétés adéquates", async function () {
      await multiSig.connect(user1).soumettreTx(user3.address, 2);

      expect(await multiSig.getTransactionInformation(0)).to.deep.equal([
        user3.address,
        2,
        false,
        0,
      ]);
    });

    it("Le nombre de transactions total doit être incrémenté", async function () {
      await multiSig.connect(user1).soumettreTx(user3.address, 2);
      await multiSig.connect(user1).soumettreTx(user3.address, 2);

      expect(await multiSig.getNbrTransactions()).to.equal(2);
    });

    it("Doit émettre un évènement lors de la soumission d'une transaction", async function () {
      await expect(await multiSig.soumettreTx(user3.address, 2))
        .to.emit(multiSig, "SubmitTransaction")
        .withArgs(admin.address, 0, user3.address, 2);
    });
  });
  describe("Confirmation d'une transaction", async () => {});
});
