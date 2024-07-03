// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Counter {
    uint64 private counter;

    constructor(
        uint64 _counter
    ) {
        counter  = _counter;
    }

    function get() public view returns(uint64) {
        return counter;
    }

    function add(uint64 addend) public {
        counter += addend;
    }
}