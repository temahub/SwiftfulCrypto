//
//  LocalFileManager.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 5/1/25.
//

import Foundation
import SwiftUI

final class LocalFileManager {
  static let instance = LocalFileManager()
  
  private init() { }
  
  func saveImage(image: UIImage, folderName: String, imageName: String) {
    // create folder if not exist yet
    createFolderIfNeeded(folderName: folderName)
    
    // get path for image
    guard let data = image.pngData(),
          let url = getURLForImage(folderName: folderName, imageName: imageName)
    else { return }
    
    // save image to path
    do {
      try data.write(to: url )
    } catch let error {
      print("Error save image \(imageName)\nError:\n\(error)")
    }
  }
  
  func getImage(imageName: String, foldername: String) -> UIImage? {
    guard let url = getURLForImage(folderName: foldername, imageName: imageName),
          FileManager.default.fileExists(atPath: url.path())  // used new version of .path(percentEncoded: true), old .path deprecated
    else { return nil}
    
    return UIImage(contentsOfFile: url.path())  // used new version of .path(percentEncoded: true), old .path deprecated
  }
  
  private func createFolderIfNeeded(folderName: String) {
    guard let url = getURLForFolder(folderName: folderName) else { return }
    if !FileManager.default.fileExists(atPath: url.path()) {  // used new version of .path(percentEncoded: true), old .path deprecated
      do {
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
      } catch let error {
        print("Error creating directory \(folderName)\nError:\n\(error)")
      }
    }
  }
  
  private func getURLForFolder(folderName: String) -> URL? {
    guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    else { return nil }
    
    return url.appendingPathComponent(folderName)
  }
  
  private func getURLForImage(folderName: String, imageName: String) -> URL? {
    guard let folderURL = getURLForFolder(folderName: folderName)
    else { return nil }
    
    return folderURL.appendingPathComponent(imageName + ".png")
  }
}
