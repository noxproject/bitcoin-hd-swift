//
//  ASKHDUtils.swift
//  AskCoin-HD
//
//  Created by 仇弘扬 on 2017/8/16.
//  Copyright © 2017年 askcoin. All rights reserved.
//

import Foundation

protocol HexToData {
	func hexToData() -> Data
}

extension UInt32: HexToData {
	func hexToData() -> Data {
		var v = self.byteSwapped
		let data = Data(bytes: &v, count: MemoryLayout<UInt32>.size)
		return data
	}
}

extension UInt8: HexToData {
	func hexToData() -> Data {
		var v = self
		let data = Data(bytes: &v, count: MemoryLayout<UInt8>.size)
		return data
	}
}

extension Data {
	func BTCHash256() -> Data {
		return self.sha256().sha256()
	}
	func ck_reversedData() -> Data {
		return Data(reversed())
	}
	func base58Check() -> String {
		return ASKBase58.encode(data: self)
	}
}
