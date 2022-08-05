//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Errors {
    uint256 public totalBalance;
    mapping(address => uint256) public userBalances;

    error ExceedingAmount(address user, uint256 exceedingAmount);
    error Deny(string reason);

    receive() external payable {
        revert Deny("No direct payments");
    }

    fallback() external payable {
        revert Deny("No direct payments");
    }

    function pay() external payable noZero(msg.value) {
        require(msg.value == 1 ether);

        totalBalance += 1 ether;
        userBalances[msg.sender] += 1 ether;
    }

    function withDraw(uint256 _amount) external noZero(_amount) {
        uint256 initialBalance = totalBalance;

        if (userBalances[msg.sender] > _amount) {
            revert ExceedingAmount(
                msg.sender,
                _amount - userBalances[msg.sender]
            );
        }
        totalBalance -= _amount;
        userBalances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        assert(totalBalance < initialBalance);
    }

    modifier noZero(uint256 _amount) {
        require(_amount != 0, "Zero error");
        _;
    }
}
