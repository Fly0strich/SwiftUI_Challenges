//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Shae Willes on 9/15/22.
//

import Foundation

extension FileManager {
  static var documentsDirectory: URL {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}
