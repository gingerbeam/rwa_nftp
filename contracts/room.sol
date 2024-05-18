pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IRoomNFT {
    function mintNFT(address recipient, string memory tokenURI) external returns (uint256);
}

contract RoomNFT1 is ERC721URIStorage, Ownable, IRoomNFT {
    uint256 private _tokenIds;

    constructor() ERC721("RoomNFT", "RNFT") Ownable(msg.sender) {}

    function mintNFT(address recipient, string memory tokenURI) external override onlyOwner returns (uint256) {
        _tokenIds += 1;
        uint256 newItemId = _tokenIds;
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);
        return newItemId;
    }
}

contract Room1 {
    using Address for address;

    uint256 private id;
    uint256 private price;
    address private landlord;
    address private currentTenant;
    bool private rented;
    address private systemAccount;
    IRoomNFT private nftContract;

    constructor(uint256 _id, uint256 _price, address _landlord, address _systemAccount) {
        id = _id;
        price = _price;
        landlord = _landlord;
        rented = false;
        systemAccount = _systemAccount;

        // 创建 RoomNFT 合约
        nftContract = new RoomNFT1();
    }

    function getId() external view returns (uint256) {
        return id;
    }

    function getPrice() external view returns (uint256) {
        return price;
    }

    function getLandlord() external view returns (address) {
        return landlord;
    }

    function getCurrentTenant() external view returns (address) {
        return currentTenant;
    }

    function isRented() external view returns (bool) {
        return rented;
    }

    function rentRoom(uint256 _id, uint256 _price, uint256 startDate, uint256 endDate) external payable {
        require(!rented, "Room is already rented");
        require(msg.value == _price * 105 / 100, "Incorrect payment amount");
        require(address(msg.sender).balance >= msg.value, "Insufficient balance");

        // 分配资金
        uint256 landlordShare = _price;
        uint256 systemShare = _price * 5 / 100;
        payable(landlord).transfer(landlordShare);
        payable(systemAccount).transfer(systemShare);

        // 更新租赁信息
        currentTenant = msg.sender;
        rented = true;

        // 生成包含房屋信息和出租期限信息的 JSON 字符串
        string memory tokenURI = string(abi.encodePacked(
            '{"roomId": "', uint2str(id),
            '", "startDate": "', uint2str(startDate),
            '", "endDate": "', uint2str(endDate),
            '", "landlord": "', toAsciiString(landlord),
            '", "tenant": "', toAsciiString(msg.sender),
            '"}'
        ));

        // 生成NFT并转移给租客
        uint256 nftId = nftContract.mintNFT(msg.sender, tokenURI);

        // 触发事件，将 NFT 关联到房间
        emit NFTCreated(_id, nftId);
    }

    event NFTCreated(uint256 indexed roomId, uint256 indexed nftId);

    function uint2str(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }

    function toAsciiString(address x) internal pure returns (string memory) {
        bytes memory s = new bytes(40);
        for (uint256 i = 0; i < 20; i++) {
            bytes1 b = bytes1(uint8(uint256(uint160(x)) / (2**(8*(19 - i)))));
            bytes1 hi = bytes1(uint8(b) / 16);
            bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
            s[2*i] = char(hi);
            s[2*i+1] = char(lo);
        }
        return string(s);
    }

    function char(bytes1 b) internal pure returns (bytes1 c) {
        if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
        else return bytes1(uint8(b) + 0x57);
    }
}

