// "SPDX-License-Identifier: UNLICENSED"
pragma solidity >0.8.0 <0.9.0; 

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

import "../interface/IDMSearch.sol"; 
import "../interface/IDMUpload.sol";
import "../interface/IDMAuction.sol";
import "../interface/IDMStats.sol";

import "./ZoraBroker.sol"; 
import "./ChainlinkBroker.sol"; 
import "./AaveBroker.sol";


contract DoughMaker is IDMSearch, IDMUpload, IDMAuction, IDMStats {
    
    
    IERC20 usdc;
    address administrator; 
    
    AaveBroker aaveBroker; 
    ChainlinkBroker chainlinkBroker; 
    ZoraBroker zoraBroker; 
    
    uint256 one_week = 604800; 
    
    string [] testfilenames;
    
    string [] testcategories;
    
    uint256 [] testdates; 
    
    string [] testcids; 
    


    constructor(address _administrator, 
                address _usdcAddress,
                address _zorabrokerAddress,
                address _aavebrokerAddress, 
                address _chainlinkbrokerAddress) {
        administrator = _administrator; 
        usdc = IERC20(_usdcAddress);
        zoraBroker = ZoraBroker(_zorabrokerAddress);
        aaveBroker = AaveBroker(_aavebrokerAddress);
        chainlinkBroker = ChainlinkBroker(_chainlinkbrokerAddress);
        
        
        testfilenames = new string[](3);
        testfilenames[0] = "nexttest.json";
        testfilenames[1] = "againtest.json";
        testfilenames[2] = "moretest.txt";
        
        testcategories = new string [](3);
        testcategories[0] = "blockchain";
        testcategories[1] = "defi";
        testcategories[2] = "data";
        
        testdates = new uint256[](3);
        testdates [0] = 1629160528;
        testdates [1] = 1629160528;
        testdates [2] = 1629160528;
        
        testcids = new string[](3);
        testcids [0] = "bafybeibfbz6fogt33jigxc72alasv6w7qym4pw7nkorxlfkd7tla5xo2e4";
        testcids [1] = "bafybeibfbz6fogt33jigxc72alasv6w7qym4pw7nkorxlfkd7tla5xo2e4";
        testcids [2] = "bafybeibfbz6fogt33jigxc72alasv6w7qym4pw7nkorxlfkd7tla5xo2e4";
        
    }
    
    
    function getUploadDashboardStats() override external view returns (uint256 _weeklydatasubscriptions, uint256 _weeklycancellations, uint256 _outstandingaaveloans){
        
        uint256 price = chainlinkBroker.getPrice();


        return (21, 22, 23);
    }
    
    function getLatestSubscriptions() override external view returns (string [] memory _filenames, uint256 [] memory _durations, uint256 [] memory _earnings, uint256 [] memory _startdates){
        uint256 price = chainlinkBroker.getPrice();


        _durations = new uint256[](3);
        _durations [0] = one_week*2;
        _durations [1] = one_week*5;
        _durations [2] = one_week*3;
        _earnings = new uint256[](3);
        _earnings [0] = 50;
        _earnings [1] = 100;
        _earnings [2] = 150;        

        
        
        return (testfilenames, _durations, _earnings,  testdates);
        
    }
    
    function getRecentUploads () override  external view returns (string [] memory _filenames, string [] memory _categories, string [] memory _statii, uint256 [] memory _uploaddates){
        
        
        _statii = new string[](3);
        _statii[0] = "done";
        _statii[1] = "done";
        _statii[2] = "done";
        
        
        return (testfilenames, testcategories, _statii, _uploaddates );
    }
    
    function search(string memory _query, string memory _category) override external view returns (string [] memory _cidresults, string [] memory _filenames, string [] memory _categories){
        
        
        return (testcids, testfilenames, testcategories);
    }
    
    function save(string memory _resultsname, string [] memory _textresults, string [] memory _filenames, string [] memory _categories) override external returns (uint256 _saveid){
       
        return generatetxId();
    }

    function subscribe(string memory _filename, uint256 _duration, uint256 _price, uint256 _fee ) override external payable returns (uint256 _subscribeid, uint256 _expires){
        uint256 price = chainlinkBroker.getPrice();

        
        
        _subscribeid = generatetxId();
        _expires = 1631838928;
        return( _subscribeid, _expires);
    }
    
    function cancelSubscription(uint256 _subscribeid) override external returns (uint256 _cancelid){
       
        return generatetxId();
    }
    
    function getsaveresults() override external view returns (string [] memory _resultnames, string [] memory _resultcids, string [] memory _categories, uint256 [] memory _valuations, bool [] memory _auctioned ){
         uint256 price = chainlinkBroker.getPrice();

        _resultnames = new string[](3);
        _resultnames[0] = "testresultsave1";
        _resultnames[1] = "testresultsave2";
        _resultnames[2] = "testresultsave3";
        
        _valuations = new uint256[](3);
        _valuations[0] = 50;
        _valuations[0] = 75;
        _valuations[0] = 140;
        
        _auctioned = new bool[](3);
        _auctioned[0] = true;
        _auctioned[1] = false; 
        _auctioned[2] = false; 
        
        return (_resultnames, testcids, testcategories, _valuations, _auctioned);
        
    }
    
    function getUserCategories() override external view returns (string [] memory _categories) {
       
        return testcategories; 
    }
    
    
    function upload (string memory _filename, 
                        string memory _cid, 
                        string memory _description, 
                        string [] memory keywords, 
                        string [] memory _categories, 
                        uint256 _weeklyprice, 
                        string memory _language) override payable external returns (uint256 _uploadid){
           uint256 price = chainlinkBroker.getPrice();                       

         return generatetxId();                    
    }
 
    function borrow(string memory _filename, uint256 _amount) override external returns (uint256 _loanid){
        uint256 loanId = aaveBroker.borrow();
        return generatetxId(); 
    }
    
    function repay(uint256 _loanid, uint256 _repaymentamount) override payable external returns (uint256 _repaymentid) {
        
        uint256 repaymentId = aaveBroker.repay();
        
        
        return generatetxId(); 
    }
    
    function cashOut(string memory filename, uint256 _cashoutamount) override external returns (uint256 _cashoutid){
        //@todo
        return generatetxId(); 
    }
    
    function auction(string memory _name, string memory _type, string [] memory categories, uint256 _valuation, uint256 _reserve, uint256 _fee) override payable external returns (uint256 _auctionid){
        //@todo
        return generatetxId();
    }
    
    function acceptBid(uint256 _bidid) override external returns (uint256 _completionid){
        //@todo
        return generatetxId();
    }
    
    function cancelAuction (uint256 _auctionid) override external returns (uint256 _cancelid){
        //@todo
        return generatetxId();
    }
    
    
    function setChainlinkBroker(address chainlinkBrokerAddress)  external returns (bool _set) {
        chainlinkBroker = ChainlinkBroker(chainlinkBrokerAddress);
        return true; 
    }
    
    function setAaveBroker(address aaveBrokerAddress)  external returns (bool _set) {
        aaveBroker = AaveBroker(aaveBrokerAddress);
        return true; 
    }
    
    
    function setZorakBroker(address zoraBrokerAddress)  external returns (bool _set) {
        zoraBroker = ZoraBroker(zoraBrokerAddress);
        return true; 
    }
    
    
    function generatetxId() internal returns (uint256 _txId){
        return block.timestamp;
    }
    
    
    
    
}