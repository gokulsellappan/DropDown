pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract MyToken is ERC20{
     constructor(string memory name,string memory symbol) ERC20(name,symbol) public{
        _mint(msg.sender,100*10**uint(decimals()));
    }
   
}

contract TokenSwap{

    IERC20 public token1;
    address public owner1;
    IERC20 public token2;
    address public owner2;
    mapping(address=>uint256) public balances;
    
    constructor(address _token1,address _token2,address _owner1,address _owner2) public {
        token1 = IERC20(_token1);
        token2 =IERC20(_token2);
        owner1 =_owner1;
        owner2 =_owner2;
    }

    function Swap(uint256 _amout1,uint256 _amout2)public{
        require(token1.allowance(owner1,address(this))>=_amout1,"token1 balance is low");
        require(token2.allowance(owner2,address(this))>=_amout2,"token2 balance is low");
        _safeTransferfrom(token1,owner1,owner2,_amout1);
        _safeTransferfrom(token2,owner2,owner1,_amout2);
    }

    function _safeTransferfrom(IERC20 _token,address _owner,address _sender,uint256 amount) internal{
        bool sent=_token.transferFrom(_owner,_sender,amount);
        require(sent,"token transfer fail");
    }


}