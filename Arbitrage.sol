pragma solidity ^0.6.6;

contract Arbitrage {
using SafeMath for uint;

    address private owner;
     address public constant pancakeFactory = 0xBCfCcbde45cE874adCB698cC183deBcF17952812;
     address public constant bakeryRouter = 0xCDe540d7eAFE93aC5fE6233Bee57E1270D3E330F;
    address token1 = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    address token0 = 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56;
   function flashloanBnb(uint256 _amount) public  {
          bytes memory data = "";
        uint256 _amount = 10;
  }

 
