const main = async () => {
  //Deploy the contract.
  const nftContractFactory = await hre.ethers.getContractFactory("EpicNFT");
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Contract deployed to:", nftContract.address);

  // Call the function and wait for it to be mined.
  let txn = await nftContract.makeAnNFT();
  await txn.wait();

  // Mint another NFT for fun and wait for it to be mined as well.
  txn = await nftContract.makeAnNFT();
  await txn.wait();
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
