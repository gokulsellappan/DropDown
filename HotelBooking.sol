pragma solidity ^0.8.0;

contract HotelBooking{
    enum Status{vaccant,occupied}
    Status currentStatus;
    address payable public owner;
    constructor() public {
        currentStatus=Status.vaccant;
        owner =payable(msg.sender) ;
    }
    modifier ishotelAvailable(){
        require(currentStatus==Status.vaccant);
        _;
    }
    modifier cost(uint256 _amout){
        require(msg.value>=_amout);
        _;
    }

    receive() external payable ishotelAvailable cost(2 ether){
        currentStatus=Status.occupied;
        owner.transfer(msg.value);
    }


}