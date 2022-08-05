// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

contract StructEnum {
    enum Status {
        Taken,
        Preparing,
        Boxed,
        Shipped
    }

    struct Order {
        address customer;
        string zipCode;
        uint256[] products;
        Status status;
    }

    Order[] public orders;
    address public owner;

    event OrderCreated(uint256 _orderId, address indexed _consumer); //indexed ile daha önceki eventlerde consumer ile sorgu atabileceğiz

    constructor() {
        owner = msg.sender;
    }

    function createOrder(string memory _zipCode, uint256[] memory _products)
        public
        checkProducts(_products)
        returns (uint256)
    {
        orders.push(
            Order({
                customer: msg.sender,
                zipCode: _zipCode,
                products: _products,
                status: Status.Taken
            })
        );

        emit OrderCreated(orders.length - 1, msg.sender);
        return orders.length - 1;
    }

    function advanceOrder(uint256 _orderId) public {
        require(owner == msg.sender, "You are not authorized");
        require(_orderId < orders.length, "Not a valid order Id");
        Order storage order = orders[_orderId]; //pointer oluşturuyorum
        require(order.status != Status.Shipped, "Order is already shipped");

        if (order.status == Status.Taken) {
            order.status = Status.Preparing;
        } else if (order.status == Status.Preparing) {
            order.status = Status.Boxed;
        } else if (order.status == Status.Boxed) {
            order.status = Status.Shipped;
        }
    }

    modifier checkProducts(uint256[] memory _products) {
        require(_products.length > 0, "there is no product");
        _;
    }
}
