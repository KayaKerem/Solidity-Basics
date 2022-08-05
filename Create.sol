//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract VaultFactory {
    mapping(address => Vault[]) public userVaults;

    // function createWallet() external{
    //     Vault vault = new Vault(msg.sender);
    //     userVaults[msg.sender].push(vault);
    // }

    function createVaultWithPayment() external payable {
        Vault vault = (new Vault){value: msg.value}(msg.sender);
        userVaults[msg.sender].push(vault);
    }
}

contract Vault {
    address public owner;
    uint256 public balance;

    constructor(address _owner) payable {
        owner = _owner;
        balance += msg.value;
    }

    fallback() external payable {
        require(msg.sender == owner, "You are not authorized");
        balance += msg.value;
    }

    receive() external payable {
        require(msg.sender == owner, "You are not authorized");
        balance += msg.value;
    }

    function getBalance() external view returns (uint256) {
        return balance;
    }

    function deposit() external payable {
        balance += msg.value;
    }

    function withDraw(uint256 _amount) external {
        require(msg.sender == owner, "You are not authorized");
        balance -= _amount;
        payable(owner).transfer(_amount);
    }
}
