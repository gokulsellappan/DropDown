pragma solidity ^0.8.0;

contract HotelBookRooms{
    enum  Status{ vaccant,occupied}
    address public owner;
    mapping(uint8=>RoomBooking) public RoomBook;
    uint8 public bookedCount =0;
    uint8 public roomCount;

    struct RoomBooking{
        uint8 roomNo;
        string bookPersonName;
        Status status;
    }
    constructor (uint8 _roomCount) public{
        roomCount=_roomCount;
        owner=msg.sender;
        for(uint8 i=0;i<_roomCount;i++){
            RoomBooking memory room=RoomBooking(i,"",Status.vaccant);
            RoomBook[i]=room;
        }
    }

    function Booking(string memory personName) public{
        require(bookedCount<=roomCount,"all rooms are booked");
        RoomBooking storage room=RoomBook[bookedCount];
        require(room.status==Status.vaccant);
        room.roomNo=bookedCount;
        room.bookPersonName=personName;
        room.status=Status.occupied;
        bookedCount+=1;
    }

}