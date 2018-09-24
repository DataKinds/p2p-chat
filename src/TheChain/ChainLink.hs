module TheChain.ChainLink where

class ChainLink c where
    -- These must be SHA3-512 to fit the spec
    getWrittenHash :: c -> String
    calculateFreshHash :: c -> String

    getVersion :: c -> Integer

    -- This is for reading and writing the link
    linkAsString :: c -> String
    stringAsLink :: String -> Either String c
