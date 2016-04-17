//: # Server Example
//: Let's imagine there's a server of some kind (maybe a TCP/UDP server) that allows for firmware updates over a specific protocol. (Maybe like an ArtNet device.)
//: We're going to construct a fictional example of what it might look like to update the firmware - synchronously, mind - in Swift 2 (__WITH__ error handling).
//:
//: In practice, it would be better to provide more detail. `Connection` handles timing out and open/close issues, while FirmwareUpdate handles more broad errors: failing to receive a specific message, etc. More detail would be useful - e.g whether the firmware update failed because of a response timing out.

struct Server {}

class Connection {
    let server: Server
    private(set) var state = State.Inactive
    
    enum State {
        case Inactive
        case Open
        case Closed
    }
    
    enum Error : ErrorType {
        case InvalidState
        case TimedOut
    }
    
    init(server: Server) {
        self.server = server
    }
    
    func open() throws {
        guard case .Inactive = state else {
            // can only be opened when inactive
            throw Error.InvalidState
        }
        
        state = .Open
    }
    
    func close() throws {
        guard case .Open = state else {
            // can only be closed when open
            throw Error.InvalidState
        }
        
        state = .Closed
    }
    
    func sendMessage(packet: String) throws {
        guard case .Open = state else {
            // can only send packets when open
            throw Error.InvalidState
        }
    }
    
    func sendInitiationRequest() -> Bool {
        return true
    }
    
    func waitForResponse() throws -> String {
        // It's very possible for an error to occur here, but we don't have an example...
        
        return "1"
    }
}

final class FakeConnection : Connection {
    private(set) var responses: [String]
    
    init(server: Server, responses: [String]) {
        self.responses = responses
        super.init(server: server)
    }
    
    override func waitForResponse() throws -> String {
        return responses.removeFirst()
    }
}

final class FakeBadConnection : Connection {
    override func waitForResponse() throws -> String {
        throw Error.TimedOut
    }
}

struct FirmwareUpdate {
    enum Error : ErrorType {
        case FailedToInitiate
        case FailedToTerminate
        case InvalidResponse
    }
    
    enum Command : String {
        case BeginFirmwareUpdate = "beginFirmwareUpdate"
        case EndFirmwareUpdate = "endFirmwareUpdate"
    }
    
    enum Response : String {
        case ReadyForFirmwareUpdate = "readyForFirmwareUpdate"
        case EndedFirmwareUpdate = "endedFirmwareUpdate"
    }
    
    func upload(connection connection: Connection) throws {
        defer {
            // Close the connection, no matter what happens!
            do {
                try connection.close()
            }
            catch {
                // if connection fails to close, do nothing.
            }
        }
        
        try connection.open()
        try connection.sendMessage(Command.BeginFirmwareUpdate.rawValue)
        
        // Wait for a reply
        guard Response(rawValue: try connection.waitForResponse()) == Response.ReadyForFirmwareUpdate else {
            // Either no response or not the response we wanted
            throw Error.FailedToInitiate
        }
        
        // initiation succeeded.
        // begin sending firmware packets.
        
        for packet in ["A", "B", "C"] {
            try connection.sendMessage(packet)
            
            // Wait for a reply
            guard try connection.waitForResponse() == packet else {
                // Got a response, but wasn't what we wanted
                throw Error.InvalidResponse
            }
        }
        
        // firmware packets sent
        // end firmware update
        
        try connection.sendMessage(Command.EndFirmwareUpdate.rawValue)
        
        guard Response(rawValue: try connection.waitForResponse()) == Response.EndedFirmwareUpdate else {
            throw Error.FailedToTerminate
        }
    }
}

do {
    // successful firmware update
    
    let connection = FakeConnection(server: Server(), responses: [FirmwareUpdate.Response.ReadyForFirmwareUpdate.rawValue, "A", "B", "C", FirmwareUpdate.Response.EndedFirmwareUpdate.rawValue])
    let update = FirmwareUpdate()
    try update.upload(connection: connection)
    
    print("Firmware updated.")
}
catch {
    print("Failed to update firmware: \(error)")
}

do {
    // non-successful firmware update - fails at firmware initiation
    
    let connection = FakeConnection(server: Server(), responses: ["notReadyForFirmwareUpdate", "A", "B", "C", FirmwareUpdate.Response.EndedFirmwareUpdate.rawValue])
    let update = FirmwareUpdate()
    try update.upload(connection: connection)
    
    print("Firmware updated.")
}
catch {
    print("Failed to update firmware: \(error)")
}

do {
    // non-successful firmware update - fails at packet transfer
    
    let connection = FakeConnection(server: Server(), responses: [FirmwareUpdate.Response.ReadyForFirmwareUpdate.rawValue, "A", "D", "C", FirmwareUpdate.Response.EndedFirmwareUpdate.rawValue])
    let update = FirmwareUpdate()
    try update.upload(connection: connection)
    
    print("Firmware updated.")
}
catch {
    print("Failed to update firmware: \(error)")
}

do {
    // non-successful firmware update - fails at termination
    
    let connection = FakeConnection(server: Server(), responses: [FirmwareUpdate.Response.ReadyForFirmwareUpdate.rawValue, "A", "B", "C", "notEnded"])
    let update = FirmwareUpdate()
    try update.upload(connection: connection)
    
    print("Firmware updated.")
}
catch {
    print("Failed to update firmware: \(error)")
}

do {
    // non-successful firmware update - connection times out
    
    let connection = FakeBadConnection(server: Server())
    let update = FirmwareUpdate()
    try update.upload(connection: connection)
    
    print("Firmware updated.")
}
catch Connection.Error.TimedOut {
    // we can pick out this specific error!
    print("Connection timed out.")
}
catch {
    print("Failed to update firmware: \(error)")
}
