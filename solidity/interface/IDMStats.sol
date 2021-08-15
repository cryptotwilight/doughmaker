// "SPDX-License-Identifier: UNLICENSED"
pragma solidity >0.8.0 <0.9.0;

interface IDMStats { 
    
    function getUploadDashboardStats() external view returns (uint256 _weeklydatasubscriptions, uint256 _weeklycancellations, uint256 _outstandingaaveloans);
    
    function getSearchDashboardStats() external view returns (uint256 _newCatgoryCount, uint256 _newKeywordCount);
    

}