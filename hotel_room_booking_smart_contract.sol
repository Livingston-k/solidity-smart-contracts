//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract HotelRoom {
    enum Statuses {
        vacant,
        occupied
    }
    Statuses public currentStatus;
    address payable owner;

    event Occupy(address _occupant,uint _value);

    constructor(){
        owner = payable(msg.sender);
        currentStatus = Statuses.vacant;
    }

    modifier onlyAllowVacant{
        require(currentStatus == Statuses.vacant, "Room currently occupied");
        _;
    }

    modifier costs(uint _amount){
     require(msg.value >= _amount,"Not enouth ether provided");
     _;
    }

    function book ()public payable onlyAllowVacant costs(2 ether){
       currentStatus = Statuses.occupied;
      (bool sent , bytes memory data) = owner.call{value:msg.value}("");
      require(sent,"Error sending");
      emit Occupy(msg.sender,msg.value);
    }
}
