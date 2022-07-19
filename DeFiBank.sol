pragma solidity ^0.8.0;

interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}
contract DeFiBank{
    string public name="DefiBank";

    address public usdc;
    address public mytoken;

    address[] public stakers;
    mapping(address=>uint) public stakingBalance; 
    mapping(address=> bool) public isStacking;
    mapping(address=>bool) public hasStaked;

    constructor() public {
        usdc = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
        mytoken= 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    }

    function createStake(uint amount) public {
        IERC20(usdc).transferFrom(msg.sender,address(this),amount);
        stakingBalance[msg.sender]+=amount;
        if(!hasStaked[msg.sender]){
            stakers.push(msg.sender);
        }
        isStacking[msg.sender]=true;
        hasStaked[msg.sender]=true;
    }

    function unstake() public{
        uint balance=stakingBalance[msg.sender];
        require(balance>0,"not enough balance");
        IERC20(usdc).transfer(msg.sender,balance);
        stakingBalance[msg.sender]=0;
        isStacking[msg.sender]=false;
    }

    function collectionReward() public{
        for(uint i=0;i<stakers.length;i++){
            address recipient = stakers[i];
            uint balance = stakingBalance[recipient];
            if(balance>0){
                IERC20(mytoken).transfer(recipient,balance);
            }
        }

    }

}