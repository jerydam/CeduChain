const { ethers } = require("hardhat");

async function main() {

    const deployerAddr = "0x49f2451AbEe35B261bB01f9d0CDC49f8f8df6E3f";
    const deployer = await ethers.getSigner(deployerAddr);

    console.log(`Deploying contracts with the account: ${deployer.address}`);
    console.log(`Account balance: ${(await deployer.provider.getBalance(deployerAddr)).toString()}`);


    const SchoolSystem = await ethers.deployContract("SchoolSystem", ["Ceduchain", "EC"]);
    await SchoolSystem.waitForDeployment();

    console.log(`Congratulations! You have just successfully SchoolSystem.`);
    console.log(`SchoolSystem contract address is ${SchoolSystem.target}. You can verify on https://baobab.scope.klaytn.com/account/${SchoolSystem.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});