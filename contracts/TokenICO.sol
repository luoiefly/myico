
pragma solidity ^0.4.11;

import "./TokenERC20.sol";


contract TokenICO  is owned, TokenERC20  {

    mapping (address => uint256) contributions; //keeps track of ether contributions in Wei of each contributor address
    
    address public beneficiary;
    
    uint256 public saleTokenSupply;

    uint256 public saleTokenSold = 0;
    uint256 public saleEtherRaised = 0;

    uint256 public sellPrice = 1;
    
    bool public halted = false; //Halt crowdsale in emergency
    
    event Halt(); //Halt event
    event Unhalt(); //Unhalt event


    modifier whenNotHalted() {
        // only do when not halted modifier
        require (!halted);
        _;
    }

    /* Initializes contract with initial supply tokens to the creator of the contract */
    function TokenICO(
        uint256 initialSupply,
        string tokenName,
        uint8  tokenDecimals,
        string tokenSymbol,
        uint256 tokenSaleSupply,
        uint256 tokenSellPrice
        
    ) TokenERC20(initialSupply, tokenName, tokenDecimals, tokenSymbol) public {
        saleTokenSupply = tokenSaleSupply;
        sellPrice = tokenSellPrice;
        beneficiary = msg.sender;
    }

    //Fallback function when receiving Ether.
    function() public payable {
        buy();
    }


    //Halt ICO in case of emergency.
    function halt() public  onlyOwner {
        halted = true;
        Halt();
    }

    function unhalt() public onlyOwner {
        halted = false;
        Unhalt();
    }
    
    /// @notice Allow users to buy tokens for `newBuyPrice` eth and sell tokens for `newSellPrice` eth
    /// @param newSellPrice Price the users can sell to the contract
    function setPrices(uint256 newSellPrice) onlyOwner public {
        sellPrice = newSellPrice;
    }


    function buy() public payable {
        buyRecipient(msg.sender);
    }


    //Allow addresses to buy token for another account
    function buyRecipient(address recipient) public payable whenNotHalted {
        require(msg.value != 0);

        uint256 tokens = msg.value/sellPrice; 
        
        require((saleTokenSold + tokens) < saleTokenSupply);

        super.transfer(recipient, tokens);              // makes the transfers

        saleEtherRaised = saleEtherRaised + msg.value;
        contributions[recipient] = contributions[recipient] + msg.value;
        saleTokenSold = saleTokenSold + tokens;
        
        beneficiary.transfer(msg.value); //immediately send Ether to beneficiary address
        
    }


    //Allow to change the recipient  address
    function setBeneficiary(address addr) public  onlyOwner {
      	require(addr != address(0));
      	beneficiary = addr;
    }


    function getEtherRaised() public  constant returns (uint256) {
        //getter function for saleTokenSold
        return saleEtherRaised;
    }

    function getTokenSold() public constant returns (uint256) {
        //getter function for saleTokenSold
        return saleTokenSold;
    }

}
