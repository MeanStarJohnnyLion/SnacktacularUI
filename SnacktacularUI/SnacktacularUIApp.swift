//
//  SnacktacularUIApp.swift
//  SnacktacularUI
//
//  Created by Johnny Lion on 11/7/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct SnacktacularUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var spotVM = SpotViewModel()
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(spotVM)
        }
    }
}
