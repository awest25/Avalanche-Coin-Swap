// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract AtomicSwapAvalance {
    // using SafeMath for uint256;

    bytes32 public hashedsecret;
    address payable recipient; // Bob's address
    address payable sender; // Alice's address
    uint256 public amountDeposited1;
    uint256 public amountDeposited2;
    uint256 public expirationTime;
    bool public isInitiated = false;
    bool public hasParticipated = false;

    // Used by the party creating the swap.
    // Args: hashed secret, recipient addr, timeout duration.
    // Locks the tokens in the contract until the swap is completed or the timeout is reached.
    function  initiate(bytes32 _hashedsecret, address payable _recipient, uint256 _duration) public payable
    {
        require(!isInitiated, "The atomic swap has already been initiated");
        isInitiated = true;

        hashedsecret = _hashedsecret;
        recipient = _recipient;
        sender = payable(msg.sender);
        amountDeposited1 = msg.value;  // Amount of Ether deposited
        expirationTime = block.timestamp + _duration;
    }

    // Used by the other party to confirm participation in the swap.
    // Locks their tokens in the contract.
    function participate() public payable
    {
        require(!hasParticipated, "There is already a recieving participant");
        require(isInitiated, "The swap has not yet been initiated");
        require(msg.sender == recipient, "The sender address is incorrect");
        hasParticipated = true;

        amountDeposited1 = msg.value;  // Amount of Ether deposited
    }

    // Used by both parties to claim their tokens. Args: secret value.
    // It must verify secret against the stored hash, and transfer the locked tokens to the appropriate party.
    function redeem(bytes32 _secret) public
    // TODO Alice needs to redeem
    {
        require(isInitiated, "The swap has not yet been initiated");
        require(hasParticipated, "The recieving participant has not made a deposit");

        require(sha256(abi.encodePacked(_secret)) == hashedsecret, "The provided secret is incorrect");
        recipient.transfer(amountDeposited1); // Transfer to Bob after he submits the secret

        isInitiated = false;
        hasParticipated = false;
    }

    // If the timeout reached before the swap completes.
    // Allows the original sender to reclaim their tokens.
    function refund() public
    {
        require(isInitiated, "The swap has not yet been initiated");
        require(hasExpired(), "Sufficient duration since deposit has not passed");
        sender.transfer(amountDeposited1);

        isInitiated = false;
        hasParticipated = false;
    }

    function hasExpired() public view returns (bool) {
        return block.timestamp >= expirationTime;
    }
}