// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

interface ITokenSwap {
    function swap(uint256 _amount) external returns(bool);
}