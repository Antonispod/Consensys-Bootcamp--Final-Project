// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 <0.9.0;

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
    }

    // Deposited amount
    modifier paidEnough(uint _price) { 
        require(msg.value >= _price); 
    }

    // Maybe I dont need it, create a require !!!!!!!!!!!!!!!!!!!
    modifier checkValue(uint _id) {                                                                                      // WHy we use it?
        uint _price = totalAthletes[_id].price;
        uint amountToRefund = msg.value - _price;
        totalAthletes[_id].buyer.transfer(amountToRefund);
        _;
    }

    // Create a modifier, if the athlete paid or not !!!!!!!!!!!!!
    modifier

// -------------------------------FUNCTIONS-------------------------------------

    //--------EVENTS--------------------------------

    //Create a function for the events to decided the price for the races !!!!!!!!!!!!!!!
    function initializeRace (string _racename, int _price, string _country)  public return (uint) {
        totalRaces[raceCount] =  RaceRegistration({
        racename:_racename,
        price: _price,
        country:_country,
        owner: payable(msg.sender),
        active: true,
        }
        raceCount = raceCount +1;
        emit NewEvent (racename);
        return raceCount-1;
    }

    // If the event is inactive
    function raceStatus(uint raceNumber) public 
    isOwner(totalRaces[raceNumber].owner)
    {
        totalRaces[raceNumber].active = false;
    }

    // -------------ATHLETES----------------------

    function addAthlete(string memory _name, uint _age, string _gender) public return (uint){
        totalAthletes[msg.sender] = AthleteRegistration({
        name: _name, 
        age: _age,
        gender: _gender,
        status: Status.notPaid,
        payer: payable(msg.sender),
        {
        athlCount=athlCount+1
        emit NewAthlete (athlcount);
        return athlCount-1;
    }



    // Select race 
    function selectRace(uint _raceCount) public 
    isOwner(totalAthletes[msg.sender].payer)
    paidEnough(totalRaces[_raceCount].price)
    {
        (bool sent, bytes memory data) = totalRaces[_raceCount].owner.call{value: totalRaces[_raceCount].price}("");
        require(sent, "Failed to make the transaction!");

        registeredAthletes[_raceCount].push(msg.sender);   // If it doesnt work (push), ask Maria!!!!!!
        registeredRaces[msg.sender].push(_raceCount);
                                                            // Here, they must receie the NFT!!!!!!!
        emit SelectedRace (racename);
    } 
}