/*
    @dev: Logan (Nam) Nguyen
    @Course: SUNY Oswego - CSC 495 - Capstone
    @Instructor: Professor Bastian Tenbergen
    @Version: 1.0
    @Hornor: Thirdweb & Openzeppeline
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

/** EXTERNAL IMPORT */
import "../../libs/thirdweb/ERC1155base.sol";
import "@thirdweb-dev/contracts/extension/PermissionsEnumerable.sol";

/**
 *  The `SwylERC1155` smart contract implements the Thirdweb/ERC1155Base NFT standard.
 *  It includes all the standard logic from ERC1155 PLUS:
 *      - Emit event newTokenMintedTo (if a new token is minted) everytime mintTo() is called
 *      - Emit event mintedOnExistedToken (if more supply is added to an existed token) everytime mintTo() is called
 *      - Records the original creator of the NFT when a new token is created by adding the original creator's address to a mapping
 */
contract SwylERC1155 is ERC1155Base, PermissionsEnumerable {
    /*//////////////////////////////////////////////////////////////
                        Variables
    //////////////////////////////////////////////////////////////*/
    // Mapping(s)
    mapping (uint256 => address) private tokenIdToOriginalCreator;

    // Event(s)
    event newTokenMintedTo(address to, uint256 indexed tokenId, string indexed uri, uint256 amount, uint256 indexed royaltyBps);
    event mintedOnExistedToken(address to, uint256 indexed tokenId, string indexed uri, uint256 amount, uint256 indexed royaltyBps);


    /*//////////////////////////////////////////////////////////////
                        Constructor
    //////////////////////////////////////////////////////////////*/
    constructor() ERC1155Base("Support Who You Love", "SWYL1155"){
        // grant admin role to deployer
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }


    /*//////////////////////////////////////////////////////////////
                        SwylERC1155v1 Logic
    //////////////////////////////////////////////////////////////*/
    
    /**
     *  @dev             - If `_tokenId == getNewTokenRequiredId()` 
     *                          + A new NFT is created at tokenId `nextTokenIdToMint` is minted.
     *                          + Set the royalty recipient to the address msg.sender
     *                          + Emits event newTokenMintedTo().
     *                   - If the given `tokenId < nextTokenIdToMint`, then additional supply of an existing NFT is being minted
     *                      on existed token at _tokenId, and the tokenURI is set to be the same. 
     *                      Emits event mintedOnExistedToken().
     *
     *  @notice          Noted removed onlyRole(DEFAULT_ADMIN_ROLE) => the logic is to let every one mint NFTs not just Swyl Service Admin account
     *
     *  @param _tokenId  The tokenId of the NFT to mint.
     *  @param _tokenURI The full metadata URI for the NFTs minted (if a new NFT is being minted).
     *  @param _amount   The amount of the same NFT to mint.
     */
    function safeMintTo(
        uint256 _tokenId, 
        string memory _tokenURI, 
        uint256 _amount,
        uint256 _royaltyBps
    ) public {
        // newTokenRequiredId is the ID that _tokenId must meet to create a new token. Otherwise, more supply are minted on existed tokens.
        uint newTokenRequiredId = getNewTokenRequiredId();

        // if _tokenId != newTokenRequiredId => msg.sender is required to be the originalAuthor
        if (_tokenId != newTokenRequiredId) {
            require(msg.sender == tokenIdToOriginalCreator[_tokenId], "!AUTHOR - only original author can add more supply to this token");
        }

        // nextTokenIdToMint is the new tokenId of the new token being created.
        uint nextTokenIdToMint = super.nextTokenIdToMint();

        // Calls mintTo() from ERC1155Base
        super.mintTo(msg.sender, _tokenId, _tokenURI, _amount);


        // originalCreator logic
        if (_tokenId == newTokenRequiredId) { // new token is being created
            tokenIdToOriginalCreator[nextTokenIdToMint] = msg.sender;
            _setupRoyaltyInfoForToken(nextTokenIdToMint, msg.sender, _royaltyBps);
            emit newTokenMintedTo(msg.sender, nextTokenIdToMint, _tokenURI, _amount, _royaltyBps);
        } else { // more supplies are being minted on an existed token
            emit mintedOnExistedToken(msg.sender, nextTokenIdToMint, _tokenURI, _amount, _royaltyBps);
        }
    }


    /*//////////////////////////////////////////////////////////////
                        SwylERC1155v1 Getters
    //////////////////////////////////////////////////////////////*/

    /// @dev Returns the biggest uint256 value to set a bar for creating a new token
    function getNewTokenRequiredId() pure public returns (uint256) {
        return type(uint256).max;
    }

    /// @dev Returns originalCreator by tokenId
    function getOriginalCreator(uint _tokenId) view public returns (address) {
        return tokenIdToOriginalCreator[_tokenId];
    }
}