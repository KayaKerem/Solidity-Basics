const { expect } = require('chai');
const { ethers } = require('hardhat');
const provider = ethers.provider;


function ethToNum(val) {
    return Number(ethers.utils.formatEther(val));
}


describe("Lock Contract", function () {
   
    let owner, user1, user2;
    let Token, token;
    let balances;

    before(async function () { //bir defa çalışır
        [owner,user1,user2] = await ethers.getSigners();

        Token = await ethers.getContractFactory("BEEToken");
        token = await Token.connect(owner).deploy();

        Lock = await ethers.getContractFactory("Lock");
        lock = await Lock.connect(owner).deploy(token.address);

        token.connect(owner).transfer(user1.address, ethers.utils.parseUnits("100", 18));
        token.connect(owner).transfer(user2.address, ethers.utils.parseUnits("50"));

        token.connect(user1).approve(lock.address, ethers.constants.MaxUint256);
        token.connect(user2).approve(lock.address, ethers.constants.MaxUint256);
        
    });

    beforeEach(async function () {//her it caseinden bir defa önce çalışır
        
        balances = [
            ethToNum(await token.balanceOf(owner.address)),
            ethToNum(await token.balanceOf(user1.address)),
            ethToNum(await token.balanceOf(user2.address)),
            ethToNum(await token.balanceOf(lock.address)),

        ]

    });
    
    it("Deploys the contracts", async function () {
        
        expect(token.address).to.not.be.undefined;
        expect(lock.address).to.not.be.undefined;        

    });

    it("Sends tokens", async function () {
        
        expect(balances[1]).to.be.equal(100);
        expect(balances[2]).to.be.equal(50);

        expect(balances[0]).to.be.greaterThan(balances[1]);



    });

    it("Approves", async function () {
        
        let allowances = [
            await token.allowance(user1.address, lock.address),
            await token.allowance(user2.address, lock.address),
        
        ]
        expect(allowances[0]).to.be.equal(ethers.constants.MaxUint256);
        expect(allowances[0]).to.be.equal(allowances[1]);

    });

    it("Reverts exceeding transfer", async function () {
       
        await expect(token.connect(user1).transfer(user2.address, ethers.utils.parseUnits("300", 18))).to.be.reverted;
        
    });
    describe("Contract Functions", function () {
        
        it("user1 locks 10 tokens", async function () {
            
        });

        it("Locker count and locked amount increase", async function () {
            
        });

        it("user2 cannot withdraw token", async function () {
            
        });

        it("user1 withdraws token", async function () {
            
        });


    });

});


