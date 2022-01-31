var RegistrationContract = artifacts.require("./Registration.sol");

module.exports = function(deployer) {
  deployer.deploy(RegistrationContract);
};
