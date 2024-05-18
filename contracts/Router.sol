// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "contracts/Hack/Room.sol"; // 确保 Room.sol 文件与 Router.sol 文件在同一目录下
// import "contracts/Hack/RoomNFT.sol"; // 确保 RoomNFT.sol 文件与 Router.sol 文件在同一目录下
import "./room.sol";

contract Router {
    address public systemAccount;

    constructor(address _systemAccount) {
        systemAccount = _systemAccount;
    }

    event RoomDeployed(address indexed roomAddress, uint256 roomId, address landlord);

    function rentRoom(
        address roomAddress,
        uint256 roomId,
        uint256 price,
        uint256 startDate,
        uint256 endDate
    ) external payable {
        Room1 room = Room1(roomAddress);
        room.rentRoom{value: msg.value}(roomId, price, startDate, endDate);
    }

    function createRoom(
        uint256 roomId,
        uint256 price,
        address landlord
    ) external returns (address) {
        Room1 newRoom = new Room1(roomId, price, landlord, systemAccount);
        emit RoomDeployed(address(newRoom), roomId, landlord);
        return address(newRoom);
    }
}

