// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;


contract KasCoin {
    string public name = "KasCoin";
    string public symbol = "KAS";
    uint256 public totalSupply = 10_000_000_000;
    uint8 public decimals = 18;
    
    address public owner;
    
    mapping(address => uint256) private balances;
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    
    constructor() {
        owner = msg.sender;
        balances[msg.sender] = totalSupply;
    }
    
    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }
    
    function transfer(address to, uint256 value) public returns (bool) {
        require(value <= balances[msg.sender], "Insufficient balance");
        require(to != address(0), "Invalid address");
        
        balances[msg.sender] -= value;
        balances[to] += value;
        
        emit Transfer(msg.sender, to, value);
        return true;
    }
    
    function burn(uint256 value) public returns (bool) {
        require(value <= balances[msg.sender], "Insufficient balance");
        
        uint256 burnAmount = (value * 80) / 100; // Burn 80% of the specified value
        
        balances[msg.sender] -= value;
        totalSupply -= burnAmount;
        
        emit Transfer(msg.sender, address(0), burnAmount);
        emit Burn(msg.sender, burnAmount);
        
        return true;
    }
}
