pragma solidity ^0.8.0;

contract odometer{
    struct Car{
        string vin;
        address owner;
        uint256 kilometer;
    }
    mapping(string=>Car) public carmap;

    function createCar(string memory _vin,uint256 _kilometer) public {
        require(carmap[_vin].owner == address(0));
        carmap[_vin]=Car(_vin,msg.sender,_kilometer);
    }

    function updateKilometer(string memory _vin,uint256 _kilometer) public{
        Car storage car=carmap[_vin];
        require(car.kilometer<=_kilometer);
        car.kilometer=_kilometer;
    }

    function  transferOwnership(string memory _vin,address _owner) public{
        Car storage car=carmap[_vin];
        require(car.owner==msg.sender);
        car.owner=_owner;
    }

}