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

pragma solidity ^0.4.8;

import "ds-test/test.sol";

contract GuardTest is DSTest {
    GuardFactory _factory;
    DSGuard _w;
    function setUp() {
        _factory = new GuardFactory();
        _w = _factory.createDSGuard();
    }
    function testBasics() {
        _factory.isDSGuard(_w);
        assertTrue(_w.isEnabled());

        _w.setEnabled(false);
        assertFalse(_w.isEnabled());
        _w.setEnabled(true);
        assertTrue(_w.isEnabled());
        
        _w.setGuarded(this, true); 
        assertTrue(_w.isGuarded(this));
        assertTrue(_w.canCall(this, 0, 0));
        _w.setEnabled(false);
        assertFalse(_w.isGuarded(this));
    }
}
