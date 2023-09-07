// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract CSMM {
    IERC20 public immutable token0;
    IERC20 public immutable token1;

    uint public res0;
    uint public res1;

    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    constructor(address _token0, address _token1) {
        token0 = IERC20(_token0);
        token1 = IERC20(_token1);
    }

    function _mint(address to, uint montant) private {
        balanceOf[to] += montant;
        totalSupply += montant;
    }

    function _burn(address from, uint montant) private {
        balanceOf[from] -= montant;
        totalSupply -= montant;
    }

    function _updateRes(uint r0, uint r1) private {
        res0 = r0;
        res1 = r1;
    }

    function swap(
        address _tokenIn,
        uint _montantIn
    ) external returns (uint montantOut) {
        require(
            _tokenIn == address(token0) || _tokenIn == address(token1),
            "Le token que vous souhaitez echanger n'est pas valide."
        );

        bool isToken0 = _tokenIn == address(token0);

        (IERC20 tokenIn, IERC20 tokenOut, uint rIn, uint rOut) = isToken0
            ? (token0, token1, res0, res1)
            : (token1, token0, res1, res0);

        tokenIn.transferFrom(msg.sender, address(this), _montantIn);
        uint montantIn = tokenIn.balanceOf(address(this)) - rIn;

        montantOut = (montantIn * 997) / 1000;

        (uint res0Tmp, uint res1Tmp) = isToken0
            ? (rIn + montantIn, rOut - montantOut)
            : (rOut - montantOut, rIn + montantIn);

        _updateRes(res0Tmp, res1Tmp);
        tokenOut.transfer(msg.sender, montantOut);
    }

    function addLiquidity(
        uint montant0,
        uint montant1
    ) external returns (uint shares) {
        require(montant0 > 0 && montant1 > 0, "Montants invalides");

        token0.transferFrom(msg.sender, address(this), montant0);
        token1.transferFrom(msg.sender, address(this), montant1);

        uint bal0 = token0.balanceOf(address(this));
        uint bal1 = token1.balanceOf(address(this));

        uint delta0 = bal0 - res0;
        uint delta1 = bal1 - res1;

        if (totalSupply > 0) {
            shares = ((delta0 + delta1) * totalSupply) / (res0 + res1);
        } else {
            shares = delta0 + delta1;
        }

        require(shares > 0, "Quantite de shares = 0");

        _mint(msg.sender, shares);
        _updateRes(bal0, bal1);
    }

    function retirerLiquidite(
        uint _shares
    ) external returns (uint delta0, uint delta1) {
        delta0 = (res0 * _shares) / totalSupply;
        delta1 = (res1 * _shares) / totalSupply;

        _burn(msg.sender, _shares);
        _updateRes(res0 - delta0, res1 - delta1);

        if (delta0 > 0) {
            token0.transfer(msg.sender, delta0);
        }
        if (delta1 > 0) {
            token1.transfer(msg.sender, delta1);
        }
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);
}
