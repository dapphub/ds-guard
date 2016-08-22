import 'dapple/test.sol';
import 'whitelist.sol';

contract WhitelistFactory {
    mapping(address=>bool) is_whitelist;
    function createWhitelist() returns (Whitelist) {
        var whitelist = new Whitelist();
        is_whitelist[address(whitelist)] = true;
        return whitelist;
    }
    // Not to be confused with `isWhitelisted` on instances
    function isWhitelist(address code) {
        return is_whitelist[code];
    }
}
