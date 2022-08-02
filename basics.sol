// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

contract Functions {
    bytes32 private hashedPassword;

    int256 public luckyNumber = 7;

    mapping(address => bool) public registered;

    constructor(string memory _password) {
        hashedPassword = keccak256(abi.encode(_password)); //hashleme fonsksiyonu
    }

    function login(string memory _password) public view returns (bool) {
        return hashedPassword == keccak256(abi.encode(_password));
    }

    function register() public {
        require(!registered[msg.sender], "You register before!"); //bu fonksiyonu bir kere çalıştırmak için
        registered[msg.sender] = true;
    }

    function isRegistered() public view returns (bool) {
        return registered[msg.sender];
    }

    function deleteRegistered() public {
        require(isRegistered(), "No exists user");
        delete (registered[msg.sender]);
    }

    function setNumber(int256 newNumber) public {
        luckyNumber = newNumber;
    }

    function getNumber() public view returns (int256) {
        return luckyNumber;
    }

    function getNumbers()
        public
        pure
        returns (
            int256,
            int256,
            int256
        )
    {
        return (5, 6, 7);
    }
}

contract NestedMapping {
    mapping(address => mapping(address => uint256)) public dict;

    function incDebt(address _borrower, uint256 _amount) public {
        dict[msg.sender][_borrower] += _amount;
    }

    function descDebt(address _borrower, uint256 _amount) public {
        require(dict[msg.sender][_borrower] >= _amount, "Not enough debt");
        dict[msg.sender][_borrower] -= _amount;
    }

    function getDebt(address _borrower) public view returns (uint256) {
        return dict[msg.sender][_borrower];
    }
}
