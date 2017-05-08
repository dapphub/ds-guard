/// guard.sol -- whitelist-based implementation of DSAuthority

// Copyright (C) 2015, 2016, 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.8;

import "ds-test/test.sol";

import "./factory.sol";

contract DSGuardTest is DSTest {
    DSGuardFactory  factory;
    DSGuard         guard;
    
    function setUp() {
        factory = new DSGuardFactory();
        guard = factory.newGuard();
    }
    
    function testBasics() {
        factory.created(guard);
        guard.okay(bytes32(address(this)), guard.ANY(), guard.ANY(), true);
        assert(guard.allowed(this, address(0x1234), 0x12345678));
    }
}
