pragma solidity ^0.8.0;

contract VehicleRegister{

    address public owner;
    bytes32[] public vins;

    mapping(bytes32 => Vehicle)public vehicleMap;

    struct Vehicle{
        bytes32 vin;
        string year;
        string model;
        string make;
        string owner;
        uint8 status; //0-no vehicle exist,1-created,2-transfered
    }

    constructor() public {
        owner=msg.sender;
    }
    modifier isOwner(address _owner){
        require(owner==_owner,"Not a owner");
        _;
    }

    function registerVehicle(bytes32 _vin,string memory _year,string memory _model,string memory _make,string memory _owner) public isOwner(msg.sender) {
        require(!isVehicle(_vin));
        vehicleMap[_vin]=Vehicle(_vin,_year,_model,_make,_owner,1);
        vins.push(_vin);
    }

    function isVehicle(bytes32 _vin) public returns(bool) {
        if(vehicleMap[_vin].status!=0){
            return true;
        }else{
            return false;
        }
    }

    function transferVehicle(bytes32 _vin,string memory _owner) public isOwner(msg.sender) returns(string memory) {
        require(isVehicle(_vin));
        vehicleMap[_vin].owner=_owner;
        vehicleMap[_vin].status=2;
    }

    function getVehicleDetails(bytes32 _vin) public returns(string memory){
        require(isVehicle(_vin));
        string memory _vehicle=vehicleMap[_vin].owner;
        return _vehicle;
    }


}