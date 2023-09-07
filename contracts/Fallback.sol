// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Fallback {
    event Log(string func);

    fallback() external payable {
        emit Log("fallback");
    }

    receive() external payable {
        emit Log("receive");
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendToFallBack {
    function callFallback(address payable to) public payable {
        (bool success, ) = to.call{value: msg.value}("");
        require(success, "La transaction a echoue");
    }
}
