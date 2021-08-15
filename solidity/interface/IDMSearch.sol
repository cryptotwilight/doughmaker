// "SPDX-License-Identifier: UNLICENSED"
pragma solidity >0.8.0 <0.9.0; 


interface IDMSearch { 
    
    function getLatestFilesAvailable() external view returns (string [] memory _filenames, string [] memory _filedescriptions, string [] memory categories, uint256 [] memory _prices);
    
    function getUserSubscriptions() external view returns (string [] memory filenames, uint256 [] memory _expiryDates);
    
    function getUserCategories() external view returns (string [] memory _categories);
    
    function search(string memory _query, string memory _category) external view returns (string [] memory _cidresults, string [] memory _filenames, string [] memory _categories);
    
    function save(string memory _resultsname, string memory _resultcid, string [] memory _textresults, string [] memory _filenames, string [] memory _categories) external returns (uint256 _saveid);

    function subscribe(string memory _filename, uint256 _duration, uint256 _price, uint256 _fee ) external payable returns (uint256 _subscribeid, uint256 _expires);
    
    function cancelSubscription(uint256 _subscribeid) external returns (uint256 _cancelid);
    
    function getsaveresults() external view returns (string [] memory _resultnames, string [] memory _resultcid, string [] memory _categories, uint256 [] memory _valuations );
    
}