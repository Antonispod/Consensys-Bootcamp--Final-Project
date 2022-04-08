// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract RunToken is ERC721, Pausable, Ownable {

    //     //Owner 
    // address public owner;

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
    // modifier isOwner (address _owner) {
    //     require(msg.sender == _owner);
    //     _;
    // }
 //----------------------------------ERC721-----------------------------------   
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

 //----------------------------------Functions-----------------------------------   

    constructor() ERC721("Run Token", "RUN") {}

        //Create a function for the events to decided the price for the races !!!!!!!!!!!!!!!
    function initializeRace (string memory _racename, string memory _country) onlyOwner() public whenNotPaused() returns(uint) {
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
    function raceStatus(uint raceNumber) public view whenNotPaused() returns (bool)
    {
        bool activ = totalRaces[raceNumber].active; 
        return(activ);
    }

    // -------------ATHLETES----------------------
    function addAthlete(string memory _name, uint _age, string memory _gender) public payable {

        require (msg.value >= 8,"Not enought money");
         
        totalAthletes[msg.sender] = AthleteRegistration({
        name: _name, 
        age: _age,
        gender: _gender,
        athlCount: athlCount+1
        });

        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);

        // To add refgistered races mapping/ array

        athlCount = athlCount +1;
        emit NewAthlete (athlCount);
    }

 //----------------------------------ERC721-Functions-----------------------------------   

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/QmU3GcoWH4zShrX4m1oUJTF5gwvmpHFnFwekmbjVaeQ";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }
}
