// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./IERC20.sol";

contract TokenSwap {

    address  owner;
    IERC20  token1;
    IERC20  token2;
    
    constructor(address _token1, address _token2)  {
        token1 = IERC20(_token1);
        token2 = IERC20(_token2);
        owner = msg.sender;
    }

    event successfullySwapped(address sender, uint256 amount, bool success);

    function calculateRatio() internal view returns(uint256) {

        uint256 totalToken1 = token1.totalSupply();
        uint256 totalToken2 = token2.totalSupply();

        require(totalToken1 > 0 && totalToken2 > 0, "Cannot swap zero value");

        uint tokenRatio = (totalToken2 * 1e18) / totalToken1;

        return tokenRatio;
    }


    function swap(uint256 _amount) external returns(bool) {

        require(msg.sender != address(0), "Zero address detected");

        require(msg.sender == owner, "Not authorized owner");

        require(_amount > 0, "Cannot swap zero value");

        uint256 ratio = calculateRatio();

        uint256 calculatedRatio = _amount * ratio;

        token1.transferFrom(msg.sender, address(this), _amount);

        bool successfulSwap = token2.transfer(msg.sender, calculatedRatio);

        emit successfullySwapped(msg.sender, _amount, successfulSwap);

        return successfulSwap;
    }

}