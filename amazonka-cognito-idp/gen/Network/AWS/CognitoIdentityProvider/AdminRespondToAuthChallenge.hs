{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric      #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}
{-# LANGUAGE TypeFamilies       #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-binds   #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.CognitoIdentityProvider.AdminRespondToAuthChallenge
-- Copyright   : (c) 2013-2016 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : auto-generated
-- Portability : non-portable (GHC extensions)
--
-- Responds to an authentication challenge, as an administrator.
--
--
-- Requires developer credentials.
--
module Network.AWS.CognitoIdentityProvider.AdminRespondToAuthChallenge
    (
    -- * Creating a Request
      adminRespondToAuthChallenge
    , AdminRespondToAuthChallenge
    -- * Request Lenses
    , artacChallengeResponses
    , artacSession
    , artacUserPoolId
    , artacClientId
    , artacChallengeName

    -- * Destructuring the Response
    , adminRespondToAuthChallengeResponse
    , AdminRespondToAuthChallengeResponse
    -- * Response Lenses
    , artacrsChallengeName
    , artacrsChallengeParameters
    , artacrsAuthenticationResult
    , artacrsSession
    , artacrsResponseStatus
    ) where

import           Network.AWS.CognitoIdentityProvider.Types
import           Network.AWS.CognitoIdentityProvider.Types.Product
import           Network.AWS.Lens
import           Network.AWS.Prelude
import           Network.AWS.Request
import           Network.AWS.Response

-- | The request to respond to the authentication challenge, as an administrator.
--
--
--
-- /See:/ 'adminRespondToAuthChallenge' smart constructor.
data AdminRespondToAuthChallenge = AdminRespondToAuthChallenge'
    { _artacChallengeResponses :: !(Maybe (Map Text Text))
    , _artacSession            :: !(Maybe Text)
    , _artacUserPoolId         :: !Text
    , _artacClientId           :: !(Sensitive Text)
    , _artacChallengeName      :: !ChallengeNameType
    } deriving (Eq,Show,Data,Typeable,Generic)

-- | Creates a value of 'AdminRespondToAuthChallenge' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'artacChallengeResponses' - The challenge response.
--
-- * 'artacSession' - The session.
--
-- * 'artacUserPoolId' - The ID of the Amazon Cognito user pool.
--
-- * 'artacClientId' - The client ID.
--
-- * 'artacChallengeName' - The name of the challenge.
adminRespondToAuthChallenge
    :: Text -- ^ 'artacUserPoolId'
    -> Text -- ^ 'artacClientId'
    -> ChallengeNameType -- ^ 'artacChallengeName'
    -> AdminRespondToAuthChallenge
adminRespondToAuthChallenge pUserPoolId_ pClientId_ pChallengeName_ =
    AdminRespondToAuthChallenge'
    { _artacChallengeResponses = Nothing
    , _artacSession = Nothing
    , _artacUserPoolId = pUserPoolId_
    , _artacClientId = _Sensitive # pClientId_
    , _artacChallengeName = pChallengeName_
    }

-- | The challenge response.
artacChallengeResponses :: Lens' AdminRespondToAuthChallenge (HashMap Text Text)
artacChallengeResponses = lens _artacChallengeResponses (\ s a -> s{_artacChallengeResponses = a}) . _Default . _Map;

-- | The session.
artacSession :: Lens' AdminRespondToAuthChallenge (Maybe Text)
artacSession = lens _artacSession (\ s a -> s{_artacSession = a});

-- | The ID of the Amazon Cognito user pool.
artacUserPoolId :: Lens' AdminRespondToAuthChallenge Text
artacUserPoolId = lens _artacUserPoolId (\ s a -> s{_artacUserPoolId = a});

-- | The client ID.
artacClientId :: Lens' AdminRespondToAuthChallenge Text
artacClientId = lens _artacClientId (\ s a -> s{_artacClientId = a}) . _Sensitive;

-- | The name of the challenge.
artacChallengeName :: Lens' AdminRespondToAuthChallenge ChallengeNameType
artacChallengeName = lens _artacChallengeName (\ s a -> s{_artacChallengeName = a});

instance AWSRequest AdminRespondToAuthChallenge where
        type Rs AdminRespondToAuthChallenge =
             AdminRespondToAuthChallengeResponse
        request = postJSON cognitoIdentityProvider
        response
          = receiveJSON
              (\ s h x ->
                 AdminRespondToAuthChallengeResponse' <$>
                   (x .?> "ChallengeName") <*>
                     (x .?> "ChallengeParameters" .!@ mempty)
                     <*> (x .?> "AuthenticationResult")
                     <*> (x .?> "Session")
                     <*> (pure (fromEnum s)))

instance Hashable AdminRespondToAuthChallenge

instance NFData AdminRespondToAuthChallenge

instance ToHeaders AdminRespondToAuthChallenge where
        toHeaders
          = const
              (mconcat
                 ["X-Amz-Target" =#
                    ("AWSCognitoIdentityProviderService.AdminRespondToAuthChallenge"
                       :: ByteString),
                  "Content-Type" =#
                    ("application/x-amz-json-1.1" :: ByteString)])

instance ToJSON AdminRespondToAuthChallenge where
        toJSON AdminRespondToAuthChallenge'{..}
          = object
              (catMaybes
                 [("ChallengeResponses" .=) <$>
                    _artacChallengeResponses,
                  ("Session" .=) <$> _artacSession,
                  Just ("UserPoolId" .= _artacUserPoolId),
                  Just ("ClientId" .= _artacClientId),
                  Just ("ChallengeName" .= _artacChallengeName)])

instance ToPath AdminRespondToAuthChallenge where
        toPath = const "/"

instance ToQuery AdminRespondToAuthChallenge where
        toQuery = const mempty

-- | Responds to the authentication challenge, as an administrator.
--
--
--
-- /See:/ 'adminRespondToAuthChallengeResponse' smart constructor.
data AdminRespondToAuthChallengeResponse = AdminRespondToAuthChallengeResponse'
    { _artacrsChallengeName        :: !(Maybe ChallengeNameType)
    , _artacrsChallengeParameters  :: !(Maybe (Map Text Text))
    , _artacrsAuthenticationResult :: !(Maybe AuthenticationResultType)
    , _artacrsSession              :: !(Maybe Text)
    , _artacrsResponseStatus       :: !Int
    } deriving (Eq,Show,Data,Typeable,Generic)

-- | Creates a value of 'AdminRespondToAuthChallengeResponse' with the minimum fields required to make a request.
--
-- Use one of the following lenses to modify other fields as desired:
--
-- * 'artacrsChallengeName' - The name of the challenge.
--
-- * 'artacrsChallengeParameters' - The challenge parameters.
--
-- * 'artacrsAuthenticationResult' - The result returned by the server in response to the authentication request.
--
-- * 'artacrsSession' - The session.
--
-- * 'artacrsResponseStatus' - -- | The response status code.
adminRespondToAuthChallengeResponse
    :: Int -- ^ 'artacrsResponseStatus'
    -> AdminRespondToAuthChallengeResponse
adminRespondToAuthChallengeResponse pResponseStatus_ =
    AdminRespondToAuthChallengeResponse'
    { _artacrsChallengeName = Nothing
    , _artacrsChallengeParameters = Nothing
    , _artacrsAuthenticationResult = Nothing
    , _artacrsSession = Nothing
    , _artacrsResponseStatus = pResponseStatus_
    }

-- | The name of the challenge.
artacrsChallengeName :: Lens' AdminRespondToAuthChallengeResponse (Maybe ChallengeNameType)
artacrsChallengeName = lens _artacrsChallengeName (\ s a -> s{_artacrsChallengeName = a});

-- | The challenge parameters.
artacrsChallengeParameters :: Lens' AdminRespondToAuthChallengeResponse (HashMap Text Text)
artacrsChallengeParameters = lens _artacrsChallengeParameters (\ s a -> s{_artacrsChallengeParameters = a}) . _Default . _Map;

-- | The result returned by the server in response to the authentication request.
artacrsAuthenticationResult :: Lens' AdminRespondToAuthChallengeResponse (Maybe AuthenticationResultType)
artacrsAuthenticationResult = lens _artacrsAuthenticationResult (\ s a -> s{_artacrsAuthenticationResult = a});

-- | The session.
artacrsSession :: Lens' AdminRespondToAuthChallengeResponse (Maybe Text)
artacrsSession = lens _artacrsSession (\ s a -> s{_artacrsSession = a});

-- | -- | The response status code.
artacrsResponseStatus :: Lens' AdminRespondToAuthChallengeResponse Int
artacrsResponseStatus = lens _artacrsResponseStatus (\ s a -> s{_artacrsResponseStatus = a});

instance NFData AdminRespondToAuthChallengeResponse
