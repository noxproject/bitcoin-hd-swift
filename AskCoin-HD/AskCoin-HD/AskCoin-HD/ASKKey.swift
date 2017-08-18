//
//  ASKKey.swift
//  AskCoin-HD
//
//  Created by 仇弘扬 on 2017/8/17.
//  Copyright © 2017年 askcoin. All rights reserved.
//

import UIKit
import ASKSecp256k1

class ASKKey: NSObject {
	static func generatePublicKey(with privateKey: Data, compression: Bool = true) -> Data {
		var data = Data()
		if let t = CKScep256k1.generatePublicKey(withPrivateKey: privateKey, compression: compression) {
			data.append(t)
		}
		return data
	}
}
