pragma solidity ^0.6.10;

// Inheritance
import "../DebtCache.sol";

contract TestableDebtCache is DebtCache {
    constructor(address _owner, address _resolver) public DebtCache(_owner, _resolver) {}

    function setCachedSynthDebt(bytes32 currencyKey, uint debt) public {
        _cachedSynthDebt[currencyKey] = debt;
    }
}
