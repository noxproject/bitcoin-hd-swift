//
//  ASKKeychain.swift
//  AskCoin-HD
//
//  Created by 仇弘扬 on 2017/8/14.
//  Copyright © 2017年 askcoin. All rights reserved.
//

import UIKit
import CryptoSwift

let BTCKeychainMainnetPrivateVersion: UInt32 = 0x0488ADE4
let BTCKeychainMainnetPublicVersion: UInt32 = 0x0488B21E

let BTCKeychainTestnetPrivateVersion: UInt32 = 0x04358394
let BTCKeychainTestnetPublicVersion: UInt32 = 0x043587CF

class ASKKeychain: NSObject {
	
	private var privateKey: Data?
//	private var publicKey: Data?
	private var chainCode: Data?
	
	fileprivate var isMasterKey = false
	
	var network = ASKNetwork()
	var depth: UInt8 = 0
	var hardened = false
	var index: UInt32 = 0
	
	init(seedString: String) throws {
		
		let seed = seedString.ck_mnemonicData()
		let seedBytes = seed.bytes
		do {
			let hmac = try HMAC(key: "Bitcoin seed", variant: .sha512).authenticate(seedBytes)
			privateKey = Data(hmac[0..<32])
			chainCode = Data(hmac[32..<64])
			print("privateKey = " + privateKey!.bytes.toHexString())
			print("chainCode = " + chainCode!.bytes.toHexString())
			isMasterKey = true
		} catch {
			print(error)
			throw error
		}
	}
	
	lazy var parentFingerprint: UInt32 = {
		return 0
	}()
	
	private lazy var publicKey: Data? = {
		guard self.privateKey != nil else {
			return nil
		}
		return ASKKey.generatePublicKey(with: self.privateKey!)
	}()
	
	// MARK: - Extended private key
	lazy var extendedPrivateKey: String = {
		self.extendedPrivateKeyData.base58Check()
	}()
	
	lazy var extendedPrivateKeyData: Data = {
		guard self.privateKey != nil else {
			return Data()
		}
		
		var toReturn = Data()
		
		let version = self.network.isMainNet ? BTCKeychainMainnetPrivateVersion : BTCKeychainTestnetPrivateVersion
		toReturn += self.extendedKeyPrefix(with: version)
		
		toReturn += UInt8(0).hexToData()
		
		if let prikey = self.privateKey {
			toReturn += prikey
		}
		
		return toReturn
	}()
	
	// MARK: - Extended public key
	lazy var extendedPublicKey: String = {
		self.extendedPublicKeyData.base58Check()
	}()
	
	lazy var extendedPublicKeyData: Data = {
		guard self.publicKey != nil else {
			return Data()
		}
		
		var toReturn = Data()
		
		let version = self.network.isMainNet ? BTCKeychainMainnetPublicVersion : BTCKeychainTestnetPublicVersion
		toReturn += self.extendedKeyPrefix(with: version)
		
		if let pubkey = self.publicKey {
			toReturn += pubkey
		}
		
		return toReturn
	}()
	
	func extendedKeyPrefix(with version: UInt32) -> Data {
		var toReturn = Data()
		
		let versionData = version.hexToData()
		toReturn += versionData
		
		let depthData = depth.hexToData()
		toReturn += depthData
		
		let parentFPData = parentFingerprint.hexToData()
		toReturn += parentFPData
		
		let childIndex = hardened ? (0x80000000 | index) : index
		let childIndexData = childIndex.hexToData()
		toReturn += childIndexData
		
		if let cCode = chainCode {
			toReturn += cCode
		}
		else
		{
			print("chain code 异常")
		}
		
		return toReturn
	}
	
}
