// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract SlowlyFadingQuietly is ERC1155 {
    uint256 public constant TOKEN1 = 1;
    uint256 public constant TOKEN2 = 2;
    uint256 public constant TOKEN3 = 3;

    uint256 public deploymentTime;

    // Initial metadata URIs (fading)
    string private _fadingURI1 = "ipfs://QmRrUB7h6c4UNUCJoNaEkijXpgE274Qsu489eN1aVEmMSC";
    string private _fadingURI2 = "ipfs://QmTMms3bQdDGHbdxcTv26m4uxwcQNafV3mBd2ZWSfkEdVt";
    string private _fadingURI3 = "ipfs://QmaQp1G7rG4TWosfsGwAxFby5yEukVpa1Kp5rLPNm9SqS2";

    // Final metadata URIs to be used after 8 years
    string private _finalURI1 = "ipfs://QmQgkrdu9RjAGCaSTZ4HnfyqCv8TU799i1WrZ5cm5ucn4A";
    string private _finalURI2 = "ipfs://QmaVWsM7gnSvgfGaCdjztpWvmL9ZjDrH31xBFTGmYHmLmu";
    string private _finalURI3 = "ipfs://QmPogXJrNawWJvyf8wV9VtNTcJuD6fmUZEt3tbQAh729T1";

    constructor() ERC1155("") {
        deploymentTime = block.timestamp;
        
        // Mint initial tokens to the contract deployer
        _mint(msg.sender, TOKEN1, 1, "");
        _mint(msg.sender, TOKEN2, 1, "");
        _mint(msg.sender, TOKEN3, 1, "");
    }

    function uri(uint256 tokenId) public view override returns (string memory) {
        require(tokenId >= TOKEN1 && tokenId <= TOKEN3, "Invalid token ID");

        if (block.timestamp >= deploymentTime + 8 * 365 days) {
            if (tokenId == TOKEN1) return _finalURI1;
            if (tokenId == TOKEN2) return _finalURI2;
            if (tokenId == TOKEN3) return _finalURI3;
        } else {
            if (tokenId == TOKEN1) return _fadingURI1;
            if (tokenId == TOKEN2) return _fadingURI2;
            if (tokenId == TOKEN3) return _fadingURI3;
        }

        revert("Invalid token ID");
    }
}
