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

function convertJsonUserToUserType(json sourceJsonUser) returns User{
    User targetUserType;
    targetUserType.id = sourceJsonUser.id.toString();
    targetUserType.bio = sourceJsonUser.bio.toString();
    targetUserType.createdAt = sourceJsonUser.created_at.toString();
    targetUserType.firstName = sourceJsonUser.first_name.toString();
    targetUserType.lastName = sourceJsonUser.last_name.toString();
    targetUserType.username = sourceJsonUser.username.toString();
    targetUserType.counts = sourceJsonUser.counts;
    targetUserType.image = sourceJsonUser.image;
    return targetUserType;
}