var RegistrationContract = artifacts.require("./Registrationv4.sol");

module.exports = function(deployer) {
  deployer.deploy(RegistrationContract);
};
