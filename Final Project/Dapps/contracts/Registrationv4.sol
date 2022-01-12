// SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.0;

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
    mapping (address => uint) public registeredRaces;

    // Athletes per race
    mapping (uint => address) public registeredAthletes;

//---------------------------------STRUCTS------------------------------

    // For the runners
    struct AthleteRegistration{
        string name; 
        uint age;
        string gender;
        uint athlCount; 
    }

    // For the events 
    struct RaceRegistration{
        bool active;
        string racename;
        string country;
    }

//----------------------------------EVENTS--------------------------------------

    // Events
    event NewAthlete (uint athlCount);
    event NewEvent (string racename);
    event SelectedRace (string racename);

//----------------------------------MODIFIERS-----------------------------------

    // Modifiers
    // Owner
    modifier isOwner (address _owner) {
        require(msg.sender == _owner);
        _;
    }


// -------------------------------FUNCTIONS-------------------------------------

    constructor() {
        owner = msg.sender;
    } 

    //Create a function for the events to decided the price for the races !!!!!!!!!!!!!!!
    function initializeRace (string memory _racename, string memory _country) isOwner(owner) public returns(uint) {
        totalRaces[raceCount] =  RaceRegistration({
        racename:_racename,
        country:_country,
        active: true
        });
        raceCount = raceCount +1;
        emit NewEvent (_racename);
        return raceCount-1;
    }

    // If the event is inactive
    function raceStatus(uint raceNumber) public view returns (bool)
    {
        bool activ = totalRaces[raceNumber].active; 
        return(activ);
    }

    // -------------ATHLETES----------------------
    function addAthlete(string memory _name, uint _age, string memory _gender, uint _payment, uint _raceCount) public payable {

        require (msg.value >= 8,"Not enought money");
         
        totalAthletes[msg.sender] = AthleteRegistration({
        name: _name, 
        age: _age,
        gender: _gender,
        athlCount: athlCount+1
        });

        athlCount = athlCount +1;
        emit NewAthlete (athlCount);
    }
}
