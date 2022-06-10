//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract VendingMachcine{
    address public owner;
    mapping(address => uint) public donuntBalances;

    constructor(){
     owner = msg.sender;
     donuntBalances[address(this)] = 100;
    }

    function getVendingMachineBalance()external view returns(uint){
    return donuntBalances[address(this)];
    }
     
     modifier onlyOwner(){
         require(msg.sender == owner,"Only owner can restock");
         _;
     }
    function restock(uint _amount) public onlyOwner{
      donuntBalances[address(this)] += _amount;
    }

      modifier validate(uint _amount){
         require(msg.value >= _amount * 2 ether,"You must provide atleast 2 ether to puchase");
         _;
     }
       modifier checkBalance(uint _amount){
         require( donuntBalances[address(this)] >= _amount,"No enough balance to complete the trasaction");
         _;
     }
    function puchase(uint _amount)public payable checkBalance(_amount) validate(_amount){
      donuntBalances[address(this)] -= _amount;
      donuntBalances[msg.sender] += _amount;
       
    }
}