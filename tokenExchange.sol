// SPDX-License-Identifier: MIT
 pragma solidity ^0.8.23;

contract TokenExchange {
    address public admin;
    mapping(address => uint256) public userBalances;

    constructor() {
        admin = msg.sender;
    }

    // Function to deposit tokens into the exchange
    function depositTokens(uint256 amount) external {
        if(msg.sender == admin){
            revert("Admin cannot deposit tokens");
        }

        // Increase the user's balance
        userBalances[msg.sender] += amount;
    }

    // Function to withdraw tokens from the exchange
    function withdrawTokens(uint256 amount) external {
        require(userBalances[msg.sender] >= amount, "Insufficient balance");

        // Decrease the user's balance
        userBalances[msg.sender] -= amount;
    }

    // Function for admin to withdraw tokes
    function withdrawcontractbalance( uint256 amount) external {
        // Ensure the sender is the admin
        assert(msg.sender == admin);

        require(userBalances[address(this)] >= amount, "Insufficient balance");
        
        // If the swap is successful, deduct the amount from the contract balance
        userBalances[address(this)] -= amount;
        userBalances[msg.sender] += amount;
    }
}