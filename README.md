`ds-whitelist`
===

This is an `address=>bool` registry. It is also a `DSAuthority` (has `canCall`) which only cares about the caller.

It also has a global enable/disable ("emergency freeze") feature, which the BasicAuthority lacks.
