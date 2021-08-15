// "SPDX-License-Identifier: UNLICENSED"
pragma solidity >0.8.0 <0.9.0; 

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";


contract ChainlinkBroker { 

	address internal administrator; 
	uint256 chainlinkBalance; 
	
	uint256 version = 1; 

    address linkAddress; 
    IERC20 link;
    
    string denomination; 
    address denominationAddress;

	constructor (address _administrator, address _linkAddress, string memory _denomination, address _denominationAddress ) { 
		administrator = _administrator;
	    linkAddress = _linkAddress; 
	    link = IERC20(linkAddress);
	    denomination = _denomination;
	    denominationAddress = _denominationAddress;
	}


    function getPrice() external view returns (uint256 _price){
        
        AggregatorV3Interface priceFeed = AggregatorV3Interface(denominationAddress);
             (   uint80 roundId, int256 answer,uint256 startedAt,uint256 updatedAt, uint80 answeredInRound) = priceFeed.latestRoundData();
        if(answer < 0) {
            _price = uint256( answer * -1);
        }
        else { 
            _price = uint256(answer *1);    
        }
        return _price; 

    }
    
    function hasCredit() external view returns (bool _hasCredit){
        return link.balanceOf(address(this)) > 0;
    }
	
    function getVersion() external view returns(uint256 _version){
        return version; 
    }

    function getDenomination() external returns (string memory _denomination, address _denominationAddress){
        return (denomination, denominationAddress);
    }

} 