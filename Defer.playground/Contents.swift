//: # Server Example
//: Let's imagine there's a server of some kind (maybe a TCP/UDP server) that allows for firmware updates over a specific protocol. (Maybe like an ArtNet device.)
//: We're going to construct a fictional example of what it might look like to update the firmware - synchronously, mind - in Swift 2 (without error handling).

struct Server {}

class Connection {
    let server: Server
    private(set) var state = State.Inactive
    
    enum State {
        case Inactive
        case Open
        case Closed
    }
    
    init(server: Server) {
        self.server = server
    }
    
    func open() -> Bool {
        guard case .Inactive = state else {
            // can only be opened when inactive
            return false
        }
        
        state = .Open
        return true
    }
    
    func close() -> Bool {
        guard case .Open = state else {
            // can only be closed when open
            return false
        }
        
        state = .Closed
        return true
    }
    
    func sendMessage(packet: String) -> Bool {
        guard case .Open = state else {
            // can only send packets when open
            return false
        }
        
        // otherwise, assume the packet sent!
        return true
    }
    
    func sendInitiationRequest() -> Bool {
        return true
    }
    
    func waitForResponse() -> String? {
        return "1"
    }
}

final class FakeConnection : Connection {
    private(set) var responses: [String]
    
    init(server: Server, responses: [String]) {
        self.responses = responses
        super.init(server: server)
    }
    
    override func waitForResponse() -> String? {
        return responses.removeFirst()
    }
}

struct FirmwareUpdate {
    func upload(connection connection: Connection) -> Bool {
        defer {
            //: Close the connection, no matter what happens!
            connection.close()
        }
        
        guard connection.open() else {
            return false
        }
        
        guard connection.sendMessage("beginFirmwareUpdate") else {
            return false
        }
        
        guard connection.waitForResponse() == "1" else {
            return false
        }
        
        // initiation succeeded.
        // begin sending firmware packets.
        
        for packet in ["A", "B", "C"] {
            guard connection.sendMessage(packet) else {
                return false
            }
            
            guard connection.waitForResponse() == packet else {
                return false
            }
        }
        
        // firmware packets sent
        // end firmware update
        
        guard connection.sendMessage("endFirmwareUpdate") else {
            return false
        }
        
        guard connection.waitForResponse() == "2" else {
            return false
        }
        
        return true
    }
}

do {
    // successful firmware update
    
    let connection = FakeConnection(server: Server(), responses: ["1", "A", "B", "C", "2"])
    let update = FirmwareUpdate()
    let result = update.upload(connection: connection)
    
    print("Connection open? \(connection.state)")
}

do {
    // non-successful firmware update - fails at firmware initiation
    
    let connection = FakeConnection(server: Server(), responses: ["2", "A", "B", "C", "2"])
    let update = FirmwareUpdate()
    let result = update.upload(connection: connection)
    
    print("Connection open? \(connection.state)")
}

do {
    // non-successful firmware update - fails at packet transfer
    
    let connection = FakeConnection(server: Server(), responses: ["1", "A", "A", "C", "2"])
    let update = FirmwareUpdate()
    let result = update.upload(connection: connection)
    
    print("Connection open? \(connection.state)")
}

do {
    // non-successful firmware update - fails at termination
    
    let connection = FakeConnection(server: Server(), responses: ["1", "A", "B", "C", "D"])
    let update = FirmwareUpdate()
    let result = update.upload(connection: connection)
    
    print("Connection open? \(connection.state)")
}

// in all cases, the connection is closed!
