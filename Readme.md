# Gadget Rental Service

## Project Description

The **Gadget Rental Service** is a decentralized application (dApp) built on the Ethereum blockchain that allows users to rent gadgets (e.g., smartphones, laptops) in exchange for ERC-20 tokens. The service ensures transparency, security, and automation through smart contracts, enabling seamless transactions between renters and gadget owners.

### Key Features:

- **Rent Gadgets**: Users can rent gadgets by paying the rental price and a deposit in ERC-20 tokens.
- **Return Gadgets**: Users can return gadgets and receive a refund for the deposit, provided the gadget is returned on time.
- **Gadget Availability**: The smart contract ensures the gadgets are available for rent and prevents double bookings.
- **Owner Control**: Only the owner of the contract can add new gadgets to the rental service.

## Project Vision

The vision of the **Gadget Rental Service** is to create a decentralized platform that makes renting gadgets as easy, secure, and transparent as possible. By utilizing blockchain technology, the platform ensures that all rental agreements are immutable and verifiable, preventing fraud and disputes.

This service can be expanded to include a variety of gadgets and offer rewards or penalties based on users' rental behavior, creating a more dynamic and efficient rental ecosystem.

## Key Features

1. **ERC-20 Token Payments**:

   - The platform uses an ERC-20 token to handle all payments and deposits for renting gadgets, ensuring fast and secure transactions.

2. **Rental Agreements**:

   - Smart contracts create rental agreements between the renter and the owner, automatically marking gadgets as rented or available.

3. **Deposit Handling**:

   - Renters must pay a deposit in ERC-20 tokens. If the gadget is returned on time, the deposit is refunded automatically.

4. **Gadget Availability Management**:

   - The owner can add new gadgets to the rental pool with details such as price per day and deposit amount, and gadgets are marked as available or unavailable based on their current rental status.

5. **Event Logging**:

   - Smart contract events like `GadgetRented` and `GadgetReturned` are emitted to keep track of the transactions on the blockchain for transparency.

6. **Security**:
   - Only the owner of the smart contract can add new gadgets, and only the renter can return a rented gadget. The contract ensures no one can rent a gadget if it’s already rented.

## Project Setup

### Requirements:

1. **Node.js**: Required to run a local development environment.
2. **MetaMask**: Browser extension for interacting with the Ethereum blockchain.
3. **Ethereum Test Network**: (e.g., Rinkeby) to deploy the contract.
4. **Web3.js**: JavaScript library to interact with the Ethereum blockchain.

### Steps to Set Up the Project Locally:

1. **Install Dependencies**:

   - Clone the repository:

   ```bash
   git clone <repository-url>
   cd gadget-rental-service
   ```

   - Install required dependencies (if applicable):

   ```bash
   npm install
   ```

2. **Deploy Smart Contract**:

   - Use [Remix IDE](https://remix.ethereum.org/) or any other Solidity IDE to deploy the contract to an Ethereum test network like Rinkeby.
   - After deploying, get the contract's **address** and **ABI**.

3. **Update Frontend**:

   - Replace the `contractABI` and `contractAddress` in the `index.html` file with the correct contract details from your deployment.

4. **Connect Wallet**:

   - Make sure your MetaMask wallet is connected to the same network (e.g., Rinkeby) and contains some test ETH to deploy contracts.

5. **Run Frontend**:
   - Open the `index.html` file in your browser.
   - Use MetaMask to interact with the app. You should be able to:
     - View available gadgets.
     - Rent a gadget by providing the gadget ID and rental duration.
     - Return a rented gadget to get your deposit refunded.

### Usage Instructions:

- **Rent a Gadget**: To rent a gadget, select the gadget ID and input the rental duration in days. The corresponding payment in tokens will be deducted from your wallet.
- **Return a Gadget**: After the rental period is over, you can return the gadget and get the deposit refunded, if the gadget is returned on time.

### Technologies Used:

- **Solidity**: For writing the smart contract on Ethereum.
- **Web3.js**: To interact with Ethereum via JavaScript.
- **ERC-20 Tokens**: For payments and deposits.
- **MetaMask**: To manage Ethereum accounts and transactions.

## Smart Contract Functions

The **Gadget Rental Service** smart contract exposes several functions to enable the core functionality:

- **`rentGadget(uint256 gadgetId, uint256 rentalDays)`**: Rent a gadget for a specified number of days. Requires the renter to pay the rental price and deposit in ERC-20 tokens.
- **`returnGadget(uint256 gadgetId)`**: Return a rented gadget and receive the deposit refund (if the gadget is returned on time).
- **`addGadget(string memory name, uint256 pricePerDay, uint256 depositAmount)`**: Add a new gadget to the rental pool (only accessible by the owner).
- **`gadgets(uint256 gadgetId)`**: View details of a specific gadget (e.g., name, price per day, deposit amount).
- **`rentalAgreements(uint256 gadgetId, address renter)`**: View rental agreements for a specific gadget and renter (e.g., rental start and end dates, deposit paid, return status).

## Future Improvements

- **Rating System**: Implement a rating system where renters and gadget owners can rate each other after the transaction is completed.
- **Late Return Penalties**: Introduce penalties for late returns, which would be deducted from the deposit.
- **Multiple Payment Tokens**: Support multiple ERC-20 tokens for payment options.
- **Admin Features**: Add features for admins to manage rental policies or moderate transactions.

## Contributing

Feel free to fork the repository and submit pull requests for improvements or bug fixes. Contributions are always welcome!

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
