//
//  ASKKey.swift
//  AskCoin-HD
//
//  Created by 仇弘扬 on 2017/8/17.
//  Copyright © 2017年 askcoin. All rights reserved.
//

import UIKit
import ASKSecp256k1

enum ASKKeyVerifyResult: Int, Error {
	case signatureInvalid = -4
	case publicKeyInvalid = -3
	case invalid = 0
	case valid = 1
}

// TODO: - BTC sign and verify

class Key: NSObject {
	static func generatePublicKey(with privateKey: Data, compression: Bool = true) -> Data {
		var data = Data()
		if let t = CKSecp256k1.generatePublicKey(withPrivateKey: privateKey, compression: compression) {
			data.append(t)
		}
		return data
	}
	
	static func sign(data: Data, privateKey: Data) -> Data {
		var data = Data()
		if let t = CKSecp256k1.compactSign(data, withPrivateKey: privateKey) {
			data.append(t)
		}
		return data
	}
	
	static func verify(sigData: Data, srcData: Data, publicKey: Data) throws -> Bool {
		let verifyResult = CKSecp256k1.verifySignedData(sigData, withMessageData: srcData, usePublickKey: publicKey)
		
		if let r = ASKKeyVerifyResult(rawValue: verifyResult) {
			if r == .valid {
				return true
			}
			else
			{
				throw r
			}
		}
		
		return false
	}
	
}
