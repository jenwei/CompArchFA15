Assembly tests submitted by each team will go here

After submitting your test program, you may use any of these programs written by your peers to test your processor.

In addition to your actual test assembly code, write a short README with:
 - Expected results of the test
 - Any memory layout requirements (e.g. `.data` section)
 - Any instructions used outside the basic required subset (ok to use, but try to submit at least one test program everyone can run)

Submit the test program and README by submitting a pull request to the [main course repository](https://github.com/benthill/CompArchFA15). Code should be in `Lab/Lab3/asmtest/<your-team-name>/` (you may use subfolders if you submit multiple tests).

-------------------------------------------------------------------------------------------------------------------------------------------
<h2>is_prime README</h2>
Our Assembly test, `is_prime`, takes an input and searches for any possible multiples and factors.

Input on `$a0` as any number. 
Output on `$v0` as a flag to show prime or not prime.

If no factors are found, then the number is prime and `$v0` is set to `0xb`. Otherwise, if the number is not prime, then `$v0` is set to `0xa`.

Warning: With larger numbers, the code will begin to take extreme amounts of time to finish. For your own sake, keep the numbers under 7 digits. 
