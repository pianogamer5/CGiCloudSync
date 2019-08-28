//
//  CGiCloud.swift
//  CGiCloudSync
//
//  Created by Greene, Carson on 8/14/19.
//  Copyright © 2019 Techsmith. All rights reserved.
//

import Foundation

let iCloudSyncEnabledKey = "iCloudSyncEnabled";

public class CGiCloud {
   @objc public static var iCloudSyncEnabled : Bool {
      get {
         return UserDefaults.standard.bool(forKey: iCloudSyncEnabledKey)
      }
      set {
         UserDefaults.standard.set(newValue, forKey: iCloudSyncEnabledKey)
      }
   }
}
