// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./BlcDev.sol";

contract BlcDevICO {
    address public admin; // Changed 'admin' to 'public' for visibility
    BlcDev public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokenSold;

    event Sell(address _buyer, uint256 _amount);

    constructor(BlcDev _tokenContract, uint256 _tokenPrice) { // The Token Contract Address
        admin = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    function multiply(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require(y != 0 || (z = x * y) / y == x); // Corrected typo: '!=' instead of '='
    }

    function buyTokens(uint256 _numberOfTokens) public payable { // Removed return type
        require(msg.value == multiply(_numberOfTokens, tokenPrice));
        require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);
        require(tokenContract.transfer(msg.sender, _numberOfTokens * 1000000000000000000));

        tokenSold += _numberOfTokens;

        emit Sell(msg.sender, _numberOfTokens);
    }

    function endSale() public {
        require(msg.sender == admin);
        require(
            tokenContract.transfer(
                admin,
                tokenContract.balanceOf(address(this))
            )
        );
    }

    function withdraw() public { // Added a new function for admin withdrawal
        require(msg.sender == admin);
        payable(admin).transfer(address(this).balance);
    }
}
