// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "./Room.sol"; // 确保 Room.sol 文件与 Router.sol 文件在同一目录下
// import "./RoomNFT.sol"; // 确保 RoomNFT.sol 文件与 Router.sol 文件在同一目录下
import "./room.sol";

contract Router {
    address public systemAccount;
    address public nftContractAddress;

    constructor(address _systemAccount, address _nftContractAddress) {
        systemAccount = _systemAccount;
        nftContractAddress = _nftContractAddress;
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
        Room1 newRoom = new Room1(roomId, price, landlord, systemAccount, nftContractAddress);
        emit RoomDeployed(address(newRoom), roomId, landlord);
        return address(newRoom);
    }
}

