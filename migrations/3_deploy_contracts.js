var TokenICO = artifacts.require("./TokenICO.sol");

module.exports = function(deployer) {
    const initialSupply = 200000; 
    const tokenName = "MyCoin";
    const tokenDecimals = 5
    const tokenSymbol = "%";
    const tokenSaleSupply = 10000;
    const tokenSellPrice = 1;
    deployer.deploy(TokenICO, initialSupply, tokenName,
tokenDecimals,  tokenSymbol, tokenSaleSupply, tokenSellPrice);
};
