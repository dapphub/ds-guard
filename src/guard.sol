/// guard.sol -- whitelist-based implementation of DSAuthority

// Copyright (C) 2015, 2016, 2017  Nexus Development, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.8;

import "ds-auth/auth.sol";

contract DSGuardEvents {
    event LogAllow(bytes32 src, bytes32 dst, bytes32 sig, bool yes);
    event LogSig(string signature, bytes4 sig);
}

contract DSGuard is DSAuth, DSAuthority, DSGuardEvents {
    bytes32 constant public ANY = bytes32(uint(-1));

    mapping (bytes32 => mapping (bytes32 => mapping (bytes32 => bool))) acl;

    function canCall(
        address src_, address dst_, bytes4 sig
    ) constant returns (bool) {
        var src = bytes32(src_);
        var dst = bytes32(dst_);

        return acl[src][dst][sig]
            || acl[src][dst][ANY]
            || acl[src][ANY][sig]
            || acl[src][ANY][ANY]
            || acl[ANY][dst][sig]
            || acl[ANY][dst][ANY]
            || acl[ANY][ANY][sig]
            || acl[ANY][ANY][ANY];
    }

    function allow(address src, address dst, string sig) {
        allow(src, dst, sig, true);
    }

    function allow(address src, address dst, string sig, bool yes) {
        allow(bytes32(src), bytes32(dst), sig, yes);
    }

    function allow(bytes32 src, bytes32 dst, string sig, bool yes) {
        LogSig(sig, bytes4(sha3(sig)));
        allow(src, dst, bytes4(sha3(sig)), yes);
    }

    function allow(bytes32 src, bytes32 dst, bytes32 sig, bool yes)
        auth
    {
        acl[src][dst][sig] = yes;
        LogAllow(src, dst, sig, yes);
    }
}
