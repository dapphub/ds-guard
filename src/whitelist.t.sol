/*
   Copyright 2016 Nexus Development, LLC

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

pragma solidity ^0.4.4;

import 'dapple/test.sol';
import 'factory.sol';

contract WhitelistTest is Test {
    WhitelistFactory _factory;
    DSWhitelist _w;
    function setUp() {
        _factory = new WhitelistFactory();
        _w = _factory.createDSWhitelist();
    }
    function testBasics() {
        _factory.isDSWhitelist(_w);
        assertTrue(_w.isEnabled());

        _w.setEnabled(false);
        assertFalse(_w.isEnabled());
        _w.setEnabled(true);
        assertTrue(_w.isEnabled());
        
        _w.setWhitelisted(this, true); 
        assertTrue(_w.isWhitelisted(this));
        assertTrue(_w.canCall(this, 0, 0));
        _w.setEnabled(false);
        assertFalse(_w.isWhitelisted(this));
    }
}
