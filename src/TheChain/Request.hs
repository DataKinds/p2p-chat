module TheChain.Request where

data RequestType =
    ANNOUNCE
    | ASK_UPDATE_USERS
    | UPDATE_USERS
    | ASK_UPDATE_MESSAGES
    | UPDATE_MESSAGES
    | ASK_MESSAGE_HASH
    | MESSAGE_HASH
    | ASK_USER_HASH
    | USER_HASH


--class Read r => Request r where
class Request r where
    requestType :: r -> RequestType

data AnnounceRequest = AnnounceRequest {
    nickname :: String,
    localIP :: String,
    port :: String,
    publicKey :: String
}
instance Request AnnounceRequest where
    requestType r = ANNOUNCE

-- TODO: finish typing out the requests
