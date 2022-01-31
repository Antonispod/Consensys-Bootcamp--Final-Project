Final project submission for the ConsenSys Academy Blockchain Developer Bootcamp 2021

# installation

- Requires Node 12 & local Ganache on port 8546
- Install dependencies by doing `yarn install`
- Start ganache
- compile and migrate contracts `yarn build:contracts`
- compile client `yarn build:client`
- Or start development environment `yarn start` on port :80

# Description

Project idea:
TLDR: Validation of athletes in races.

LONGER VERSION: More and more people start running, either to improve their health or to reach their personal goal. 
There are plenty of short and long distances races, inside the cities or in the mountains. Athletes, usually have to pay for their participation, receive racing staff (shirts, medals, sport drinks etc), 
take their race certificate and medal as well as have other services (photos, videos, running time etc).

CONCEPT: The interface has 2 modes:

- one for registering all the necessary information
- one for validating them

BENEFITS:
- Trust: There is a huge database in every race with sensitively information. Blockchain will help for the solvency of the system.
- Automation: The athlete will be able to verify the services that paid for and wants, with NFTs.
- Certificate: The athlete will be able to receive an NFT for the participation. 

REGISTERING: As soon as the athletes have entered all the necessary information and pay, they will receive their NFT.

CONFIRMING: In the race day, through athlete's NFT, the organizer will be able to see if all the needs have been covered or if something is still pending.

FUTURE ADDS: Right now, due to the lack of knowledge, I did really basic things. This project can become bigger and bigger. More events and different races with different values can be added. Furthermore, more NFTs (position, special events) can be given.


