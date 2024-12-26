// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IToken {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract GadgetRentalService {

    // Struct to represent a gadget available for rent
    struct Gadget {
        string name;       // Name of the gadget (e.g., "iPhone 12", "Macbook Pro")
        uint256 pricePerDay; // Rental price per day in tokens
        uint256 depositAmount; // Deposit amount in tokens
        bool isAvailable;    // Availability status
    }

    // Struct to represent a rental agreement
    struct RentalAgreement {
        address renter;     // The address of the person renting the gadget
        uint256 startDate;  // The start date of the rental
        uint256 endDate;    // The end date of the rental
        uint256 depositPaid; // Deposit paid by the renter
        bool isReturned;    // Whether the gadget has been returned
    }

    // List of gadgets available for rent
    mapping(uint256 => Gadget) public gadgets;
    
    // Rental agreements mapping (gadgetId -> renter address -> RentalAgreement)
    mapping(uint256 => mapping(address => RentalAgreement)) public rentalAgreements;

    // Address of the token used for payments (ERC-20 token)
    IToken public paymentToken;

    // Event to log when a gadget is rented
    event GadgetRented(address indexed renter, uint256 gadgetId, uint256 startDate, uint256 endDate);

    // Event to log when a gadget is returned
    event GadgetReturned(address indexed renter, uint256 gadgetId, uint256 refundAmount);

    // Constructor to set the token address for payments
    constructor(address tokenAddress) {
        paymentToken = IToken(tokenAddress);
    }

    // Function 1: Rent a gadget for a specified period
    function rentGadget(uint256 gadgetId, uint256 rentalDays) external {
        // Get the gadget details
        Gadget storage gadget = gadgets[gadgetId];
        
        // Ensure the gadget is available
        require(gadget.isAvailable, "This gadget is not available for rent.");

        // Calculate the total rental price and deposit amount
        uint256 rentalPrice = gadget.pricePerDay * rentalDays;
        uint256 depositAmount = gadget.depositAmount;

        // Transfer the rental price and deposit from the renter
        bool rentalPaid = paymentToken.transferFrom(msg.sender, address(this), rentalPrice);
        require(rentalPaid, "Rental payment failed.");
        
        bool depositPaid = paymentToken.transferFrom(msg.sender, address(this), depositAmount);
        require(depositPaid, "Deposit payment failed.");

        // Store the rental agreement
        rentalAgreements[gadgetId][msg.sender] = RentalAgreement({
            renter: msg.sender,
            startDate: block.timestamp,
            endDate: block.timestamp + rentalDays * 1 days,
            depositPaid: depositAmount,
            isReturned: false
        });

        // Mark the gadget as unavailable
        gadget.isAvailable = false;

        // Emit event for the rental
        emit GadgetRented(msg.sender, gadgetId, block.timestamp, block.timestamp + rentalDays * 1 days);
    }

    // Function 2: Return a rented gadget and get the deposit refunded (if on time)
    function returnGadget(uint256 gadgetId) external {
        // Get the rental agreement for the gadget and renter
        RentalAgreement storage agreement = rentalAgreements[gadgetId][msg.sender];
        
        // Ensure the renter has a valid rental agreement
        require(agreement.renter == msg.sender, "You have not rented this gadget.");
        require(!agreement.isReturned, "This gadget has already been returned.");
        
        // Ensure the rental period has ended or check for late return
        require(block.timestamp <= agreement.endDate, "Rental period has expired.");

        // Refund the deposit
        uint256 refundAmount = agreement.depositPaid;
        bool refundPaid = paymentToken.transfer(msg.sender, refundAmount);
        require(refundPaid, "Refund failed.");

        // Mark the rental as returned
        agreement.isReturned = true;

        // Mark the gadget as available again
        gadgets[gadgetId].isAvailable = true;

        // Emit event for the return
        emit GadgetReturned(msg.sender, gadgetId, refundAmount);
    }

    // Function to add a new gadget to the rental service (only accessible by the owner)
    address public owner = msg.sender;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can add gadgets.");
        _;
    }

    function addGadget(string calldata name, uint256 pricePerDay, uint256 depositAmount) external onlyOwner {
        uint256 gadgetId = uint256(keccak256(abi.encodePacked(name, pricePerDay, depositAmount)));
        gadgets[gadgetId] = Gadget({
            name: name,
            pricePerDay: pricePerDay,
            depositAmount: depositAmount,
            isAvailable: true
        });
    }
}
