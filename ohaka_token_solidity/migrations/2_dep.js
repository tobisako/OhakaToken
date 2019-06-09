const fs = require('fs');
var OhakaToken = artifacts.require("OhakaToken");
 
module.exports = function(deployer, network, accounts) {
    var obj;
    deployer.deploy(OhakaToken).then((instance) => {
        obj = instance;
        //return obj.testGetName(0);
        return obj.mintOhaka("0x7b7E379a8dBd1b282c5ea51D19D805A6eD7e565b", "Decrypt Hanako", 98);
    }).then(() => {
        return obj.setFriend(0, "0xa223c26984436a1DC1eefcb44eD7779E3D8ABEb5");
    }).then(() => {
        return obj.setIPFS(0, 0, "QmYChyDDE7M8VZXhpViTFmfKexhZwrh6sa7Q3TVPAtfLF9", false);
    }).then(() => {
        return obj.setIPFS(0, 1, "QmVRzzpnfFHGh8T21dz9AoDvwC1FKpu98RQQM3zgdjrFwH", true);
    }).then(() => {
        return obj.setIPFS(0, 2, "QmZeScrwBxpFBHLrHYbbW2KMnsSeGCtaGmjtZmQnuwuLqK", false);
    }).then(() => {

/*        
        return obj.mintOhaka("0x9CBe4721d37bd67623421dC286Bda77CB12f3581", "Tokyo Saburou", 103);
    }).then(() => {
        return obj.setIPFS(1, 0, "QmTQg93qK4GsoHrcq1GmejwJcJKU7ybohQM8z4fM3sSaj9", false);
    }).then(() => {
        return obj.setIPFS(1, 1, "QmSY5R4ZPUFCyt5Kf9vANxkRQ3DYMye7VjqhiywUTja49Q", false);
    }).then(() => {
        return obj.setIPFS(1, 2, "QmX4GEARy1gNHmy6STbCzzv8JZxTGuM6NNRcXJKtwawdvj", false);
    }).then(() => {
        return obj.mintOhaka("0x732becd0eacbf243b99e00c13ed9c0947e72b12d", "Tokyo Tomozou", 77);
    }).then(() => {
*/

        console.log("done.");
        const outputfilename1 = "./deployed_info.js";
        var msg = "var deployed_network = '" + network + "';\r\n\r\n"; 
        msg += "var deploy_account = '" + accounts[0] + "';\r\n\r\n";
        msg += "var contract_addr = '" + obj.address + "';\r\n"; 
        msg += "var abi = " + JSON.stringify(obj.abi) + ";\r\n\r\n";
        fs.writeFileSync(outputfilename1, msg);
    })
};
