Problems we are trying to solve:
1. supply chain attacks
2. libraries must specify dependency version so that if there are breaking changes, e.g std goes to v2 from v1, the libraries must not compile.
3. allow people to run and compile simplicity in code.


Requirements:
1. Must be able to compile Simf files in code. Wallets will want to replace parameters in simplicity and the
easiest will be if can specify the parameters and compile code. An alternative to this is to remap parameters 
in the simplicity base64, but this too will require the ability to decode simplicity and if a param has been repeated or has the same value, it will not be reliable to change the const's in place.
2. Mildly related, but the user should also be able to specify the JetEnviroment through libcompilation.
3. It is vitally important to link to specific versions of libraries, because a change in code will change the generated simplicity. This could render utxos unspendable if you cannot regenerate the simplicity program on the utxo.

Systems looked at:
1. rust/cargo
2. javascript/npm.

Need to look at:
1. circom
2. mlua because this is source based linking, but also because it can be compiled in rust.

Possible future additions:
1. Running core (jets) simplicity in a runtime/plugin kind of enviroment as an alternative to lua.

