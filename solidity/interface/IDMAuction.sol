// "SPDX-License-Identifier: UNLICENSED"
pragma solidity >0.8.0 <0.9.0; 

interface IDMAuction {
    
    function auction(string memory _filename, string memory _type, string [] memory categories, uint256 _valuation, uint256 _reserve, uint256 _fee) payable external returns (uint256 _auctionid);
    
    function getauctions() external view returns(string [] memory _filename, string [] memory _cids, string [] memory _categories, uint256 [] memory _valuations, bool [] memory _reserveprice, uint256 [] memory _lastbid, uint256 [] memory lastbidid);
    
    function acceptBid(uint256 _bidid) external returns (uint256 _completionid);
    
    function cancelAuction (uint256 _auctionid) external returns (uint256 _cancelid);
    
}