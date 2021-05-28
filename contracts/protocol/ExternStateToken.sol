pragma solidity ^0.6.10;

import "../lib/Owned.sol";
import "../lib/SafeDecimalMath.sol";
import "./state/TokenState.sol";

contract ExternStateToken is Owned {
    using SafeMath for uint;
    using SafeDecimalMath for uint;

    /* ========== STATE VARIABLES ========== */

    /* Stores balances and allowances. */
    TokenState public tokenState;

    /* Other ERC20 fields. */
    string public name;
    string public symbol;
    uint public totalSupply;
    uint8 public decimals;

    constructor(
        TokenState _tokenState,
        string memory _name,
        string memory _symbol,
        uint _totalSupply,
        uint8 _decimals,
        address _owner
    ) public Owned(_owner) {
        tokenState = _tokenState;

        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply;
        decimals = _decimals;
    }

    /* ========== VIEWS ========== */

    /**
     * @notice Returns the ERC20 allowance of one party to spend on behalf of another.
     * @param owner The party authorising spending of their funds.
     * @param spender The party spending tokenOwner's funds.
     */
    function allowance(address owner, address spender) public view returns (uint) {
        return tokenState.allowance(owner, spender);
    }

    /**
     * @notice Returns the ERC20 token balance of a given account.
     */
    function balanceOf(address account) external view returns (uint) {
        return tokenState.balanceOf(account);
    }

    /* ========== MUTATIVE FUNCTIONS ========== */

    /**
     * @notice Set the address of the TokenState contract.
     * @dev This can be used to "pause" transfer functionality, by pointing the tokenState at 0x000..
     * as balances would be unreachable.
     */
    function setTokenState(TokenState _tokenState) external onlyOwner {
        tokenState = _tokenState;
        emit TokenStateUpdated(address(_tokenState));
    }

    function _internalTransfer(
        address from,
        address to,
        uint value
    ) internal returns (bool) {
        /* Disallow transfers to irretrievable-addresses. */
        require(to != address(0) && to != address(this), "Cannot transfer to this address");

        // Insufficient balance will be handled by the safe subtraction.
        tokenState.setBalanceOf(from, tokenState.balanceOf(from).sub(value));
        tokenState.setBalanceOf(to, tokenState.balanceOf(to).add(value));

        emit Transfer(from, to, value);

        return true;
    }

    /**
     * @notice Approves spender to transfer on the message sender's behalf.
     */
    function approve(address spender, uint value) public returns (bool) {
        address sender = msg.sender;

        tokenState.setAllowance(sender, spender, value);
        emit Approval(sender, spender, value);
        return true;
    }

    /* ========== EVENTS ========== */
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    event TokenStateUpdated(address newTokenState);
}
