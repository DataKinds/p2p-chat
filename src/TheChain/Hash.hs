module TheChain.Hash where

import qualified Data.ByteString.Char8 as BS
import Crypto.Hash

sha3 :: String -> String
sha3 s = show (hash bs :: Digest SHA3_512)
    where
        bs = BS.pack s
