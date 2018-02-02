var TokenERC20Advanced = artifacts.require("./TokenERC20Advanced.sol");

module.exports = function(deployer) {
    const initialSupply = 200000; 
    const tokenName = "MyCoin";
    const tokenSymbol = "%";
    deployer.deploy(TokenERC20Advanced, initialSupply, tokenName, tokenSymbol);
};
