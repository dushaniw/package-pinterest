// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;

documentation{
    Represents the Pinterest Client Connector.

    F{{client}} HTTP Client used in Pinterest connector
}
public type PinterestConnector object {
    public {
        http:Client client;
    }

    public function getUserInformation(string userId = "me") returns User|PinterestError;
};

public function PinterestConnector::getUserInformation(string userId = "me") returns User|PinterestError{
    endpoint http:Client httpClient = self.client;
    string getUserPath = USERS_RESOURCE + userId + FORWARD_SLASH_SYMBOL;
    var httpResponse = httpClient->get(getUserPath);
    match handleResponse(httpResponse){
        json jsonResponse => {
            //Transform the json user response from Pinterest API
            return convertJsonUserToUserType(jsonResponse);
        }
        PinterestError pinterestError => return pinterestError;
    }
}
