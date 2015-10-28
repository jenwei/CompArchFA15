// How the `decoder1to32` module works//

A decoder has `n` inputs and `2^n` outputs, and it toggles 1 out of the 32 outputs to 1 (high). This is possible as it has `5` input addresses. In binary, the addresses can represent any number between 0 and 31 (inclusively) if `enable` is set to 1 (high). Otherwise, the 32-bit output will be made up of zeros (lows).

`assign out = enable<<address` results in a decoder by shifting the `enable` left (as signified by the `<<` sign) by `address` bits. This results in a 32-bit output with 31 zeros and a 1-bit at a corresponding location designated by the address.

The way that works is that `enable` is shifted left by `address` bits and followed by `address` zeros. Since `out` is declared as a 32-bit bus/array, `enable<<address` is padded with zeros on the left to make `out` have 32 bits as opposed to `address+1` bits.
