// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract InheritanceContract {
    address payable public recipient;
    address public owner;
    bool public isOwnerDeceased;

    constructor(address payable _recipient) {
        owner = msg.sender;
        recipient = _recipient;
        isOwnerDeceased = false;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can access this function");
        _;
    }

    modifier onlyRecipient() {
        require(msg.sender == recipient, "Only designated recipient can access this function");
        _;
    }

    function declareDeceased() external onlyOwner {
        require(isOwnerDeceased, "Owner has not been declared deceased");
        require(address(this).balance > 0, "No funds avaiable for withdawal" );
        recipient.transfer(address(this).balance);
    }

    // Fallback function to recieve payments
    receive() external payable {}

}