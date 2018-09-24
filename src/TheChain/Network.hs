module TheChain.Network where

import Network.Socket hiding (send, sendTo, recv, recvFrom)
import Network.Socket.ByteString

resolveExternalAddress :: String -> String -> IO AddrInfo
resolveExternalAddress host port = do
    let socket_hints = defaultHints {
        addrFlags = [
            -- Always numeric IP
            AI_NUMERICHOST,
            -- Always numeric port
            AI_NUMERICSERV
        ],
        addrSocketType = Stream
    }
    addr_infos <- getAddrInfo (Just socket_hints) (Just host) (Just port)
    return (head addr_infos)

resolveListenAddress :: String -> IO AddrInfo
resolveListenAddress port = do
    let socket_hints = defaultHints {
        addrFlags = [
            -- Always numeric port
            AI_NUMERICSERV
        ],
        addrSocketType = Stream
    }
    addr_infos <- getAddrInfo (Just socket_hints) Nothing (Just port)
    return (head addr_infos)

--Creates a socket bound to an address to recieve info
openListenSocket :: AddrInfo -> IO Socket
openListenSocket addr = withSocketsDo $ do
    sock <- socket (addrFamily addr) (addrSocketType addr) (addrProtocol addr)
    bind sock (addrAddress addr)
    return sock

--Creates a connected socket to send info
openConnectSocket :: AddrInfo -> IO Socket
openConnectSocket addr = withSocketsDo $ do
    sock <- socket (addrFamily addr) (addrSocketType addr) (addrProtocol addr)
    connect sock (addrAddress addr)
    return sock
