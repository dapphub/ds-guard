/// factory.sol -- factory for DSGuard

// Copyright (C) 2015, 2016, 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.8;

import "ds-auth/auth.sol";

import "./guard.sol";

contract DSGuardFactory {
    mapping (address => bool)  public  created;
    
    function newGuard() returns (DSGuard guard) {
        created[guard = new DSGuard()] = true;
        guard.setOwner(msg.sender);
    }
}
