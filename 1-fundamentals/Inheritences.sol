//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Human {
    uint256 public age;
    string public name;

    function setAge(uint256 _age) public {
        require(_age > 0, "Age cannot be negative");
        age = _age;
    }

    function getAge() public view returns (uint256) {
        return age;
    }

    function setName(string memory _name) public virtual {
        name = _name;
    }

    function getName() public view virtual returns (string memory) {
        return name;
    }
}

contract Woman is Human, Ownable {
    uint256 salary;

    function setSalary(uint256 _salary) public {
        require(_salary >= 0, "salary cannot be negative");
        salary = _salary;
    }

    function getSalary() public view returns (uint256) {
        return salary;
    }

    function setName(string memory _name) public override onlyOwner {
        name = _name;
    }
}
