import { ethers } from "hardhat";

async function main() {
  const InitialAddress = "0x617F2E2fD72FD9D5503197092aC168c91465E7f2";
  
  const LeviToken1 = await ethers.deployContract("LeviToken", [
    InitialAddress,
    "LeviToken1",
    "LITO1"
  ]);

  await LeviToken1.waitForDeployment();

  console.log(`LeviToken1 has been deployed to ${LeviToken1.target}`);

  const LeviToken2 = await ethers.deployContract("LeviToken", [
    InitialAddress,
    "NeduToken",
    "NET"
  ]);

  await LeviToken2.waitForDeployment();

  console.log(`LeviToken2 has been deployed to ${LeviToken2.target}`);

  const tokenSwap = await ethers.deployContract("TokenSwap", [LeviToken1.target, LeviToken2.target]);

  await tokenSwap.waitForDeployment();

  console.log(`TokenSwap has been deployes to ${tokenSwap.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
