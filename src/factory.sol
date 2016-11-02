import 'dapple/test.sol';
import 'ds-auth/util.sol';
import 'whitelist.sol';

contract WhitelistFactory is DSAuthUtils {
    mapping(address=>bool) is_whitelist;
    function createWhitelist() returns (Whitelist) {
        var whitelist = new Whitelist();
        is_whitelist[address(whitelist)] = true;
        setOwner(whitelist, msg.sender);
        return whitelist;
    }
    // Not to be confused with `isWhitelisted` on instances
    function isWhitelist(address code)
        constant
        returns (bool)
    {
        return is_whitelist[code];
    }
}
