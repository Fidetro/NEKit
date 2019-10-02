//
//  GCMCrypto.swift
//  NEKit-macOS
//
//  Created by Fidetro on 2019/10/2.
//  Copyright © 2019 Zhuhao Wang. All rights reserved.
//

import CryptoSwift
open class GCMCrypto: StreamCryptoProtocol {
    public func update(_ data: inout Data) {
        switch operation {
        case .decrypt:
            let bytes = try? aes?.decrypt([UInt8](data))
            if let bytes = bytes {
               data = Data(bytes: bytes, count: bytes.count)
            }
        case .encrypt:
            let bytes = try? aes?.encrypt([UInt8](data))
            if let bytes = bytes {
                data = Data(bytes: bytes, count: bytes.count)
            }
        }
    }
    var aes : AES?
    let operation: CryptoOperation
    public init(operation: CryptoOperation, initialVector: Data?, key: Data) {
       self.operation = operation
        if let initialVector = initialVector {
            let gcm = GCM(iv: [UInt8](initialVector), mode: .combined)
            aes = try? AES(key: [UInt8](key), blockMode: gcm, padding: .noPadding)
        }
    }

    
}
