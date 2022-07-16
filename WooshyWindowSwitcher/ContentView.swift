import SwiftUI


struct ContentView: View {

    @State private var selectedApplication: String = ""

    var body: some View {
        Form {
            Button("get list of visible windows through CoreGraphics") {
                let pids = AppCore.shared.visibleWindowThroughCG()
                
                
            }
            Button("do stuff") {
                let applicationNames = AppCore.shared.runningApplicationNames()
                print(applicationNames)
            }
        }
    }

}
