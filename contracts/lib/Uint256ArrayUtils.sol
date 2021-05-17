// SPDX-License-Identifier: Apache License, Version 2.0
pragma solidity 0.6.10;

/**
 * @title Uint256ArrayUtils
 * @author dPassive Finance
 *
 * Utility functions to handle uint256 Arrays
 */
library Uint256ArrayUtils {

    /**
     * Finds the index of the first occurrence of the given element.
     * @param A The input array to search
     * @param a The value to find
     * @return Returns (index and isIn) for the first occurrence starting from index 0
     */
    function indexOf(uint256[] memory A, uint256 a) internal pure returns (uint256, bool) {
        uint256 length = A.length;
        for (uint256 i = 0; i < length; i++) {
            if (A[i] == a) {
                return (i, true);
            }
        }
        return (uint256(-1), false);
    }

    /**
    * Returns true if the value is present in the list. Uses indexOf internally.
    * @param A The input array to search
    * @param a The value to find
    * @return Returns isIn for the first occurrence starting from index 0
    */
    function contains(uint256[] memory A, uint256 a) internal pure returns (bool) {
        (, bool isIn) = indexOf(A, a);
        return isIn;
    }

    /**
    * Returns true if there are 2 elements that are the same in an array
    * @param A The input array to search
    * @return Returns boolean for the first occurrence of a duplicate
    */
    function hasDuplicate(uint256[] memory A) internal pure returns(bool) {
        require(A.length > 0, "A is empty");

        for (uint256 i = 0; i < A.length - 1; i++) {
            uint256 current = A[i];
            for (uint256 j = i + 1; j < A.length; j++) {
                if (current == A[j]) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * @param A The input array to search
     * @param a The uint256 to remove     
     * @return Returns the array with the object removed.
     */
    function remove(uint256[] memory A, uint256 a)
        internal
        pure
        returns (uint256[] memory)
    {
        (uint256 index, bool isIn) = indexOf(A, a);
        if (!isIn) {
            revert("uint256 not in array.");
        } else {
            (uint256[] memory _A,) = pop(A, index);
            return _A;
        }
    }

    /**
     * @param A The input array to search
     * @param a The uint256 to remove
     */
    function removeStorage(uint256[] storage A, uint256 a)
        internal
    {
        (uint256 index, bool isIn) = indexOf(A, a);
        if (!isIn) {
            revert("uint256 not in array.");
        } else {
            uint256 lastIndex = A.length - 1; // If the array would be empty, the previous line would throw, so no underflow here
            if (index != lastIndex) { A[index] = A[lastIndex]; }
            A.pop();
        }
    }

    /**
    * Removes specified index from array
    * @param A The input array to search
    * @param index The index to remove
    * @return Returns the new array and the removed entry
    */
    function pop(uint256[] memory A, uint256 index)
        internal
        pure
        returns (uint256[] memory, uint256)
    {
        uint256 length = A.length;
        require(index < A.length, "Index must be < A length");
        uint256[] memory newUint256s = new uint256[](length - 1);
        for (uint256 i = 0; i < index; i++) {
            newUint256s[i] = A[i];
        }
        for (uint256 j = index + 1; j < length; j++) {
            newUint256s[j - 1] = A[j];
        }
        return (newUint256s, A[index]);
    }

    /**
     * Returns the combination of the two arrays
     * @param A The first array
     * @param B The second array
     * @return Returns A extended by B
     */
    function extend(uint256[] memory A, uint256[] memory B) internal pure returns (uint256[] memory) {
        uint256 aLength = A.length;
        uint256 bLength = B.length;
        uint256[] memory newUint256s = new uint256[](aLength + bLength);
        for (uint256 i = 0; i < aLength; i++) {
            newUint256s[i] = A[i];
        }
        for (uint256 j = 0; j < bLength; j++) {
            newUint256s[aLength + j] = B[j];
        }
        return newUint256s;
    }

    /**
     * Validate uint256 array is not empty and contains no duplicate elements.
     *
     * @param A          Array of uint256
     */
    function _validateLengthAndUniqueness(uint256[] memory A) internal pure {
        require(A.length > 0, "Array length must be > 0");
        require(!hasDuplicate(A), "Cannot duplicate uint256");
    }
}