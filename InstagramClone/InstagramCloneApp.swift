//
//  InstagramCloneApp.swift
//  InstagramClone
//
//  Created by Elvis on 11/08/2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

@main
struct InstagramCloneApp: App {
    let photoLibraryService = PhotoLibraryService()
    
    init() {
        FirebaseApp.configure()
        #if EMULATORS
        print(
            """
            *************************************
            Testing on Emulators
            *************************************
            """
        )
        Auth.auth().useEmulator(withHost:"127.0.0.1", port:9099)
        Storage.storage().useEmulator(withHost:"127.0.0.1", port:9199)
        let settings = Firestore.firestore().settings
        settings.host = "127.0.0.1:8080"
        settings.isPersistenceEnabled = false
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
        #elseif DEBUG
        print(
            """
            *************************************
            Testing on Live Server
            *************************************
            """
        )
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(photoLibraryService)
        }
    }
}
