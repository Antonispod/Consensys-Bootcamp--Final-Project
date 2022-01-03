console.log("Hello mate")

// 1 Detect if Metamask is installed

window.addEventListener('load',
 function(){
    if (typeof window.ethereum !== 'undefined'){
        console.log('Metamask detected')
        let mmDetected = document.getElementById
        ('mm-detected')
        mmDetected.innerHTML = "Metamask has been Detected!"
    }

    else{
        console.log('Metamask not Available')
        alert("You need to install Metamask or another wallet")
    }

})

const mmEnable = document.getElementById
('mm-enable');

mmEnable.onclick = async () => {
    await ethereum.request({ method: 
    'eth_requestAccounts'})

    const mmCurrentAccount = document.
    getElementById('mm-current-account');

    mmDCurrentAccount.innerHTML = "Here is your account: " + ethereum.selectedAddress


}