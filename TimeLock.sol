pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract TimeLock{
    using SafeMath for uint256;
    
    mapping(address=>uint256) public balances;
    mapping(address => uint256) public lockTime;

    function Deposit() public payable{
        balances[msg.sender]+=msg.value;
        lockTime[msg.sender]=block.timestamp+1 weeks;
    }
    function  Increasetime(uint256 _addtime) public{
        lockTime[msg.sender]=lockTime[msg.sender].add(_addtime);
    }
    function WithDraw() public returns(bool){
        require(balances[msg.sender]>0);
        require(lockTime[msg.sender]<block.timestamp);
        uint amount = balances[msg.sender];
        balances[msg.sender]=0;
        (bool sent,)=msg.sender.call{value:amount}("");
        return sent;
    }

}