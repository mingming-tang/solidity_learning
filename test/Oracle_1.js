const { expect } = require("chai");

describe("EthereumPrice contract", function () {
  it("Deployment should assign the total supply of tokens to the owner", async function () {
    const [owner] = await ethers.getSigners();

    const Token = await ethers.getContractFactory("EthereumPrice");

    const ethereumPrice = await Token.deploy();

    console.log("feeding");

    ethereumPrice.feed(owner.address, 1000);

    let feedPriceList = await ethereumPrice.getFeedPriceList();

    console.log("feedPriceList: ", feedPriceList);

    console.log("done");

    // const ownerBalance = await hardhatToken.balanceOf(owner.address);
    // expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
  });
});