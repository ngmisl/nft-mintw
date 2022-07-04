//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.4;

//We'll first import some OpenZeppelin Contracts. These will provide us with some //utility functions to write the smart contract.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//We'll import the Hardhat console to log messages in the terminal for debugging.
import "hardhat/console.sol";

// We inherit the contract we imported.
// This means we'll have access to the inherited contract's methods.

contract EpicNFT is ERC721URIStorage, Ownable {
    // Counter given by OpenZeppelin to help us keep track of tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // We'll pass the name of our NFTs token and their symbol.
    constructor() ERC721("iykyk", "IK") {
        console.log("This is my NFT contract. Woah!");
    }

    mapping(address => uint) lastTransfers;

    // The public function our user will hit to get their NFT.
    function makeAnNFT() public {
        // set last transfer to check if eligible for claiming
        uint lastTransfer = lastTransfers[msg.sender];

        require(
            lastTransfer + 0.10 hours <= block.timestamp,
            "Patience is a virtue. You can only claim every 6 minutes."
        );

        // Get the current tokenId, this starts at 0.
        uint256 newItemId = _tokenIds.current();

        // Mint the NFT to the sender using msg.sender.
        _safeMint(msg.sender, newItemId);
        lastTransfers[msg.sender] = block.timestamp;

        // Set the NFTs data.
        _setTokenURI(newItemId, "https://jsonkeeper.com/b/IKU9");
        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );

        // Increment the counter for when the next NFT is minted.
        _tokenIds.increment();
    }
}
