const CBQuest = artifacts.require('OhakaToken');

contract('OhakaToken', function ([creator, ...accounts]) {

    it("init ohaka check", async () => {
        const instance = await CBQuest.deployed();

        let res = await instance.checkPlayerRegistered();
        assert.equal(res, true, "Player Regist Err.");

        let idx = await instance.getPlayerIndex();
        let as = await instance.players(idx);
        assert.equal(as[1], "tarou", `name isn't the same. (${as[1]})`);
    });
    
});
