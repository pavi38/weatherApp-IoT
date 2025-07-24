//
//  weatherViewModel.swift
//  weatherapp
//
//  Created by Pavneet Cheema on 1/26/25.
//

import Foundation
import MongoSwift
import NIO
struct data: Codable {
    let _id: BSONObjectID
    let temp: Int
    let humid: Int
    let pressure: Int
}
class weatherViewModel: ObservableObject {
    let elg = MultiThreadedEventLoopGroup(numberOfThreads: 4)
    // MongoDB Configuration
    let uri = "mongodb+srv://pavneetsingh685:fb5pBhCw6gTDJgpH@cluster0.jslg1.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
    let databaseName = "weatherdata"
    let collectionName = "bme"
    
    @Published var temprature: Int = 76
    @Published var humidity: Int = 45
    @Published var pressure: Int = 36
    init(){
        Task {
            do {
                try await listenForLatestEntry()
            } catch {
                print("Failed to listen for changes: \(error)")
            }
        }
    }

    func listenForLatestEntry() async throws {
        // Create a MongoClient
        let client = try MongoClient(uri, using: elg)

        // Access the database and collection
        let database = client.db(databaseName)
        let collection = database.collection(collectionName, withType: data.self) // Specify the Codable struct here

        // Open a change stream to listen for inserts
        let changeStream = try await collection.watch([
            ["$match": ["operationType": "insert"]] // Filter to only listen for inserts
        ])

        // Process change stream events
        for try await changeEvent in changeStream {
            if let fullDocument = changeEvent.fullDocument {
                self.temprature = fullDocument.temp
                self.humidity = fullDocument.humid
                self.pressure = fullDocument.pressure
                print("New document inserted: \(fullDocument)")
            } else {
                print("Insert detected, but no document data available.")
            }
        }
    }

}
