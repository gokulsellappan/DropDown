pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20{

    address public owner;

    constructor(uint256 _tokenSupply) public ERC20("Mytoken","MYT"){
        owner=msg.sender;
        _mint(msg.sender,_tokenSupply);
    }

    function mint(uint256 amount) public {
        require(msg.sender==owner,"incorrect owner");
        _mint(msg.sender,amount);
    }

    function burn(uint256 amount) public {
       require(msg.sender==owner,"incorrect owner");
       _burn(msg.sender,amount);
    }
}
