var TokenERC20 = artifacts.require("./TokenERC20.sol");

module.exports = function(deployer) {
    const initialSupply = 200000; 
    const tokenName = "MyCoin";
    const tokenSymbol = "%";
    deployer.deploy(TokenERC20, initialSupply, tokenName, tokenSymbol);
};
