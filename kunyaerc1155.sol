// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract KuNyaERC1155 is ERC1155, Ownable {
    uint256 public constant NFT_PRICE = 100000000000000000; // 0.1 ETH price
    mapping(address => bool) public whitelist;

    constructor() ERC1155("https://nftstorage.link/ipfs/bafkreiegbu5wcjuhuh6hxz7kc3wimoi6g7mw5moil56idrn5fqklfgrhry") {
    }

    function addWhitelist(address[] memory _addresses) public onlyOwner {
        for (uint256 i = 0; i < _addresses.length; i++) {
            whitelist[_addresses[i]] = true;
        }
    }

    function removeWhitelist(address[] memory _addresses) public onlyOwner {
        for (uint256 i = 0; i < _addresses.length; i++) {
            whitelist[_addresses[i]] = false;
        }
    }

    function buyNft(uint256 _tokenId) public payable {
        require(whitelist[msg.sender], "You are not in the White list");
        require(msg.value >= NFT_PRICE, "You do not have enough ETH on your account");
        _mint(msg.sender, _tokenId, 1, "");
    }

    function mint( address _to, uint256 _tokenId, uint256 _number) public onlyOwner {
        _mint(_to, _tokenId, _number, "");
    }

    function mintBatch( address _to, uint256[] memory _tokenIds, uint256[] memory _numbers) public onlyOwner {
        _mintBatch(_to, _tokenIds, _numbers, "");
    }
}