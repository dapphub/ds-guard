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
    event LogOkay(bytes32 src, bytes32 dst, bytes32 sig, bool yes);
    event LogSignature(string signature, bytes4 sig);
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

    // For use with explicit `src', `dst' and `sig':
    function okay(address src, address dst, string sig) {
        okay(src, dst, sig, true);
    }
    function okay(address src, address dst, string sig, bool yes) {
        okay(bytes32(src), bytes32(dst), sig, yes);
    }

    // Convenience overloads for use with `ANY':
    function okay(address src, bytes32 dst, bytes32 sig) {
        okay(bytes32(src), bytes32(dst), sig, true);
    }
    function okay(address src, address dst, bytes32 sig) {
        okay(bytes32(src), bytes32(dst), sig, true);
    }
    function okay(address src, bytes32 dst, string sig) {
        okay(bytes32(src), bytes32(dst), sig, true);
    }

    // Called by every `okay' variant that takes a full signature:
    function okay(bytes32 src, bytes32 dst, string sig, bool yes) {
        LogSignature(sig, bytes4(sha3(sig)));
        okay(src, dst, bytes4(sha3(sig)), yes);
    }

    // Actual implementation called by all the rest:
    function okay(bytes32 src, bytes32 dst, bytes32 sig, bool yes)
        authorized("okay")
    {
        acl[src][dst][sig] = yes;
        LogOkay(src, dst, sig, yes);
    }
}
