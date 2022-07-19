pragma solidity ^0.8.0;

contract MultiSigWallet{
    event Deposit(address sender,uint256 value);
    event Submit(uint256 txIndex);
    event Approve(address indexed owner,uint256 value);
    event Revoke(address indexed owner,uint256 value);
    event Execute(address indexed owner,uint256 value);

    address[] public owners;
    mapping(address=> bool) public isOwner;
    uint256 public required;

    struct Transaction{
        address to;
        uint256 value;
        bytes data;
        bool execute;
    }
    mapping(uint256=>mapping(address=>bool)) public isApproved;
    Transaction[] public transaction;

     modifier onlyOwner(){
        require(isOwner[msg.sender],"not a owner");
        _;
    }
     
    modifier txExists(uint256 _txIndex){
        require(_txIndex<transaction.length,"txIndex is not exist");
        _;
    }

    modifier notApproved(uint256 _txIndex){
        require(!isApproved[_txIndex][msg.sender],"txindex already approved");
        _;
    }
    modifier notExecuted(uint256 _txIndex){
        require(!transaction[_txIndex].execute,"txIndex already executed");
        _;
    }


    constructor(address[] memory _owners,uint256 _numConfirmationsRequired) public{
        require(_owners.length>0,"ownner is not be empty");
        require(_numConfirmationsRequired>=_owners.length&& _numConfirmationsRequired>0);
        for(uint i=0;i<_owners.length;i++){
            address owner=_owners[i];
            require(owner!=address(0));
            require(!isOwner[owner],"owner is already exist");
            isOwner[owner]=true;
            owners.push(owner);
        }
        required=_numConfirmationsRequired;
    }

    receive() external payable{
        emit Deposit(msg.sender,msg.value);
    }
    
    function submit(address _to,uint256 _value,bytes calldata _data ) public onlyOwner{
        uint txIndex=transaction.length;
        transaction.push(Transaction({
            to:_to,
            value:_value,
            data:_data,
            execute:false
        }));
        emit Submit(txIndex);
    }

    function approve(uint256 _txIndex) public onlyOwner txExists(_txIndex) notApproved(_txIndex) notExecuted(_txIndex){
        isApproved[_txIndex][msg.sender]=true;
        emit Approve(msg.sender,_txIndex);        
    }

    function executee(uint256 _txIndex) public onlyOwner txExists(_txIndex) notExecuted(_txIndex){
        Transaction storage transactions=transaction[_txIndex];
        transactions.execute=true;
        (bool success,)=transactions.to.call{value:transaction.value}(
            transaction.data;
        )
        require(success,"transaction fail")
        emit Execute(msg.sender,_txIndex);
    }



}