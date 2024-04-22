// SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;

const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("Liquidity Contract", function () {
    let Liquidity;
    let liquidity;
    let admin;
    let addr1;
    let addr2;
    let addrs;

    beforeEach(async function () {
        Liquidity = await ethers.getContractFactory("Liquidity");
        [admin, addr1, addr2, ...addrs] = await ethers.getSigners();

        liquidity = await Liquidity.deploy();
        await liquidity.deployed();
    });

    it("Should add liquidity correctly", async function () {
        const tokenA = "TokenA";
        const tokenB = "TokenB";
        const tokenA_Address = "0x123";
        const tokenB_Address = "0x456";
        const poolAddress = "0x789";
        const network = "Ethereum";
        const transactionHash = "0xabc";

        await liquidity.connect(addr1).addLiquidity(tokenA, tokenB, tokenA_Address, tokenB_Address, poolAddress, network, transactionHash);

        const allLiquidity = await liquidity.getAllLiquidity(addr1.address);

        expect(allLiquidity.length).to.equal(1);

        const addedLiquidity = allLiquidity[0];

        expect(addedLiquidity.owner).to.equal(addr1.address);
        expect(addedLiquidity.tokenA).to.equal(tokenA);
        expect(addedLiquidity.tokenB).to.equal(tokenB);
        expect(addedLiquidity.tokenA_Address).to.equal(tokenA_Address);
        expect(addedLiquidity.tokenB_Address).to.equal(tokenB_Address);
        expect(addedLiquidity.poolAddress).to.equal(poolAddress);
        expect(addedLiquidity.network).to.equal(network);
        expect(addedLiquidity.transactionHash).to.equal(transactionHash);
    });

    it("Should transfer ether correctly", async function () {
        const amount = ethers.utils.parseEther("1");

        const initialBalance = await ethers.provider.getBalance(liquidity.address);
        await liquidity.transferEther({ value: amount });
        const newBalance = await ethers.provider.getBalance(liquidity.address);

        expect(newBalance).to.equal(initialBalance.add(amount));
    });
});
