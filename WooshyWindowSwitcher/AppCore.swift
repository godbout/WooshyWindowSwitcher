import AppKit


struct AppCore {
    
    static var shared = AppCore()
    
    private init() {}
    
    
    func runningApplicationNames() -> [String?] {
        NSWorkspace.shared.runningApplications.map { $0.localizedName }
    }
        
    func visibleWindowThroughCG() {
        guard let tooManyWindows = CGWindowListCopyWindowInfo([.optionOnScreenOnly, .excludeDesktopElements], kCGNullWindowID) as NSArray? else { return }
        guard let visibleWindows = tooManyWindows.filtered(using: NSPredicate(format: "kCGWindowLayer == 0 && kCGWindowAlpha != 0")) as NSArray? else { return }
        
        for window in visibleWindows {
            guard let window = window as? NSDictionary else { continue }
            
            print(window)
        }
    }

}
