<h2>DSGuard
  <small class="text-muted">
    <a href="https://github.com/dapphub/ds-guard"><span class="fa fa-github"></span></a>
  </small>
</h2>

_Permissions whitelist with address-level granularity_

Manages an Access Control List which maps source and destination addresses
to function signatures. Intended to be used as an `authority` for 
[ds-auth](https://dapp.tools/dappsys/ds-auth.html) where it acts as a lookup 
table for the `canCall` function to provide boolean answers as to whether a 
particular address is authorized to call agiven function at another address.
  
The `acl` is a mapping of `[src][dst][sig] => boolean` where an address `src` 
can be either permitted or forbidden access to a function `sig` at address 
`dst` according to the boolean value. When used as an `authority` by DSAuth the
`src` is considered to be the `msg.sender`, the `dst` is the including contract
and `sig` is the function which invoked the `auth` modifier.

```solidity
// Permit a specific address to call a specific function on a specific contract
src = '0011111111111111111111111111111111111111'
dst = '0022222222222222222222222222222222222222'
guard.permit(src, dst, bytes4(sha3('mint(address,uint256)')));
``` 
 
The `ANY` constant can be stored in place of `src`, `dst` or `sig` where it will 
act as a wildcard and be considered to match any item in that position.

```solidity
// Permit ANY address to call a specific function on a specific contract
guard.permit(ANY, dst, bytes4(sha3('mint(address,uint256)')));

// Permit ANY address to call a ANY function on a specific contract
guard.permit(ANY, dst, ANY);
```

Warning:
Statements in the access control list are evaluated with the OR operator, meaning
that the most open permission will take precedence. If all of the the above 3
examples were in place for example, it is the last that would take precedence,
regardless of the more restrictive permissions defined prior. Developers are
encouraged to think carefully before using **ANY**.

### Actions

#### `permit`
permit an address to call a function at a contract (requires auth)

#### `forbid`
forbid an address from calling a function at a contract (requires auth)
