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

documentation{Handles the http response.
    P{{response}} - Http response or HttpConnectorEror
    R{{}} - If successful returns json reponse. Else returns PinterestError.
}
function handleResponse(http:Response|error response) returns (json|PinterestError) {
    match response {
        http:Response httpResponse => {
            if (httpResponse.statusCode == http:NO_CONTENT_204){
                return true;
            }
            match httpResponse.getJsonPayload() {
                json jsonPayload => {
                    if (httpResponse.statusCode == http:OK_200) {
                        return jsonPayload;
                    }
                    else {
                        PinterestError pinterestError = { message: "Error occured; message:"
                            + jsonPayload.message.toString() + "; code:"
                            + jsonPayload.code.toString() + "; status:"
                            + jsonPayload.status.toString() + "; data:"
                            + jsonPayload.data.toString() };
                        return pinterestError;
                    }
                }
                error payloadError => {
                    PinterestError pinterestError = { message: "Error occurred when parsing to json response; message: "
                                                        + payloadError.message, cause: payloadError.cause };
                    return pinterestError;
                }
            }
        }
        error err => {
            PinterestError pinterestError = { message: "Error occurred during HTTP Client invocation; message: "
                + err.message, cause: err.cause };
            return pinterestError;
        }
    }
}

documentation{Create url encoded request body with given key and value.
    P{{requestPath}} - Request path to be appended values.
    P{{key}} - Key of the form value parameter.
    P{{value}} - Value of the form value parameter.
    R{{}} - If successful returns created request with encoded string. Else returns PinterestError.
}
function appendEncodedURIParameter(string requestPath, string key, string value) returns (string|PinterestError) {
    var encodedVar = http:encode(value, UTF_8);
    string encodedString;
    match encodedVar {
        string encoded => encodedString = encoded;
        error err => {
            PinterestError pinterestError = { message: "Error occurred when encoding the value " + value +
                " with charset "
                + UTF_8, cause: err };
            return pinterestError;
        }
    }
    if (requestPath != EMPTY_STRING) {
        requestPath += AMPERSAND_SYMBOL;
    }
    else {
        requestPath += QUESTION_MARK_SYMBOL;
    }
    return requestPath + key + EQUAL_SYMBOL + encodedString;
}
