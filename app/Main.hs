module Main where

import TheChain.ChainLink
import TheChain.Message
import TheChain.User
import Network.Socket hiding (send, sendTo, recv, recvFrom)
import Network.Socket.ByteString



main :: IO ()
main = putStrLn "hello"
