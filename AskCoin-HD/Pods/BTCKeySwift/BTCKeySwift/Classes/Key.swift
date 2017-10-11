//
//  ASKKey.swift
//  AskCoin-HD
//
//  Created by 仇弘扬 on 2017/8/17.
//  Copyright © 2017年 askcoin. All rights reserved.
//

import UIKit
import ASKSecp256k1

enum KeyVerifyResult: Int, Error {
	case signatureInvalid = -4
	case publicKeyInvalid = -3
	case privateKeyInvalid = -2
	case invalid = 0
	case valid = 1
}

// TODO: - BTC sign and verify

public class Key: NSObject {
	public static func generatePublicKey(with privateKey: Data, compression: Bool = true) -> Data {
		var data = Data()
		if let t = CKSecp256k1.generatePublicKey(withPrivateKey: privateKey, compression: compression) {
			data.append(t)
		}
		return data
	}
	
	public static func sign(data: Data, privateKey: Data) -> Data {
		var data = Data()
		if let t = CKSecp256k1.compactSign(data, withPrivateKey: privateKey) {
			data.append(t)
		}
		return data
	}
	
	public static func verify(sigData: Data, srcData: Data, publicKey: Data) throws -> Bool {
		let verifyResult = CKSecp256k1.verifySignedData(sigData, withMessageData: srcData, usePublickKey: publicKey)
		
		if let r = KeyVerifyResult(rawValue: verifyResult) {
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
	
	public var privateKey: Data?
	public lazy var publicKey: Data? = {
		guard let prvKey = self.privateKey else {
			return nil
		}
		return Key.generatePublicKey(with: prvKey)
	}()
	
	public init(privateKey: Data) {
		self.privateKey = privateKey
	}
	
	public func sign(data: Data) -> Data? {
		guard let prvKey = self.privateKey else {
			return nil
		}
		return Key.sign(data: data, privateKey: prvKey)
	}
	
	public func verify(sigData: Data, srcData: Data) throws -> Bool {
		guard let pubKey = self.publicKey else {
			throw KeyVerifyResult.publicKeyInvalid
		}
		return try Key.verify(sigData: sigData, srcData: srcData, publicKey: pubKey)
	}
	
}
