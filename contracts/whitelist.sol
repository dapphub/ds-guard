import 'ds-auth/auth.sol';

contract Whitelist is DSAuthority
{
    bool _enabled; // global disable
    mapping(address=>bool) _whitelist;
    // Implements `canCall` so it can be used directly as `auth` authority
    function canCall(address caller, address code, bytes4 sig)
        constant
    {
        return isWhitelisted(caller);
    }
    function isWhitelisted(address who)
        constant
    {
        return _enabled && _whitelist[who];
    }
    function setWhitelisted(address who, bool what)
        auth
    {
        _whitelisted[who] = what;
    }
    function setEnabledStatus(bool what)
        auth
    {
        _enabled = what;
    }
}
