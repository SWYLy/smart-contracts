<p align="center">
<br />
<a href="https://github.com/syns-platform"><img src="https://github.com/syns-platform/Syns-Platform/blob/main/brandings/main/Syns_Official_Main_Logo_V3.svg?raw=true" width="150" alt=""/>
<h1 align="center">Syns Platform | Spark Your Noble Story </h1>
<h4 align="center"> ✨ The platform is currently open for beta testing at <a href="https://syns-platform.com">https://syns-platform.com</a> ✨</h4>
<h5 align="center"> 🪜 Work In Progress... 🪜</h5>
</p>

<div align="center">

![](https://img.shields.io/badge/TypeScript-4.5.0-blue?style=flat-square&logo=typescript)
![](https://img.shields.io/badge/Solidity-0.8.11-blue?style=flat-square&logo=solidity)
![](https://img.shields.io/badge/OpenZeppelin-4.8.0-blue?style=flat-square&logo=openzeppelin)
![](https://img.shields.io/badge/Hardhat-2.12.7-blue?style=flat-square&logo=hardhat)
![](https://img.shields.io/badge/Ethers-5.4.7-blue?style=flat-square&logo=ethersjs)
![](https://img.shields.io/badge/Mocha-9.1.0-blue?style=flat-square&logo=mocha)

</div>

## Overview

**_SYNS/contracts_**, a suite of smart contracts, written in [Solidity](https://soliditylang.org/), that are deployed on the [Polygon network](https://polygon.technology/matic-token/). This collection of smart contracts serves as the backbone for the platform's decentralized functionality and enables secure, transparent, and immutable transactions.

## Hightlighted features

- [SynsERC721](https://github.com/syns-platform/contracts/blob/main/contracts/v1/SynsERC721.sol) - includes all the standard features of an NFT industry, as defined by the `ERC721 specification` from [OpenZeppelin](https://docs.openzeppelin.com/contracts/4.x/api/token/erc721), as well as additional custom logic developed by SYNS to automatically set the default royalty fee for new NFTs as soon as they are minted.

* [SynsERC1155](https://github.com/syns-platform/contracts/blob/main/contracts/v1/SynsERC1155.sol) - includes all the standard features of the NFT industry as defined by the [ERC1155 specification](https://ethereum.org/en/developers/docs/standards/tokens/erc-1155/), as well as additional custom logic developed by SYNS.

* [SynsDonation](https://github.com/syns-platform/contracts/blob/main/contracts/v1/SynsDonation.sol) - allows users to make donations to other users using any type of cryptocurrency. All transactions are transparently recorded on the blockchain for full transparency.

* [SynsMarketPlace](https://github.com/syns-platform/contracts/blob/main/contracts/v1/SynsMarketplace.sol) - combination of various safe, gas-optimizing, and well-tested features from the [Thirdweb Marketplace](https://github.com/thirdweb-dev/contracts/blob/main/contracts/marketplace/Marketplace.sol) and a range of complex custom logic developed by SYNS. `SynsMarketplace` is able to:

  - Enable token owners to create, update, and cancel NFT listings for sale on the blockchain

  - Safely facilitate the buying and transfer of NFTs on behalf of the seller, automatically transferring the sale price from the buyer's to the seller's crypto wallet address

  - automatically calculates and transfers [royties](https://www.nftgators.com/nft-royalties-explained/) to original creator

* [SynsClub](https://github.com/syns-platform/contracts/blob/main/contracts/v1/SynsClub.sol) - most honored and complex out of the five contracts, powers all the complex Syns membership logic. SynsClub is able to:

  - Allow potential club owners to create a `SYNS Club` and add multiple membership plans, known as `SYNS Tiers`, where the owner can configure their desired membership fee and limit the number of members in each tier, as well as update the metadata at any time.

  - Enable club owners to easily track the total and active members in each `SYNS Tier` and periodically request to remove inactive members.

  - Allow potential subscribers to subscribe or unsubscribe to any `SYNS Tier` in any `SYNS Club` on the platform. The `SYNS Club` automatically calculates the next payment in 30 days for followers, records the date they started following the club, and increases the SYNS Royalty Stars (an honor system based on how long a follower has been following the club).

# Get Started

## Requirement

- [git](https://git-scm.com/)
- [node.js](https://nodejs.org/en/)
- [pnpm](https://pnpm.io/)
- [metamask](https://metamask.io/)

## Quickstart

```
git clone https://github.com/syns-platform/contracts.git
cd contracts
pnpm
```

## Running the project

#### 1. Set environment variables

- create a `.env` file using the `.example.env` as the template and fill out the variables.

  - `SYNS_SERVICE_PRIVATE_KEY:` The private key of your [metamask](https://metamask.io/) account. See [Helpers.PRIVATE-KEY](https://github.com/syns-platform/contracts#1-how-to-export-private_key-from-your-metamask) on how to export your `PRIVATE KEY`. NOTE: FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT AND DO NOT SHARE YOUR PRIVATE KEY.
  - `MUMBAI_RPC_URL`: This is url of the `Mumbai` testnet node you're working with then deploy the `smart contracts` to. Setup with one for free from [Alchemy](https://www.alchemy.com/). See [Helpers.MUMBAI-RPC-URL](https://github.com/syns-platform/contracts#2-how-to-export-a-mumbai_rpc_url-from-alchemy) on how to export a `MUMBAI_RPC_URL` from [Alchemy](https://www.alchemy.com/).
  - `COINMARKETCAP_API_KEY`: This is mainly for the `hardhat-gas-report` pluggin so this is optional. If you want to play with `hardhat-gas-report` pluggin, first go to `hardhat.config.ts`, toggle the `gasReporter.enabled` to true. Then see [Helpers.COINMARKETCAP_API_KEY](https://github.com/syns-platform/contracts#3-how-to-export-a-coinmarketcap_api_key-from-coinmarketcap) on how to export your `COINMARKETCAP_API_KEY` (deprecated)

  #### 2. Get testnet `MUMBAI MATIC`

- Head to [Mumbai Faucet](https://mumbaifaucet.com/)
- Sign into the site using the [Alchemy](https://www.alchemy.com/) account you've created for the `MUMBAI_RPC_URL`
- Paste your [metamask](https://metamask.io/) `PUBLIC_KEY` a.k.a `account's address` (not `PRIVATE_KEY`)
- Hit `Send Me MATIC` to get free `MUMBAI MATIC`

#### 3. `Compile` smart contracts

###### 3.1 Using make command + hardhat

```
make compile
```

###### 3.2 Using pnpm + hardhat

```
pnpm hardhat compile
```

#### 4. `Deploy` smart contracts to `Hedera Testnet`

###### 4.1 Using make command + hardhat

```
make deploy
```

###### 4.2 Using pnpm + hardhat

```
pnpm hardhat run ./deploy-scripts/v1/ --network hedera_testnet
```

#### 5. `Verify` smart contracts on [etherscan](https://goerli.etherscan.io/)

###### 5.1 Using make command + hardhat

```
make verify
```

###### 5.2 Using pnpm + hardhat

5.2.a. verify SynsClub Smart Contract

```
pnpm hardhat verify --network hedera_testnet ${SYNSCLUB_CONTRACT_ADDRESS_FROM_DEPLOY_PHASE} ${NATIVE_TOKEN_WRAPPER_ADDRESS}
```

5.2.b. verify SynsDonation Smart Contract

```
pnpm hardhat verify --network hedera_testnet ${SYNSDONATION_CONTRACT_ADDRESS_FROM_DEPLOY_PHASE} ${NATIVE_TOKEN_WRAPPER_ADDRESS}
```

5.2.a. verify Club Smart Contract

```
pnpm hardhat verify --network hedera_testnet ${SYNSERC721_CONTRACT_ADDRESS_FROM_DEPLOY_PHASE}
```

5.2.a. verify Club Smart Contract

```
pnpm hardhat verify --network hedera_testnet ${SYNSERC1155_CONTRACT_ADDRESS_FROM_DEPLOY_PHASE}
```

5.2.a. verify Club Smart Contract

```
pnpm hardhat verify --network hedera_testnet ${SYNSMARKETPLACE_CONTRACT_ADDRESS_FROM_DEPLOY_PHASE} ${NATIVE_TOKEN_WRAPPER_ADDRESS} ${PLATFORM_FEE_SERVICE_RECIPIENT} ${PLATFORM_FEE_BPS(%)}
```

# Helpers

### 1. How to export `PRIVATE_KEY` from your [metamask](https://metamask.io/)

[How to export an account's private key](https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-Export-an-Account-Private-Key)

### 2. How to export a `MUMBAI_RPC_URL` from [Alchemy](https://www.alchemy.com/).

- Go to [Alchemy](https://www.alchemy.com/) => `Signup` => `Signin`
- Hit `CREATE APP` => fill out the form
  ```
    {
      NAME: 'ANY',
      DESCRIPTION: 'ANY',
      CHAIN: 'Polygon',
      NETWORK: 'Mumbai`
    }
  ```
- Now, go to the app you just created. Find and click on the `VIEW KEY` button top-right.
- The `URL` under `HTTPS` is the `MUMBAI_RPC_URL` you want.
- Copy the `URL` and paste it to your `.env` file under `MUMBAI_RPC_URL`

### 3. How to export a `COINMARKETCAP_API_KEY` from [coinmarketcap](https://coinmarketcap.com/)

- Go [here](https://coinmarketcap.com/api/pricing/) and pick the first plan-`GET FREE API KEY`.
- Signup with your email then sign into [coinmarketcap](https://pro.coinmarketcap.com/account)
- Now copy the API Key there and paste it to your `.env` file under `COINMARKETCAP_API_KEY`

# Verified on [Etherscan](https://goerli.etherscan.io/)
