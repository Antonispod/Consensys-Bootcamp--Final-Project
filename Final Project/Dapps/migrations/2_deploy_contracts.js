var RegistrationContract = artifacts.require("./Registration_v5.sol");

module.exports = function(deployer) {
  deployer.deploy(RegistrationContract);
};
