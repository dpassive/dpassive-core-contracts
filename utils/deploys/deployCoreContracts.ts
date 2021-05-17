import { Signer } from "ethers";
import { BigNumberish } from "@ethersproject/bignumber";

import { Address, Bytes } from "./../types";

export default class DeployCoreContracts {
  private _deployerSigner: Signer;

  constructor(deployerSigner: Signer) {
    this._deployerSigner = deployerSigner;
  }
}
