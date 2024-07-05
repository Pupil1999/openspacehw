// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Bank {
    mapping(address => uint) private accounts; // record of deposited money
    address public owner; // administrator account of the contract
    address[3] public VIP; // three people with the most deposited money

    constructor() {
        owner = msg.sender;
    }

    // Record the amount that msg sender transfered.
    function deposit() public payable {
        accounts[msg.sender] += msg.value;
        rankVIP(msg.sender);
    }

    // Only contract owner can retrieve money.
    function withdraw(
        uint amount
    ) public payable {
        if( msg.sender != owner ) 
            revert();

        if( address(this).balance < amount ) 
            revert();

        payable(msg.sender).transfer(amount);
    }

    // Check the balance of contract caller.
    function checkBalance() public view returns(uint) {
        return accounts[msg.sender];
    }

    // Check VIP accounts.
    function checkVIP() public view returns(address, address, address) {
        return (VIP[0], VIP[1], VIP[2]);
    }

    // Adjust the ranking list of three VIP.
    function rankVIP(
        address addr
    ) internal {
        for( uint i=0; i<3; i++ ){
            // If the account has been a VIP account, 
            // we just need to adjust its index by looking forward
            if( addr == VIP[i] ){
                for( uint j=i; j>0; j--){
                    if( accounts[VIP[j-1]] < accounts[VIP[j]] ){
                        address temp = VIP[j-1];
                        VIP[j-1] = VIP[j];
                        VIP[j] = temp;
                    }
                }
                return ;
            }
        }

        address comp = addr;
        for( uint i=0; i<3; i++ ){
            if( accounts[VIP[i]] < accounts[comp] ){
                address temp = VIP[i];
                VIP[i] = comp;
                comp = temp;
            }
        }
    }

    receive() external payable {
        if( msg.value < 0 )
            revert();
        
        accounts[msg.sender] += msg.value;
        rankVIP(msg.sender);
    }
}