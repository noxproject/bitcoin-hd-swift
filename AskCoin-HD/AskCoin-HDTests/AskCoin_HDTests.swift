//
//  AskCoin_HDTests.swift
//  AskCoin-HDTests
//
//  Created by 仇弘扬 on 2017/8/14.
//  Copyright © 2017年 askcoin. All rights reserved.
//

import XCTest
@testable import AskCoin_HD

struct TestVector {
	var hexString: String?
	var extPub: String?
	var extPrv: String?
	var paths = Array<TestVector>()
	var path: String?
	init(dic: Dictionary<String, Any>) {
		if dic.keys.contains("seed") {
			hexString = dic["seed"] as? String
		}
		if dic.keys.contains("paths") {
			let arr: Array<Dictionary<String, Any>> = dic["paths"] as! Array<Dictionary<String, Any>>
			for d in arr {
				paths.append(TestVector(dic: d))
			}
		}
		if dic.keys.contains("path") {
			path = dic["path"] as? String
			extPub = dic["extPub"] as? String
			extPrv = dic["extPrv"] as? String
		}
	}
}

class AskCoin_HDTests: XCTestCase {
	
	var testVectors = Array<TestVector>()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
		let arr = NSArray(contentsOfFile: Bundle.main.path(forResource: "TestVectors", ofType: "plist")!)!
		for dic in arr {
			testVectors.append(TestVector(dic: dic as! Dictionary<String, Any>))
		}
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		for vector in testVectors {
			let seed = vector.hexString
			do {
				let keychain = try Keychain(seedString: seed!)
				for t in vector.paths {
					let kc = try keychain.derivedKeychain(at: t.path!)
					XCTAssertEqual(t.extPrv, kc.extendedPrivateKey)
					XCTAssertEqual(t.extPub, kc.extendedPublicKey)
				}
			} catch {
				print(error)
				XCTFail()
			}
		}
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
			self.testExample()
        }
    }
    
}
