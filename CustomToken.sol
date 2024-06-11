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
