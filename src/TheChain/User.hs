module TheChain.User where

import TheChain.ChainLink
import TheChain.Hash

data User = User {
    writtenHash :: String,
    version :: Integer,
    nickname :: String,
    localIP :: String,
    port :: String,
    publicKey :: String
}
_userAsList :: User -> [String]
_userAsList u = [
        calculateFreshHash u,
        show $ version u,
        nickname u,
        localIP u,
        port u,
        publicKey u
    ]

instance ChainLink User where
    getWrittenHash = writtenHash
    calculateFreshHash = sha3 . unlines . tail . _userAsList
    getVersion = version

    linkAsString = unlines . _userAsList
    stringAsLink s =
        case (length ls) of
            6 -> Right $ User {
                writtenHash = ls !! 0,
                version = read (ls !! 1),
                nickname = ls !! 2,
                localIP = ls !! 3,
                port = ls !! 4,
                publicKey = ls !! 5
            }
            _ -> Left "Invalid user format."
        where
            ls = lines s
