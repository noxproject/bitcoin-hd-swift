//
//  ASKBase58.swift
//  AskCoin-HD
//
//  Created by 仇弘扬 on 2017/8/16.
//  Copyright © 2017年 askcoin. All rights reserved.
//

import Foundation

struct ASKBase58 {
	static func encode(data: Data) -> String {
		let strs = Array("123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".characters)
		
		let checksum = data.BTCHash256()
		let tmp = data + checksum[0...3]
		
		var dec = BInt(hex: tmp.toHexString())
		
		let dec58 = BInt(58)
		let dec0 = BInt(0)
		
		var results = Array<String>()
		while dec > dec0 {
			
			let rem = dec % dec58
			dec = dec / dec58
			
			if let index = rem.toInt() {
				results.append(String(strs[index]))
			}
			
		}
		let result = results.reversed().joined()
		
		return result
	}
}
