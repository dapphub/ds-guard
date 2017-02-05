`ds-whitelist`
===

`DSWhitelist` is a type of `DSAuthority`. Its `canCall` function is:

    return _isRoot[caller]
        || _isPublicCode[code]
        || _isPublicCapability[code][sig]
        || _canCall[caller_address][code_address][sig];
