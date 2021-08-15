// "SPDX-License-Identifier: UNLICENSED"
pragma solidity >0.8.0 <0.9.0; 

interface IDMUpload { 
    
    function getLatestSubscriptions() external view returns (string [] memory _filenames, uint256 [] memory _durations, uint256 [] memory _earnings, uint256 [] memory _startdates);
    
    function getRecentUploads () external view returns (string [] memory _filename, string [] memory categories, string [] memory status, uint256 [] memory _uploaddate);
    
    function upload (string memory _filename, 
                        string memory _cid, 
                        string memory _description, 
                        string [] memory keywords, 
                        string [] memory _categories, 
                        uint256 _weeklyprice, 
                        string memory _language) payable external returns (uint256 _uploadid);
 
    function borrow(string memory _filename, uint256 _amount) external returns (uint256 _loanid);
    
    function repay(uint256 _loanid, uint256 _repaymentamount) payable external returns (uint256 _repaymentid);
    
    function cashOut(string memory filename, uint256 _cashoutamount) external returns (uint256 _cashoutid);
    
}