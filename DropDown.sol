pragma solidity ^0.8.0;

contract Dropdown{
    address public fileOwner;
    uint public fileSize;
    uint feeAmount= 1 ether;

    struct File{
        string name;
        //bytes32 data;
        uint size;
    }

    mapping(string=>File) public files;
    mapping(address=>string) public owner;
    uint count=0;

    function _allowgetFee(uint _filesize) internal returns(bool){
        require(_filesize>250);
        uint feeDiffence=_filesize-250;
        payable(msg.sender).transfer(feeAmount);
        return true;  
    }

    function fileUpload(string memory CID,string memory _name,uint _size) public payable {
        //require(_data.length>0,"no data in file");
        owner[msg.sender]=CID;
        files[CID]=File(_name,_size);
        _allowgetFee(_size);
        count++;
    }

    // function fileDownload(string memory CID,uint)public{
    //     require(owner[])

    // }
}
