//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Bank {
    mapping(address => uint256) balances;

    function sendEtherToContract() external payable {
        balances[msg.sender] = msg.value;
    }

    function showBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    function withDraw(address payable to, uint256 amount) external {
        require(balances[msg.sender] >= amount, "not enough");

        to.transfer(amount);
        // payable(msg.sender).transfer(balances[msg.sender]);

        balances[msg.sender] -= amount;
    }

    //transfer()  : yeterli miktarı göndermezsek geri çevrilir.
    //send() : true ya da false döner
    //call() : 2 değer döner -> true-false ve data(bool sent, bytes memory data) = to.call()
}
