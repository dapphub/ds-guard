/*
   Copyright 2016-2017 Nexus Development

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

import 'ds-auth/auth.sol';

contract DSWhitelist is DSAuth
                      , DSAuthority
{
    mapping(address=>bool)                  _isRoot; // Can call any entrypoint
    mapping(address=>bool)                  _isPublicCode; // Public addrs
    mapping(address=>
            mapping(bytes4=>bool))          _isPublicCapability; // Public addr+sig
    mapping(address=>
            mapping(address=>
                    mapping(bytes4=>bool))) _canCall; // fine-grained control

    function canCall( address caller
                    , address code
                    , bytes4 sig )
             constant
             returns (bool)
    {
        return _isRoot[caller]
            || _isPublicCode[code]
            || _isPublicCapability[code][sig]
            || _canCall[caller][code][sig];
    }

    function setIsRoot( address caller, bool what )
        auth
    {
        _isRoot[caller] = what;
    }
    
    function setIsPublicCode( address code, bool what )
        auth
    {
        _isPublicCode[code] = what;
    }

    function setIsPublicCapability( address code, bytes4 sig, bool what )
        auth
    {
        _isPublicCapability[code][sig] = what;
    }

    function setCanCall( address caller_address
                       , address code_address
                       , bytes4  sig
                       , bool    can )
        auth
    {
        _canCall[caller_address][code_address][sig] = can;
    }
}
