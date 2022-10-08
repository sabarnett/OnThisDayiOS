/// Copyright (c) 2022 Razeware LLC
///

import SwiftUI

enum FetchError: Error {
    case badURL
    case badResponse
    case badJSON
}

enum Networker {
    
    static func getDataForDay(month: Int, day: Int, isPreview: Bool) async throws -> Day {
        
    var dayData: Data = Data()
        
        if isPreview {
            print("Loading local data")
            if let filepath = Bundle.main.path(forResource: "DownloadData", ofType: "json") {
                do {
                    let contents = try String(contentsOfFile: filepath)
                    dayData = contents.data(using: .utf8)!
                } catch {
                    // contents could not be loaded
                }
            } else {
                // example.txt not found!
            }
        } else {
            print("Loading network data")

            let address = "https://today.zenquotes.io/api/\(month)/\(day)"
            guard let url = URL(string: address) else {
                throw FetchError.badURL
            }
            let request = URLRequest(url: url)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse, response.statusCode < 400 else {
                throw FetchError.badResponse
            }
            
            dayData = data
        }
        
        //      let str = String(data: data, encoding: .utf8)!
        //      let filename = getDocumentsDirectory().appendingPathComponent("output.txt")
        //
        //      do {
        //          try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        //          print(filename)
        //          print(str)
        //      } catch {
        //          // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        //          print(error)
        //      }
        
        guard let day = try? JSONDecoder().decode(Day.self, from: dayData) else {
            if let debugString = String(data: dayData, encoding: .utf8) {
                print(debugString)
            }
            
            throw FetchError.badJSON
        }
        return day
    }

//    static func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
}
