//
//  KeyGenerator.swift
//  AskCoin-HD
//
//  Created by 仇弘扬 on 2017/8/25.
//  Copyright © 2017年 askcoin. All rights reserved.
//

import UIKit
import BTCKeySwift

protocol BTCPublicKeyGenerator
{
	static func generatePublicKey(with privateKey: Data, compression: Bool) -> Data
}

//class KeyGenerator: Key {
//
//}
