// guard.t.sol -- tests for guard.sol

// Copyright (C) 2017  DappHub, LLC

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity >=0.4.23;

import "ds-test/test.sol";

import "./guard.sol";

contract DSGuardTest is DSTest {
    DSGuardFactory  factory;
    DSGuard         guard;

    function setUp() public {
        factory = new DSGuardFactory();
        guard = factory.newGuard();
    }

    function testFactorySetup() public {
        assertTrue(factory.isGuard(address(guard)));
    }
    function testPermitAny() public {
        guard.permit(bytes32(bytes20(address(this))), guard.ANY(), guard.ANY());
        assertTrue(guard.canCall(address(this), address(0x1234), 0x12345678));
    }
    function testForbidAny() public {
        guard.permit(bytes32(bytes20(address(this))), guard.ANY(), guard.ANY());
        guard.forbid(bytes32(bytes20(address(this))), guard.ANY(), guard.ANY());
        assertTrue(!guard.canCall(address(this), address(0x1234), 0x12345678));
    }
    function testPermitAddress() public {
        guard.permit(address(this), address(0x1234), guard.ANY());
        assertTrue(guard.canCall(address(this), address(0x1234), 0x12345678));
        assertTrue(!guard.canCall(address(this), address(0x5678), 0x12345678));
    }
    function testForbidAddress() public {
        guard.permit(address(this), address(0x1234), guard.ANY());
        assertTrue(guard.canCall(address(this), address(0x1234), 0x12345678));
        guard.forbid(address(this), address(0x1234), guard.ANY());
        assertTrue(!guard.canCall(address(this), address(0x1234), 0x12345678));
    }
}
