// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract SlowlyFadingQuietly is ERC1155 {
    uint256 public constant TOKEN1 = 1;
    uint256 public constant TOKEN2 = 2;
    uint256 public constant TOKEN3 = 3;

    uint256 public deploymentTime;

    // Initial metadata URIs (fading)
    string private _fadingURI1 = "ipfs://QmYv7P8EdBuNgFhVRhHuJ3cWzT22pSDEuHDcdUxP76KfFM";
    string private _fadingURI2 = "ipfs://QmSFgjF2c4AW27mxa6Lqg2hvt9fND9m5NGngrG5qYVa3Ak";
    string private _fadingURI3 = "ipfs://QmeDvi787Ao9tkroE7iVbwMSpkBjT2AGQFoCpp1XY3C4nE";

    // Final metadata URIs to be used after 8 years
    string private _finalURI1 = "ipfs://QmT7vSvEX3tLQQTiQtRrN9PiuJePwW8zGRvDsSskEoCop2";
    string private _finalURI2 = "ipfs://QmQifecJ3QezrxQmjPnnPBTToDUQ9D8psw6PMnrgQsAJoP";
    string private _finalURI3 = "ipfs://QmP17djcqmjH5K95uzuhfSypk3Cpwvdr5ie8VA1oWzErbM";

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
