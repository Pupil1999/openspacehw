// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BaseERC20 {
    string public name; 
    string public symbol; 
    uint8 public decimals; 

    uint256 public totalSupply; 

    mapping (address => uint256) balances; 

    mapping (address => mapping (address => uint256)) allowances; 

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        name = "BaseERC20";
        symbol = "BERC20";
        decimals = 18;
        totalSupply = 100000000000000000000000000;

        balances[msg.sender] = totalSupply;  
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        if(balances[msg.sender] < _value)
            revert("ERC20: transfer amount exceeds balance");

        balances[_to] += _value;
        balances[msg.sender] -= _value;

        emit Transfer(msg.sender, _to, _value);  
        return true;   
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        if(balances[_from] < _value)
            revert("ERC20: transfer amount exceeds balance");
        if(allowances[_from][msg.sender] < _value)
            revert("ERC20: transfer amount exceeds allowance");

        balances[_from] -= _value;
        balances[_to] += _value;
        allowances[_from][msg.sender] -= _value;
        
        emit Transfer(_from, _to, _value); 
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowances[msg.sender][_spender] += _value;

        emit Approval(msg.sender, _spender, _value); 
        return true; 
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {     
        return allowances[_owner][_spender];
    }
}

contract TokenBank is BaseERC20 {
    mapping(address => uint) bankBalanceOf;

    function deposit(uint amount) public {
        if(balances[msg.sender] < amount)
            revert("transfer amount exceeds balance");

        balances[msg.sender] -= amount;
        bankBalanceOf[msg.sender] += amount;
    }

    function withdraw(uint amount) public {
        if(bankBalanceOf[msg.sender] < amount)
            revert("transfer amount exceeds bank balance");

        balances[msg.sender] += amount;
        bankBalanceOf[msg.sender] -= amount;
    }
}