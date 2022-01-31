function openPage(e) {
  var pageName = e.target.getAttribute("data-page");
  var i;
  var x = document.getElementsByClassName("city");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  document.getElementById(pageName).style.display = "block";
}

const navigationElements = document.querySelectorAll(
  '[data-type="navigation-link"]'
);
navigationElements.forEach((nav) => {
  nav.addEventListener("click", openPage);
});

const userWalletConnect = document.getElementById("wallet-connect");
// 1. detect Metamask is/is not installed
window.addEventListener("load", async function () {
  const contractResponse = await fetch("contracts/Registration.json");
  const contract = await contractResponse.json();
  start(contract);
  if (typeof window.ethereum !== "undefined") {
    console.log(" MetaMask detected!");
    // document refers to the html file
    userWalletConnect.style.display = "initial";
  } else {
    console.group("MetaMask Not Available!");
    alert("You need to install MetaMask or another wallet!");
  }
});

function start(contract) {
  console.log(contract);
  //------ Contract-------
  var web3 = new Web3(window.ethereum);
  const registrationContract = new web3.eth.Contract(
    contract.abi,
    contract.networks[ethereum.networkVersion].address
  );

  // ------ Event---------
  const eventForm = document.getElementById("event-form");
  registrationContract.events
    .NewEvent({fromBlock: 0})
    .on("message", (event) => console.log(event))
    .on("close", (changed) => console.info(changed))
    .on("error", (err) => console.error(err))
    .on("connect", (str) => console.info(str));
  eventForm.addEventListener("submit", async function (e) {
    //    const resultName = await registrationContract.methods.initializeRace().call({ from: ethereum.selectedAddress });
    debugger;
    e.preventDefault();
    const eventData = new FormData(this);
    const response = await registrationContract.methods
      .initializeRace(eventData.get("_racename"), eventData.get("_country"))
      .send({ from: ethereum.selectedAddress });
    // .call({ from: ethereum.selectedAddress });
    console.log(response);
  });

  // ------ Athletes---------
  const athleteForm = document.getElementById("athlete-form");
  athleteForm.addEventListener("submit", async function (e) {
    //    const resultName = await registrationContract.methods.initializeRace().call({ from: ethereum.selectedAddress });
    debugger;
    e.preventDefault();
    const eventData = new FormData(this);
    const response = await registrationContract.methods
      .addAthlete(
        eventData.get("_name"),
        eventData.get("_age"),
        eventData.get("_gender")
      )
      .send({ from: ethereum.selectedAddress, value: 9 });

    console.log(response);
  });
}

// 2. allow the user to get access to Metamask3.
userWalletConnect.onclick = async () => {
  console.log("about to scan it");
  await ethereum.request({ method: "eth_requestAccounts" });

  const mmCurrentAccount = document.getElementById("wallet-account");
  userWalletConnect.style.display = "none";
  mmCurrentAccount.style.display = "initial";
  mmCurrentAccount.innerHTML = ethereum.selectedAddress;
};
