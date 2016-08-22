import 'ds-auth/auth.sol';

contract Whitelist is DSAuthority
                    , DSAuthorized
{
    bool _enabled; // global disable
    mapping(address=>bool) _whitelist;
    // Implements `canCall` so it can be used directly as `auth` authority

    function isEnabled()
        constant
        returns (bool)
    {
        return _enabled;
    }
    function isWhitelisted(address who)
        constant
        returns (bool)
    {
        return isEnabled() && _whitelist[who];
    }
    function canCall(address caller, address code, bytes4 sig)
        constant
        returns (bool)
    {
        return isWhitelisted(caller);
    }

    function setWhitelisted(address who, bool what)
        auth
    {
        _whitelist[who] = what;
    }
    function setEnabled(bool what)
        auth
    {
        _enabled = what;
    }
}
