import AppKit


struct AppCore {
    
    static var shared = AppCore()
    
//    private init() {}
    
    
    func runningApplicationNames() -> [String?] {
        NSWorkspace.shared.runningApplications.map { $0.localizedName }
    }
        
    func visibleWindowThroughCG() -> [pid_t] {
        var pids: [Int32] = []
        
        guard let tooManyWindows = CGWindowListCopyWindowInfo([.optionOnScreenOnly, .excludeDesktopElements], kCGNullWindowID) as NSArray? else { return [] }
        guard let visibleWindows = tooManyWindows.filtered(using: NSPredicate(format: "kCGWindowLayer == 0 && kCGWindowAlpha != 0")) as NSArray? else { return [] }
        
        for window in visibleWindows {
            guard let window = window as? NSDictionary else { continue }
            guard let pid = window.value(forKey: "kCGWindowOwnerPID") as? pid_t else { continue }
                   
            pids.append(pid)
        }
        
        print(pids.count)
        
        for pid in pids {
            print(pid)
            let axApplication = AXUIElementCreateApplication(pid)
            
            var axWindows: AnyObject?
            let axError = AXUIElementCopyAttributeValue(axApplication, kAXWindowsAttribute as CFString, &axWindows)
            
            print(axError.rawValue)
            
            let windows = axWindows as! [AXUIElement]
                    
            print(windows.count)
            for window in windows {
                print("hehe")
                guard AXUIElementPerformAction(window, kAXRaiseAction as CFString) == .success else { continue }
                print("hoho")
            }
            
        }
        
        return pids
    }

}
