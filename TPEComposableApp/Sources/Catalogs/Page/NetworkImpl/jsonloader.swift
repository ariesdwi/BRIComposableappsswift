//
//  jsonloader.swift
//  TPEComposable
//
//  Created by PT Siaga Abdi Utama on 21/10/25.
//


import Foundation

class JSONFileLoader {
    static func loadHomepageData() -> HomepageResponse? {
        guard let url = Bundle.main.url(forResource: "homepage_data", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("❌ Failed to load homepage_data.json")
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(HomepageResponse.self, from: data)
            print("✅ Homepage data loaded from JSON file successfully")
            return response
        } catch {
            print("❌ Failed to decode homepage_data.json: \(error)")
            return nil
        }
    }
}
