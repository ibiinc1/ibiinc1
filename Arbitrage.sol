pragma solidity ^0.6.6;

import "https://github.com/ibiinc1/ibiinc1/blob/main/interfaces/IERC20.sol";
import "https://github.com/ibiinc1/ibiinc1/blob/main/interfaces/IUniswapV2Callee.sol";
import "https://github.com/ibiinc1/ibiinc1/blob/main/interfaces/IUniswapV2Factory.sol";
import "https://github.com/ibiinc1/ibiinc1/blob/main/interfaces/IUniswapV2Pair.sol";
import "https://github.com/ibiinc1/ibiinc1/blob/main/interfaces/IUniswapV2Router01.sol";
import "https://github.com/ibiinc1/ibiinc1/blob/main/interfaces/IUniswapV2Router02.sol";
import "https://github.com/ibiinc1/ibiinc1/blob/main/SafeMath.sol";
import "https://github.com/ibiinc1/ibiinc1/blob/main/UniswapV2Library.sol";

contract Arbitrage {
using SafeMath for uint;

    address private owner;
     address public constant pancakeFactory = 0xBCfCcbde45cE874adCB698cC183deBcF17952812;
     address public constant bakeryRouter = 0xCDe540d7eAFE93aC5fE6233Bee57E1270D3E330F;
    address token1 = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
    address token0 = 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56;

  constructor(address _pancakeFactory, address _bakeryRouter) public {
    pancakeFactory = _pancakeFactory;  
    bakeryRouter = IUniswapV2Router02(_bakeryRouter);
    uint256 _amount = 100 * 1e18; 
    
  }

 
