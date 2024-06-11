# CustomToken
The "CustomToken" contract is a Solidity smart contract implementing a custom ERC20 token on the Ethereum blockchain. It allows for token minting, burning, transferring, and approval functionalities. The contract includes ownership control, decimal precision management, and emits events for token transfers, approvals, minting, and burning.

## Description

This project is a Solidity smart contract named "CustomToken" that implements a custom ERC20 token on the Ethereum blockchain. It includes functions for minting new tokens ("mint"), burning existing tokens ("burn"), transferring tokens between addresses ("transfer"), transferring tokens from one address to anotheraddress ("transferFrom"), approving token transfers ("approve"), and checking token allowances ("allowance"). Additionally, it features ownership control, decimal precision management, and emits events for various token-related actions.

## Getting Started

### Installing

* Clone this repository or download the Solidity file or copy the code.
* Make sure you have an IDE for Solidity like Remix (https://remix.ethereum.org/).

### Executing program

* First, go to the Remix Site (https://remix.ethereum.org/).
* Now Copy the Code below in the IDE and Save the file with .sol (eg. CustomToken.sol) extension.
  
```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CustomToken is IERC20 {
    
    // Variable declaration (Tokens Metadata)
    string public name;
    string public symbol;
    uint8 public decimals;
    uint private _totalSupply;
    address public owner;

    // Mapping to track balances and allowances
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowances;

    // Events for token minting and burning
    event Mint(address to, uint value);
    event Burn(address from, uint value);

    // Constructor to initialize token metadata and set owner
    constructor(string memory Name, string memory Symbol, uint8 Decimals) {
        name = Name;
        symbol = Symbol;
        decimals = Decimals;
        owner = msg.sender;
    }

    // Modifier to restrict functions to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Owner alone is authorized to carry out these tasks.");
        _;
    }
    
    // View function to get balance of an address
    function balanceOf(address tokenOwner) public view override returns (uint balance) {
        return balances[tokenOwner];
    }
     // Function to get the total supply of tokens
    function totalSupply() public view override returns (uint) {
        return _totalSupply;
    }
    
    // Function to mint new tokens (onlyOwner)
    function mint(address to, uint value) external onlyOwner {
        require(to != address(0), "Cannot mint to zero address");
        _totalSupply = _totalSupply + value;
        balances[to] = balances[to] + value;
        emit Mint(to, value);
    }

    // Function to burn tokens
    function burn(uint value) external {
        require(balances[msg.sender] >= value, "Insufficient funds");
        balances[msg.sender] = balances[msg.sender] - value;
        _totalSupply = _totalSupply - value;
        emit Burn(msg.sender, value);
    }

    // Function to transfer tokens
    function transfer(address to, uint value) public override returns (bool) {
        require(to != address(0), "Cannot transfer to zero address");
        require(value > 0, "Value must be greater than 0");
        require(balances[msg.sender] >= value, "Insufficient funds");
        balances[msg.sender] = balances[msg.sender] - value;
        balances[to] = balances[to] + value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

     // Function to approve spending of tokens
    function approve(address spender, uint value) public override returns (bool) {
        allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    // Function to check allowance of spender
    function allowance(address tokenOwner, address spender) public view override returns (uint remaining) {
        return allowances[tokenOwner][spender];
    }

    // Function to transfer from one address to another
    function transferFrom(address from, address to, uint value) public override returns (bool) {
        require(to != address(0), "Cannot transfer to zero address");
        require(balances[from] >= value, "Insufficient funds");
        require(allowances[from][msg.sender] >= value, "Insufficient allowance"); 
        allowances[from][msg.sender] = allowances[from][msg.sender] - value;
        balances[from] = balances[from] - value;
        balances[to] = balances[to] + value; 
        emit Transfer(from, to, value); 
        return true;
    }
}
```
* #### Compile the Contract:
    Open the “Solidity Compiler” tab in the left-hand sidebar, ensure that the “Compiler” option is set to version “0.8.7” (or Auto Compile is enabled , it will 
    automatically select the suitable version) and then click on the “Compile CustomToken.sol” button.
* #### Deploy the Contract:
    Navigate to the “Deploy & Run Transactions” tab in the left-hand sidebar, from the dropdown menu, select the “CustomToken” contract and then click on the “Deploy” button.
* #### Interact with the contract
    Once the contract is deployed , you can interact by calling the "mint", "burn", "transfer" , "approve" etc. function.


## Authors

Amandeep Sharma

inspireamandeep1@gmail.com

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
