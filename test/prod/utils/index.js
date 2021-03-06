const { detectNetworkName } = require('./detectNetwork');
const { connectContract, connectContracts } = require('./connectContract');
const {
	ensureAccountHasEther,
	ensureAccountHasDPS,
	ensureAccountHasdUSD,
	ensureAccountHasdETH,
} = require('./ensureAccountHasBalance');
const { exchangeSynths } = require('./exchangeSynths');
const { readSetting, writeSetting } = require('./systemSettings');
const { skipWaitingPeriod, skipStakeTime } = require('./skipWaiting');
const { simulateExchangeRates, avoidStaleRates } = require('./exchangeRates');
const { takeDebtSnapshot } = require('./debtSnapshot');
const { implementsVirtualSynths } = require('./virtualSynths');
const { implementsMultiCollateral } = require('./multicollateral');
const { resumeSystem } = require('./systemStatus');

module.exports = {
	detectNetworkName,
	connectContract,
	connectContracts,
	ensureAccountHasEther,
	ensureAccountHasdUSD,
	ensureAccountHasDPS,
	ensureAccountHasdETH,
	exchangeSynths,
	readSetting,
	writeSetting,
	skipWaitingPeriod,
	skipStakeTime,
	simulateExchangeRates,
	takeDebtSnapshot,
	implementsVirtualSynths,
	implementsMultiCollateral,
	avoidStaleRates,
	resumeSystem,
};
