//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

library Math {
    function plus(uint256 x, uint256 y) public pure returns (uint256) {
        return x + y;
    }
}

contract Library {
    using Math for uint256;

    function trial(uint256 x, uint256 y) public pure returns (uint256) {
        // return Math.plus(x,y);
        return x.plus(y);
    }
}

// not :: calldata tipindeki değişkenler sadece readable //storage ise direkt hafızada saklar değiştirmek için kullan
//memoryi ise sadece okumak için
