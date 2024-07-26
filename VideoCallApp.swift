////
////  VideoCallApp.swift
////  VideoCall
////
////  Created by fasih zaidi on 26/07/2024.
////
//
//import SwiftUI
//import StreamVideo
//import StreamVideoSwiftUI
//
//@main
//struct VideoCallApp: App {
//    @State var call: Call
//    @ObservedObject var state: CallState
//    @State var callCreated: Bool = false
//
//    private var client: StreamVideo
//
//    private let apiKey: String = "mmhfdzb5evj2"
//    private let token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiTm9tX0Fub3IiLCJpc3MiOiJodHRwczovL3Byb250by5nZXRzdHJlYW0uaW8iLCJzdWIiOiJ1c2VyL05vbV9Bbm9yIiwiaWF0IjoxNzIxOTcwMjM4LCJleHAiOjE3MjI1NzUwNDN9.oFvFNFZ3y8OxgP81X34jrrhV2z2CHHp6zsxqW1X4yhs"
//    private let userId: String = "Nom_Anor"
//    private let callId: String = "iUdRLi67lQKc"
//
//    init() {
//        let user = User(
//            id: userId,
//            name: "Martin", // name and imageURL are used in the UI
//            imageURL: .init(string: "https://getstream.io/static/2796a305dd07651fcceb4721a94f4505/a3911/martin-mitrevski.webp")
//        )
//
//        // Initialize Stream Video client
//        self.client = StreamVideo(
//            apiKey: apiKey,
//            user: user,
//            token: .init(stringLiteral: token)
//        )
//
//        // Initialize the call object
//        let call = client.call(callType: "default", callId: callId)
//
//        self.call = call
//        self.state = call.state
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            VStack {
//                if callCreated {
//                    ZStack {
//                        ParticipantsView(
//                            call: call,
//                            participants: call.state.remoteParticipants,
//                            onChangeTrackVisibility: changeTrackVisibility(_:isVisible:)
//                        )
//                        FloatingParticipantView(participant: call.state.localParticipant)
//                    }
//                } else {
//                    Text("loading...")
//                }
//            }.onAppear {
//                Task {
//                    guard callCreated == false else { return }
//                    try await call.join(create: true)
//                    callCreated = true
//                }
//            }
//        }
//    }
//    private func changeTrackVisibility(_ participant: CallParticipant?, isVisible: Bool) {
//        guard let participant else { return }
//        Task {
//            await call.changeTrackVisibility(for: participant, isVisible: isVisible)
//        }
//    }
//}

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

import SwiftUI
import StreamVideo
import StreamVideoSwiftUI

@main
struct VideoCallApp: App {
    @ObservedObject var viewModel: CallViewModel

    private var client: StreamVideo

    private let apiKey: String = "mmhfdzb5evj2"
    private let token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiTm9tX0Fub3IiLCJpc3MiOiJodHRwczovL3Byb250by5nZXRzdHJlYW0uaW8iLCJzdWIiOiJ1c2VyL05vbV9Bbm9yIiwiaWF0IjoxNzIxOTcwMjM4LCJleHAiOjE3MjI1NzUwNDN9.oFvFNFZ3y8OxgP81X34jrrhV2z2CHHp6zsxqW1X4yhs"
    private let userId: String = "Nom_Anor"
    private let callId: String = "iUdRLi67lQKc"

    init() {
        let user = User(
            id: userId,
            name: "Martin", // name and imageURL are used in the UI
            imageURL: .init(string: "https://getstream.io/static/2796a305dd07651fcceb4721a94f4505/a3911/martin-mitrevski.webp")
        )

        // Initialize Stream Video client
        self.client = StreamVideo(
            apiKey: apiKey,
            user: user,
            token: .init(stringLiteral: token)
        )

        self.viewModel = .init()
    }

    var body: some Scene {
        WindowGroup {
            VStack {
                if viewModel.call != nil {
                    CallContainer(viewFactory: DefaultViewFactory.shared, viewModel: viewModel)
                } else {
                    Text("loading...")
                }
            }.onAppear {
                Task {
                    guard viewModel.call == nil else { return }
                    viewModel.joinCall(callType: .default, callId: callId)
                }
            }
        }
    }
}
