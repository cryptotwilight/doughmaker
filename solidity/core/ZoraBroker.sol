// "SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.6.8; 

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC721.sol"
import "https://github.com/ourzora/auction-house/blob/main/contracts/AuctionHouse.sol";

contract ZoraBroker {
    
    address administrator; 
    AuctionHouse auctionHouse; 
    IERC721 ierc721; 
    IERC20 erc20; 
    uint256 defaultDuration;
    address payable defaultCurator; 
    
    constructor(address _administrator, address _zoraAuctionHouseAddress, address dataNFTMinter, uint256 _defaultDuration, address _denomination ) {
        administrator = _ad_administrator; 
        auctionHouse = ActionHouse(_zoraAuctionHouseAddress);
        ierc721 = ierc721(dataNFTMinter);
        defaultDuration = _defaultDuration; 
        erc20 = IERC20(_denomination);
    }
    
    function auction(string memory _filename, uint256 _reservePrice, uint256 _nftId) external returns (uint256 _auctionId) {
        ierc721.approve(auctionHouse, _nftId);
        uint256 auctionId = auctionHouse.createAuction(_nftId, address(ierc721), _defaultDuration, _reservePrice,defaultCurator, address(erc20), defaultPercentage, address(erc20) );
        
        
        
        
    } 
    
    
}