//
//  CGiCloudKVStore.swift
//  CGiCloudSync
//
//  Created by Greene, Carson on 8/14/19.
//  Copyright © 2019 Carson Greene. All rights reserved.
//

import Foundation

public class CGiCloudKVStore {   
   @objc public static func set(bool: Bool, forKey key: String) {
      UserDefaults.standard.set(bool, forKey: key)
      if CGiCloud.iCloudSyncEnabled {
         NSUbiquitousKeyValueStore.default.set(bool, forKey: key)
         NSUbiquitousKeyValueStore.default.synchronize()
      }
   }
   
   @objc public static func set(string: String, forKey key: String) {
      UserDefaults.standard.set(string, forKey: key)
      if CGiCloud.iCloudSyncEnabled {
         NSUbiquitousKeyValueStore.default.set(string, forKey: key)
         NSUbiquitousKeyValueStore.default.synchronize()
      }
   }
   
   @objc public static func set(int: Int, forKey key: String) {
      UserDefaults.standard.set(int, forKey: key)
      if CGiCloud.iCloudSyncEnabled {
         NSUbiquitousKeyValueStore.default.set(Int64(int), forKey: key)
         NSUbiquitousKeyValueStore.default.synchronize()
      }
   }
   
   @objc public static func set(double: Double, forKey key: String) {
      UserDefaults.standard.set(double, forKey: key)
      if CGiCloud.iCloudSyncEnabled {
         NSUbiquitousKeyValueStore.default.set(double, forKey: key)
         NSUbiquitousKeyValueStore.default.synchronize()
      }
   }
   
   @objc public static func set(dict: [String: Any], forKey key: String) {
      UserDefaults.standard.set(dict, forKey: key)
      if CGiCloud.iCloudSyncEnabled {
         NSUbiquitousKeyValueStore.default.set(dict, forKey: key)
         NSUbiquitousKeyValueStore.default.synchronize()
      }
   }
   
   @objc public static func set(array: [Any], forKey key: String) {
      UserDefaults.standard.set(array, forKey: key)
      if CGiCloud.iCloudSyncEnabled {
         NSUbiquitousKeyValueStore.default.set(array, forKey: key)
         NSUbiquitousKeyValueStore.default.synchronize()
      }
   }
   
   @objc public static func bool(forKey key: String) -> Bool {
      if CGiCloud.iCloudSyncEnabled {
         return NSUbiquitousKeyValueStore.default.bool(forKey: key)
      }
      else {
         return UserDefaults.standard.bool(forKey: key)
      }
   }
   
   @objc public static func string(forKey key: String) -> String? {
      if CGiCloud.iCloudSyncEnabled {
         return NSUbiquitousKeyValueStore.default.string(forKey: key)
      }
      else {
         return UserDefaults.standard.string(forKey: key)
      }
   }
   
   @objc public static func int(forKey key: String) -> Int {
      if CGiCloud.iCloudSyncEnabled {
         return Int(NSUbiquitousKeyValueStore.default.longLong(forKey: key))
      }
      else {
         return UserDefaults.standard.integer(forKey: key)
      }
   }
   
   @objc public static func double(forKey key: String) -> Double {
      if CGiCloud.iCloudSyncEnabled {
         return NSUbiquitousKeyValueStore.default.double(forKey: key)
      }
      else {
         return UserDefaults.standard.double(forKey: key)
      }
   }
   
   @objc public static func dict(forKey key: String) -> [String : Any]? {
      if CGiCloud.iCloudSyncEnabled {
         return NSUbiquitousKeyValueStore.default.dictionary(forKey: key)
      }
      else {
         return UserDefaults.standard.dictionary(forKey: key)
      }
   }
   
   @objc public static func array(forKey key: String) -> [Any]? {
      if CGiCloud.iCloudSyncEnabled {
         return NSUbiquitousKeyValueStore.default.array(forKey: key)
      }
      else {
         return UserDefaults.standard.array(forKey: key)
      }
   }
   
   @objc public static func syncFromCloud(keys: [String]) {
      for key in keys {
         UserDefaults.standard.set(NSUbiquitousKeyValueStore.default.object(forKey: key), forKey: key)
      }
   }
   
   @objc public static func syncToCloud(keys: [String]) {
      for key in keys {
         NSUbiquitousKeyValueStore.default.set(UserDefaults.standard.object(forKey: key), forKey: key)
      }
   }
}
