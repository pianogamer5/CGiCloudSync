//
//  CGCloudKit.swift
//  CGiCloudSync
//
//  Created by Greene, Carson on 8/19/19.
//  Copyright © 2019 Techsmith. All rights reserved.
//

import Foundation
import CloudKit

public class CGCloudKit {
   
   static let privateDB = CKContainer.default().privateCloudDatabase
   
   public static func saveFile(file: Data, withName name: String, toLocalPath localPath: URL) {
      do {
         FileManager.default.createFile(atPath: localPath.path, contents: file, attributes: nil)
         try file.write(to: localPath)
      }
      catch {
         print(error.localizedDescription)
      }
      if CGiCloud.iCloudSyncEnabled {
         let recordToSave = CKRecord(recordType: "File", recordID: CKRecord.ID(recordName: name))
         let fileAsset = CKAsset(fileURL: localPath)
         
         recordToSave["file"] = fileAsset;
         recordToSave["name"] = name
         
         let modifyRecordsOp = CKModifyRecordsOperation(recordsToSave: [recordToSave], recordIDsToDelete: nil)
         modifyRecordsOp.savePolicy = .changedKeys
         modifyRecordsOp.database = privateDB
         modifyRecordsOp.start()
      }
   }
   
   public static func loadFile(withName name: String, fromLocalPath localPath: URL, callback: @escaping (Data) -> Void){
      var filePath: URL?
      
      if CGiCloud.iCloudSyncEnabled {
         privateDB.fetch(withRecordID: CKRecord.ID(recordName: name), completionHandler: {
            (record, error) in
            if let record = record {
               let fileAsset = record["file"] as! CKAsset
               record["name"] = name
               filePath = fileAsset.fileURL
            }
            
            do {
               let data = try Data(contentsOf: filePath ?? localPath)
               callback(data)
            }
            catch {
               return
            }
         })
      }
   }
   
   public static func subscribeToChanges(forFile fileName: String) {
      let recordType = "File"
      let predicate = NSPredicate(format: "name == %@", fileName)
      let subOptions = CKQuerySubscription.Options(arrayLiteral: [.firesOnRecordCreation,.firesOnRecordUpdate])
      
      let subscription = CKQuerySubscription(recordType: recordType, predicate: predicate, options: subOptions)
      subscription.notificationInfo = CKSubscription.NotificationInfo()
      
      privateDB.save(subscription, completionHandler: {
      (subscription, error) in
         if let error = error {
            print(error.localizedDescription)
         }
      })
   }
}
