//
//  ASKKeychain.swift
//  AskCoin-HD
//
//  Created by 仇弘扬 on 2017/8/14.
//  Copyright © 2017年 askcoin. All rights reserved.
//

import UIKit
import CryptoSwift

class ASKKeychain: NSObject {
	
	private var privateKey: Data?
	private var chainCode: Data?
	
	fileprivate var isMasterKey = false
	
	init(seedString: String) throws {
		
		let seed = seedString.ck_mnemonicData()
		let seedBytes = seed.bytes
		do {
			let hmac = try HMAC(key: "Bitcoin seed", variant: .sha512).authenticate(seedBytes)
			privateKey = Data(hmac[0..<32])
			chainCode = Data(hmac[32..<64])
			print(privateKey!.bytes.toHexString())
			print(chainCode!.bytes.toHexString())
			isMasterKey = true
		} catch {
			print(error)
			throw error
		}
		
	}
}
