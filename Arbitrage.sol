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
    address private constant pancakeFactory = 0xBCfCcbde45cE874adCB698cC183deBcF17952812;
    address private constant bakeryRouter = 0xCDe540d7eAFE93aC5fE6233Bee57E1270D3E330F;
    address token0 = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
    address token1 = 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56;

  constructor(address _pancakeFactory, address _bakeryRouter) public {
    pancakeFactory = _pancakeFactory;  
    bakeryRouter = IUniswapV2Router02(_bakeryRouter);
    
  }

  function startArbitrage(
    address token0, 
    address token1, 
    uint amount0, 
    uint amount1
  ) external {
    address pairAddress = IUniswapV2Factory(pancakeFactory).getPair(token0, token1);
    require(pairAddress != address(0), 'This pool does not exist');
    IUniswapV2Pair(pairAddress).swap(
      amount0, 
      amount1, 
      address(this), 
      bytes('100')
    );
  }

  function pancakeCall(
    address _sender, 
    uint _amount0, 
    uint _amount1, 
    bytes calldata _data
  ) external {
    address[] memory path = new address[](2);
    uint amountToken = _amount0 == 0 ? _amount1 : _amount0;
    
    address token0 = IUniswapV2Pair(msg.sender).token0();
    address token1 = IUniswapV2Pair(msg.sender).token1();

    require(
      msg.sender == UniswapV2Library.pairFor(pancakeFactory, token0, token1), 
      'Unauthorized'
    ); 
    require(_amount0 == 0 || _amount1 == 0);

    path[0] = _amount0 == 0 ? token1 : token0;
    path[1] = _amount0 == 0 ? token0 : token1;

    IERC20 token = IERC20(_amount0 == 0 ? token1 : token0);
    
    token.approve(address(bakeryRouter), amountToken);

    uint amountRequired = UniswapV2Library.getAmountsIn(
      pancakeFactory, 
      amountToken, 
      path
    )[0];
    uint amountReceived = bakeryRouter.swapExactTokensForTokens(
      amountToken, 
      amountRequired, 
      path, 
      msg.sender, 
      deadline
    )[1];

    IERC20 otherToken = IERC20(_amount0 == 0 ? token0 : token1);
    otherToken.transfer(msg.sender, amountRequired);
    otherToken.transfer(tx.origin, amountReceived - amountRequired);
  }
}
