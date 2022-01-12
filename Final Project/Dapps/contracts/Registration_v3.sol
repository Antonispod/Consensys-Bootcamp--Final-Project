// SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.7;

// ---------------------------------- Verification contract ------------------------------

contract Registration {

    //Owner 
    address public owner;

    //Athletes that will run
    uint public athlCount=0;

    //Events that exist
    uint public raceCount=0;

    //Athlete mapping
    mapping (address => AthleteRegistration) public totalAthletes;

    //Race mapping
    mapping (uint => RaceRegistration) public totalRaces;

    // Choose race mapping
    mapping (address => uint[]) public registeredRaces;

    // Athletes per race
    mapping (uint => address[]) public registeredAthletes;

//--------------------------------ENUM---------------------------------

    //Create enum for the race selection
    enum Status{Paid, notPaid}
    enum Gender{Male, Female, Other}

//---------------------------------STRUCTS------------------------------

    // For the runners
    struct AthleteRegistration{
        string name; 
        uint age;
        Gender gender;
        uint athlCount; 
        Status status;
        address payable payer; 
    }

    // For the events 
    struct RaceRegistration{
        bool active;
        string racename;
        string country;
        uint price;  
        address payable owner;
    }

//----------------------------------EVENTS--------------------------------------

    // Events
    event NewAthlete (uint athlCount);
    event NewEvent (string racename);
    event SelectedRace (string racename);
    //event LogForNewAthlete (uint indexed id);  // Indexed can be used in 3 parameters max
    //event EventPaid (Race indexed race);    // With indexed you can search for the parameter
    //event NFTreceive (uint id);
    //event verifyPayer(uint id);

//----------------------------------MODIFIERS-----------------------------------

    // Modifiers
    // Owner
    modifier isOwner (address _owner) {
        require(msg.sender == _owner);
        _;
    }

    // Deposited amount
    modifier paidEnough(uint _price) { 
        require(msg.value == _price);
        _; 
    }

    // Maybe I dont need it, create a require !!!!!!!!!!!!!!!!!!!
    // modifier checkValue(uint _id) {                                                                                      // WHy we use it?
    //     uint _price = totalAthletes[_id].price;
    //     uint amountToRefund = msg.value - _price;
    //     totalAthletes[_id].buyer.transfer(amountToRefund);
    //     _;
    // }

    // Create a modifier, if the athlete paid or not !!!!!!!!!!!!!
    // modifier

// -------------------------------FUNCTIONS-------------------------------------

    //--------EVENTS--------------------------------

        constructor() {
        owner = msg.sender;
    } 

    //Create a function for the events to decided the price for the races !!!!!!!!!!!!!!!
    function initializeRace (string memory _racename, uint _price, string memory _country) isOwner(owner) public returns(uint) {
        totalRaces[raceCount] =  RaceRegistration({
        racename:_racename,
        price: _price, //manipulate wei to Eth
        country:_country,
        owner: payable(msg.sender),
        active: true
        });
        raceCount = raceCount +1;
        emit NewEvent (_racename);
        return raceCount-1;
    }

    // If the event is inactive
    function raceStatus(uint raceNumber) public view returns (bool)
    // isOwner(totalRaces[raceNumber].owner)
    {
        bool activ = totalRaces[raceNumber].active; 
        return(activ);
        // totalRaces[raceNumber].active = false;
    }

    // -------------ATHLETES----------------------

    function addAthlete(string memory _name, uint _age, Gender _gender, uint _payment, uint _raceCount) payable public returns(uint) {
        uint pric = totalRaces[_raceCount].price;

        require(_payment == pric, "Didnt pay enough");
        (bool success, bytes memory data) = (totalRaces[_raceCount].owner).call{value: msg.value}("");
         
        totalAthletes[msg.sender] = AthleteRegistration({
        name: _name, 
        age: _age,
        gender: _gender,
        athlCount: athlCount+1,
        status: Status.Paid, // Add payment, then changes to paid
        payer: payable(msg.sender)
        });


        // athlCount=athlCount+1;
        emit NewAthlete (athlCount);
        return athlCount-1;
    }



    // NFT mint (It needs work)
    // function mintForPurchase(address recipient) private{
    //     _tokenIds.increment();

    //     require(_tokenIds.current() <= _maxMintable, "Project is finished minting.");
    //     uint256 newItemId = _tokenIds.current();
    //     _mint(recipient, newItemId);
    // }

}
/*
    // Select race 
    function selectRace(uint _raceCount, ) public S
    isOwner(totalAthletes[msg.sender].payer)
    // paidEnough(totalRaces[_raceCount].price)
    {

        (bool sent, bytes memory data) = totalRaces[_raceCount].owner.call{
            value: totalRaces[_raceCount].price}("");
        require(sent, "Failed to make the transaction!");

        registeredAthletes[_raceCount].push(msg.sender);   // If it doesnt work (push), ask Maria!!!!!!
        registeredRaces[msg.sender].push(_raceCount);
                                                            // Here, they must receie the NFT!!!!!!!
        // emit SelectedRace(_racename);
    }
}
*/