import Foundation
//import ARCoreCloudAnchors

// Listener that can be attached to hosing or resolving processes
protocol CloudAnchorListener {
    // Callback to invoke when cloud anchor task finishes
    func onCloudTaskComplete(anchorName: String?, anchor: String?)
}

// Class for handling logic regarding the Google Cloud Anchor API
class CloudAnchorHandler: NSObject {
    private var session: String
    private var pendingAnchors = [String: (String?, CloudAnchorListener?)]()
    
    init(session: String){
        self.session = session
    }
    
    func hostCloudAnchor(anchorName: String, anchor: String, listener: CloudAnchorListener?) {
        do {
            let newAnchor = ""//try self.session.hostCloudAnchor(anchor)
            // Register listener so it is invoked when the operation finishes
            pendingAnchors[newAnchor] = (anchorName, listener)
        } catch {
            print(error)
        }
    }
    
    func hostCloudAnchorWithTtl(anchorName: String, anchor: String, listener: CloudAnchorListener?, ttl: Int) {
        do {
            let newAnchor = ""//try self.session.hostCloudAnchor(anchor, ttlDays: ttl)
            // Register listener so it is invoked when the operation finishes
            pendingAnchors[newAnchor] = (anchorName, listener)
        } catch {
            print(error)
        }
    }
    
    func resolveCloudAnchor(anchorId: String, listener: CloudAnchorListener?) {
        do {
            let newAnchor = ""//try self.session.resolveCloudAnchor(anchorId)
            // Register listener so it is invoked when the operation finishes
            pendingAnchors[newAnchor] = (nil, listener)
        } catch {
            print(error)
        }
        
    }
        
    func session(_ session: String, didHost anchor: String) {
        pendingAnchors[anchor]?.1?.onCloudTaskComplete(anchorName: pendingAnchors[anchor]?.0, anchor: anchor)
    }
    
    func session(_ session: String, didFailToHost anchor: String) {
        pendingAnchors[anchor]?.1?.onCloudTaskComplete(anchorName: pendingAnchors[anchor]?.0, anchor: anchor)
    }
    
    func session(_ session: String, didResolve anchor: String) {
        pendingAnchors[anchor]?.1?.onCloudTaskComplete(anchorName: pendingAnchors[anchor]?.0, anchor: anchor)
    }
    
    func session(_ session: String, didFailToResolve anchor: String) {
        pendingAnchors[anchor]?.1?.onCloudTaskComplete(anchorName: pendingAnchors[anchor]?.0, anchor: anchor)
    }
    
    // Remove all listeners
    func clearListeners() {
        pendingAnchors.removeAll()
    }
}
