//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract Interact {
    address public caller;
    mapping(address => uint256) public counts;

    function callThis() external {
        caller = msg.sender;
        counts[msg.sender]++;
    }
}

contract Pay {
    mapping(address => uint256) public userBalances;

    function patEther(address _payer) external payable {
        userBalances[_payer] += msg.value;
    }
}

contract Caller {
    Interact interact; //ınteract contractından bir instance oluşturuyoruz.

    constructor(address _interactContract) {
        interact = Interact(_interactContract); //constructorun içinde instance'a contractımın adresini veriyorum.
    }

    function callInteract() external {
        interact.callThis(); //fonksiyonlara erişmek
    }

    function readInteract() external view {
        interact.caller(); //değişkenleri de fonksiyon gibi çağırmamız gerekiyor.
    }

    function payToPay(address _payAdress) public payable {
        Pay pay = Pay(_payAdress);
        pay.patEther{value: msg.value}(msg.sender); //buraya gelen mesajın value değerini de gönderiyorum.
    }

    function sendEthByTransfer() public payable {
        //bu fonksiyon çalışmaz çünkü fallback ve receive fonksiyonları bu contractta yok.
        payable(address(interact)).transfer(msg.value);
    }
}
