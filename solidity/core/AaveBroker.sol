// "SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.6.12; 
pragma experimental abicoderv2;

import "https://github.com/aave/protocol-v2/blob/ice/mainnet-deployment-03-12-2020/contracts/protocol/lendingpool/LendingPool.sol";
import "https://github.com/aave/protocol-v2/blob/ice/mainnet-deployment-03-12-2020/contracts/protocol/configuration/LendingPoolAddressesProvider.sol";
import "https://github.com/aave/protocol-v2/blob/ice/mainnet-deployment-03-12-2020/contracts/protocol/configuration/LendingPoolAddressesProviderRegistry.sol";


import "./Subscription.sol";

contract AaveBroker {
 
     address erc20Address; 
    
     uint256 STABLE_RATE = 1;
 
     IERC20 erc20;
     LendingPool lendingPool; 
     LendingPoolAddressProvider lpAddressProvider; 
     LendingPoolAddressProviderRegistry lpRegistry; 
     
     struct Loan { 
        uint256 id; 
        Subscription subscription;
        uint256 loanAmount; 
        uint256 interestType; 
        LendingPool lp; 
        IERC20 borrowCurrency; 
     }
 
     struct Repayment { 
        uint256 id;
        uint256 loanId; 
        uint256 repaymentAmount; 
        uint256 repaymentDate; 
     }
 
     mapping(uint256=>Loan) loanById;
     mapping(uint256=>Repayment) repaymentById; 
 
    
     uint256 [] loans; 
     uint256 [] repayments; 
    
 
     constructor(address _administrator, 
                 address _lendingPoolAddressesProviderRegistry,
                 address _erc20Address) {
         lpRegistry = LendingPoolAddressProviderRegistry(lpRegistry);
         erc20 = IERC20(_erc20Address);
         lpAddressProvider = LendingPoolAddressesProvider(lpRegistry.getAddressesProviersList()[0]);
         lendingPool = LendingPool(lpAddressProvider.getLendingPool());
         
     }
 

    function borrow(address _subscription, uint256 _borrowAmount, address _borrowCurrency, uint256 _collateral) payable external returns (uint256 _loanId) {
        Subscription subscription_ = Subscription(_subscription);
        subscription.approveLendingPool(address(lendingPool));
        lendingPool.deposit(erc20Address, _collateral, _subscription, 0);
        lendingPool.borrow( _borrowCurrency, _borrowAmount, STABLE_RATE, 0, _subscription);
        
        Loan loan = Loan ({
                subscription : subscription_,
                loanAmount : _borrowAmount,
                interestType : STABLE_RATE,
                lp : lendingPool,
                borrowCurrency : _borrowCurency
        });
        _loanId = generateId(); 
        loanById[_loanId] = loan; 
        return _loanId; 
    }
    
    function repay(uint256 _loanId, uint _repaymentAmount) payable external returns (uint256 _repaymentId) {
        Loan loan = loanById[_loanId];
        loan.borrowCurrency.approve(address(loan.lp));
        
        loan.lp.repay(address(loan.borrowCurrency), _repaymentAmount, STABLE_RATE, address(loan.subscription));
        
        _repaymentId = generateId();
        
        Repayment repayment = Repayment({
            id : _repaymentId, 
            loanId : loan.id, 
            repaymentAmount : _repaymentAmount,
            repaymentDate : block.timestamp 
        });
        
        repayments.push(_repaymentId);
            
        repaymentById[_repaymentId] = repayment;
            
        return _repaymentId; 
    }
    
    function getLoans() external view returns (uint256 [] memory _loans) {
        return loans; 
    }
    
    function getRepayments() external view returns (uint256 [] memory _repayments) {
        return repayments;
    }
    
    
    function generateId() internal returns (uint256 _txId){
        return block.timestamp;
    }
}