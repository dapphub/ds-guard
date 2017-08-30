/// guard.t.sol -- tests for guard.sol

// Copyright (C) 2017  Daniel Brockman <daniel@brockman.se>

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.13;

import "ds-test/test.sol";

import "./guard.sol";

contract DSGuardTest is DSTest {
    DSGuardFactory  factory;
    DSGuard         guard;
    
    function setUp() {
        factory = new DSGuardFactory();
        guard = factory.newGuard();
    }
    
    function testBasics() {
        assertTrue(factory.isGuard(guard));
        guard.permit(bytes32(address(this)), guard.ANY(), guard.ANY());
        assertTrue(guard.canCall(this, address(0x1234), 0x12345678));
    }
}
