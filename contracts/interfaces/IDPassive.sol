pragma solidity ^0.6.10;

interface IDPassive {
    function getPriorVotes(address account, uint blockNumber) external view returns (uint96);
}
