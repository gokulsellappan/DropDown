pragma solidity ^0.8.0;

contract Sat1{
    uint256 public num;
    address public sender;
    uint256 public value;
    address payable owner;

    constructor() public  {
        owner=payable(msg.sender);
    }

    function setVars(uint256 _num) public payable {
        num =_num;
        sender=msg.sender;
        value=msg.value;
    }

    function destruct() public{
        selfdestruct(owner);
    }

}
contract Sat2{
    uint256 public num;
    address public sender;
    uint256 public value;
    address payable owner;

    constructor() public payable {
        owner=payable(msg.sender);
    }

    function setVars(uint256 _num) public payable{
        num =2*_num;
        sender=msg.sender;
        value=msg.value;
    }

    function destruct() public{
        selfdestruct(owner);
    }

}

contract MainContract{
    uint256 public num;
    address public owner;
    uint256 public value;

    function setVars(address _contract,uint256 _num) public{

        (bool sent,bytes memory data)=_contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)",_num)
            );
    }
}