//
//  ContentController.swift
//  frontend
//
//  Created by Frank Guglielmo on 11/19/23.
//

import Foundation
import UIKit
import NIO
import GRPC

class ContentController: UIViewController {
    
    var locations: [Location] = []
    
    // gRPC client and channel
    private var channel: ClientConnection
    private var grpcClient: LocationServiceNIOClient

        init() {
            // Configure the channel for the gRPC connection
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            self.channel = ClientConnection.insecure(group: group)
                             .connect(host: "localhost", port: 50051)

            // Initialize the gRPC client
            self.grpcClient = LocationServiceNIOClient(channel: channel)

            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }


        override func viewDidLoad() {
            super.viewDidLoad()
            let locations = AsyncStream<Location> { [self] continuation in
                let call = grpcClient.locationSession(handler: { response in
                    if response.location != nil {
                        continuation.yield(response.location)
                    } else {
                        continuation.finish()
                    }
                })
                
                var query = QueryUpdate()
                query.pan = LocationPan()
                query.pan.lat = 37.773972
                query.pan.lon = -122.431297
                call.sendMessage(query, promise: nil)
            }
            
            
        }

        // Don't forget to shut down the channel when it's no longer needed
        deinit {
            try? channel.close().wait()
        }
    }
    
