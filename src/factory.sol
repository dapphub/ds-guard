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

import 'dapple/test.sol';
import 'ds-auth/auth.sol';
import 'whitelist.sol';

contract WhitelistFactory {
    mapping(address=>bool) is_whitelist;
    function createDSWhitelist() returns (DSWhitelist) {
        var whitelist = new DSWhitelist();
        is_whitelist[address(whitelist)] = true;
        whitelist.setOwner(msg.sender);
        return whitelist;
    }
    // Not to be confused with `isWhitelisted` on instances
    function isDSWhitelist(address code)
        constant
        returns (bool)
    {
        return is_whitelist[code];
    }
}
