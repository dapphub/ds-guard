/*
   Copyright 2016 Nexus Development

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

pragma solidity ^0.4.2;

import 'ds-auth/auth.sol';

contract Whitelist is DSAuthority
                    , DSAuthorized
{
    bool _enabled; // global disable
    mapping(address=>bool) _whitelist;
    // Implements `canCall` so it can be used directly as `auth` authority

    function isEnabled()
        constant
        returns (bool)
    {
        return _enabled;
    }
    function isWhitelisted(address who)
        constant
        returns (bool)
    {
        return isEnabled() && _whitelist[who];
    }
    function canCall(address caller, address code, bytes4 sig)
        constant
        returns (bool)
    {
        return isWhitelisted(caller);
    }

    function setWhitelisted(address who, bool what)
        auth
    {
        _whitelist[who] = what;
    }
    function setEnabled(bool what)
        auth
    {
        _enabled = what;
    }
}
