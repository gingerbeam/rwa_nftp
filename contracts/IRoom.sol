// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";

interface IRoom {
    function getId() external view returns (uint256);
    function getPrice() external view returns (uint256);
    function getLandlord() external view returns (address);
    function getCurrentTenant() external view returns (address);
    function isRented() external view returns (bool);
    function rentRoom(uint256 roomId, uint256 _price, uint256 startDate, uint256 endDate) external payable;
}

interface IRoomNFT {
    function mintNFT(address recipient, string memory  ) external returns (uint256);
}

