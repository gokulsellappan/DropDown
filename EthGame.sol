pragma solidity ^0.8.0;

contract EthGame{
    uint256 targetAmount=5 ether;
    address public winner;
    uint256 balance;

    function Deposit() public payable {
        require(msg.value==1 ether);
        balance=balance+msg.value;
        require(balance<=targetAmount,"Game over");
        if(balance==targetAmount){
            winner=msg.sender;
        }
    }

    function claimReward() public{
        require(msg.sender==winner);
        (bool sent,)=msg.sender.call{value:address(this).balance}("");
        require(sent,"claim fail");
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }


}