import Foundation
import GRPC
import NIO

// Assuming you have the necessary .proto files and have generated the Swift code for them.

class LocationServiceProvder {
    let group: EventLoopGroup
    var channel: GRPCChannel?
    var locationClient: LocationServiceAsyncClient?
    
    init() {
        print("init")
        self.group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        
        do {
            self.channel = try GRPCChannelPool.with(
                target: .host("localhost", port: 50051),
                transportSecurity: .plaintext,
                eventLoopGroup: group
            )
            self.locationClient = LocationServiceAsyncClient(channel: channel!)
        }
        catch {
            print("Error with channel \(error)")
        }
    }
    
    deinit {
        try? group.syncShutdownGracefully()
    }
    
    
    
   
    func beginListening() -> AsyncStream<Location> {
        print("began listening")
        return AsyncStream<Location> { continuation in
            Task {
                do {
                    try await withThrowingTaskGroup(of: Void.self) { group in
                        let locationSession = self.locationClient?.makeLocationSessionCall()

                        // Sending query task
                        group.addTask {
                            var query = QueryUpdate()
                            query.pan = LocationPan()
                            query.pan.lat = 37.773972
                            query.pan.lon = -122.431297
                            do {
                                try await locationSession?.requestStream.send(query)
                                locationSession?.requestStream.finish()
                            } catch {
                                print("Error sending query: \(error)")
                                continuation.finish()
                            }
                        }

                        // Receiving locations task
                        group.addTask {
                            guard let locationSession = locationSession else {
                                continuation.finish()
                                return
                            }
                            for try await location in locationSession.responseStream {
                                continuation.yield(location.location)
                            }
                        }
                    }
                } catch {
                    print("Task group error: \(error)")
                    continuation.finish()
                }
                continuation.finish()
            }
        }
    }

}

