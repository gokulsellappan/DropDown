pragma solidity ^0.8.0;

contract ShareWallet{
    address private _owner;
    mapping (address =>uint8) public _owners;

    constructor (){
        _owner=msg.sender;
    }

    modifier isOwner(){
        require(_owner==msg.sender);
        _;
    }

    modifier isValidOwner(){
        require(_owner==msg.sender|| _owners[msg.sender]==1);
        _;
    }

    function addOwner(address owner) isOwner public{
        _owners[owner]=1;
    }
    function removeOwner(address owner) isOwner public{
        _owners[owner]=0;
    }
    fallback() external payable{

    }
    function WithDraw(uint256 amount) isValidOwner public {
        require(address(this).balance>=amount);
        payable(msg.sender).transfer(amount);
    }
    function transferTo(address payable to,uint256 amount) isValidOwner public{
        require(address(this).balance>=amount);
        to.transfer(amount);
    }



}