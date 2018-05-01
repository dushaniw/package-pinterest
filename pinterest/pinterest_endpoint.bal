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

import ballerina/http;

documentation{
    Represents Pinterest endpoint.

    E{{}}
    F{{pinterestConfig}} Pinterest endpoint configuration
    F{{pinterestConnector}} Pinterest connector
}
public type Client object {
    public {
        PinterestConfiguration pinterestConfig;
        PinterestConnector pinterestConnector;
    }

    documentation{
        Gets called when the pinterest endpoint is beign initialized.

        P{{pinterestConfig}} Pinterest connector configuration
    }
    public function init(PinterestConfiguration pinterestConfig) {
        pinterestConfig.clientConfig.url = BASE_URL;
        match pinterestConfig.clientConfig.auth {
            () => {}
            http:AuthConfig authConfig => authConfig.scheme = OAUTH;
        }
        self.pinterestConnector = new;
        self.pinterestConnector.client.init(pinterestConfig.clientConfig);
    }

    documentation{
        Returns the connector that client code uses.
    }
    public function getCallerActions() returns PinterestConnector {
        return self.pinterestConnector;
    }
};

documentation{
    Represents the Pinterest client endpoint configuration.

    F{{clientConfig}} The HTTP Client endpoint configuration
}
public type PinterestConfiguration {
    http:ClientEndpointConfig clientConfig;
};