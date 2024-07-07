//
//  FlickrItemTests.swift
//  FlickrItemTests
//
//  Created by Ron Jurincie on 7/7/24.
//

import XCTest
@testable import FlickrItem

final class FlickrItemTests: XCTestCase {
    
    func testDownloadManager_Fetch_WillNotReturnBadURL() {
        // when
        Task {
            let result = try await DownloadManager.fetch(from: "xxx")
            
            XCTAssertNil(result)
        }
    }
    
    func testDownloadManager_Fetch_WillReturnGoodURL() {
        // when
        Task {
            let result = try await DownloadManager.fetch(from: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=")
            
            XCTAssertNotNil(result)
        }
    }
}
