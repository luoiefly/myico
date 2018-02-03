
const tokenICO = artifacts.require('TokenICO');
let HST;

contract('TokenICO', (accounts) => {
  beforeEach(async () => {
    HST = await tokenICO.new(20000, 'MyICO', 18, '%', 10000, 1, { from: accounts[0] });
  });

  it('creation: should create an initial balance of 20000 for the creator', async () => {
    const balance = await HST.balanceOf.call(accounts[0]);
    assert.strictEqual(balance.toNumber(), 20000 * 10**18);
  });

  it('creation: test correct setting of vanity information', async () => {
    const name = await HST.name.call();
    assert.strictEqual(name, 'MyICO');

    const decimals = await HST.decimals.call();
    assert.strictEqual(decimals.toNumber(), 18);

    const symbol = await HST.symbol.call();
    assert.strictEqual(symbol, '%');

    const sellPrice = await HST.sellPrice.call();
    assert.strictEqual(sellPrice.toNumber(), 1);
  });


  // TRANSERS
  // normal buy 10
  it('transfers: use ether buy token.', async () => {
    const balanceBefore = await HST.balanceOf.call(accounts[0]);
    assert.strictEqual(balanceBefore.toNumber(), 20000 * 10**18);


    await HST.sendTransaction({
      value: 10 * 10 ** 18,
      from: accounts[1],
      to: HST.address
    });

    const balanceOf2 = await HST.balanceOf.call(accounts[1]);
    assert.strictEqual(balanceOf2.toNumber(), 10 * 10 ** 18);

    const balanceAfter = await HST.balanceOf.call(accounts[0]);
    assert.strictEqual(balanceAfter.toNumber()/10**18, 19990);
   
  });

});
