const ethers = require('ethers');
const { assert } = require('../../contracts/common');
const { toBytes32 } = require('../../../index');
const { ensureBalance } = require('../utils/balances');

function itCanPerformExchanges({ ctx }) {
	const sUSDAmount = ethers.utils.parseEther('100');

	let owner;

	let DPassive, Exchanger, SynthsETH;

	before('target contracts and users', () => {
		({ DPassive, Exchanger, SynthsETH } = ctx.contracts);

		owner = ctx.owner;
	});

	before('ensure the owner has sUSD', async () => {
		await ensureBalance({ ctx, symbol: 'sUSD', user: owner, balance: sUSDAmount });
	});

	describe('when the owner exchanges from sUSD to sETH', () => {
		let balancesETH;

		before('record balances', async () => {
			balancesETH = await SynthsETH.balanceOf(owner.address);
		});

		before('perform the exchange', async () => {
			DPassive = DPassive.connect(owner);

			const tx = await DPassive.exchange(toBytes32('sUSD'), sUSDAmount, toBytes32('sETH'));
			await tx.wait();
		});

		it('receives the expected amount of sETH', async () => {
			const [expectedAmount, ,] = await Exchanger.getAmountsForExchange(
				sUSDAmount,
				toBytes32('sUSD'),
				toBytes32('sETH')
			);

			assert.bnEqual(await SynthsETH.balanceOf(owner.address), balancesETH.add(expectedAmount));
		});
	});
}

module.exports = {
	itCanPerformExchanges,
};
