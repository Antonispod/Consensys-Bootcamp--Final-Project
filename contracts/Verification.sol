// License
pragma solidity ^0.8.7;

// - Someone pays to run and complete his info.
// - All these data gathered and exported in an excel sheet
// - When a runner complete his registration, receives a QR code
// - WIth this QR code, he is gonna take the clothes, medal, etc (if he paid)
// - In the end, he will receive an NFT as a reward

import //Details like name, surname, email, number and gender

// Name of the contract
contract Verification {

    // create an event 
    ??

    // With struct I create a new type of data
    struct VerifiedPerson {
        bytes32 name;
        bytes VerifID;
    }

    // There are a few addresses that are allowed to verify a QR code (is it valid or not)
    ?? (ti akrivws einai auto??) mapping(address => bool) verifiers; 

    // Verify if the runners are valid or not
    mapping(address => VerifiedPerson) VerifiedPeople;

    // The single source of truth is the vaccine serial number. It's unique and has to be contained in 
    // the database of the running event.
    mapping(bytes => bool) legitVerifiedID;



    // Modifier can be called in functions and depends on the require, it will be run or passed.
    // _ exists in order to seperate the value from a similar one
    
    // We can have unique addresses and not doubles
    // No need to overcharge
    modifier onlyRegisterOnce(address _personAddress) {
        require(VerifiedPeople[_personAddress].name.length == 0);
        _;
    }

    // Verifiers are True or False
    // Our super-users
    modifier onlyVerifiers(address _verifierAddress) {
        require(verifiers[_verifierAddress]);
        _;
    }

    // Our legit verification serial numbers
    modifier onlyLegitVerifiedID(bytes memory serialNumber) {
        require(legitVerifiedID[serialNumber]);
        _;
    }

    // Initialize the verifiers
    constructor(address[] memory _verifiers){
        // All the initial addresses should be verifiers - True
        for(uint i = 0; i < _verifiers.length; i++) {
            verifiers[_verifiers[i]] = true;
        }
    }

    // Register Vaccinated Person
    function registerVerifiedPerson(address _vaccinated, bytes32 name, bytes memory vaccineSerialNumber) public payable onlyRegisterOnce(_vaccinated) onlyLegitVaccineSerialNumbers(vaccineSerialNumber) returns (string memory qrCode){
        // QRCode string is produced and returned
        qrCode = "12343124";

        // The object with the QRCode is stored as a struct
        vaccinatedPeople[_vaccinated] = VaccinatedPerson(name, vaccineSerialNumber);
    }

    // Somehow we need to verify that this person is registered
    function verifyRegisteredPerson(string memory qrCode) public view onlyVerifiers(msg.sender) returns (bytes32 name){
        // decode qrCode and produce the address!
        address toVerify = 0x0000000000000000000000000000000000000000;
        
        name = vaccinatedPeople[toVerify].name;
    }
}
