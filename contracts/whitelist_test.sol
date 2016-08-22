import 'dapple/test.sol';
import 'factory.sol';

contract WhitelistTest is Test {
    WhitelistFactory _factory;
    Whitelist _w;
    function setUp() {
        _factory = new WhitelistFactory();
        _w = _factory.createWhitelist();
    }
    function testBasics() {
        _factory.isWhitelist(_w);
        assertFalse(_w.isEnabled());
        _w.setEnabled(true);
/*
        assertTrue(_w.isEnabled());
        _w.setWhitelisted(this, true); 
        assertTrue(_w.isWhitelisted(this));
        assertTrue(_w.canCall(this, 0, 0));
        _w.setEnabled(false);
        assertFalse(_w.isWhitelisted(this));
*/
    }
}
