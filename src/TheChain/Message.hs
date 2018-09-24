module TheChain.Message where

import TheChain.ChainLink
import TheChain.Hash
import Data.List
import Data.List.Split

data Message = Message {
    writtenHash :: String,
    version :: Integer,
    publicKeys :: [String],
    message :: String
}
_messageAsList :: Message -> [String]
_messageAsList m = [
        calculateFreshHash m,
        show $ version m,
        intercalate "\t" $ publicKeys m,
        message m
    ]

instance ChainLink Message where
    getWrittenHash = writtenHash
    calculateFreshHash = sha3 . unlines . tail . _messageAsList

    getVersion = version

    linkAsString = unlines . _messageAsList
    stringAsLink s =
        case (length ls) of
            4 -> Right $ Message {
                writtenHash = ls !! 0,
                version = read $ ls !! 1,
                publicKeys = filter (not . null) (splitOn "\t" (ls !! 2)),
                message = ls !! 3
            }
            _ -> Left "Invalid message format."
        where
            ls = lines s
