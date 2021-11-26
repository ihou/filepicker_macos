import Cocoa
import FlutterMacOS

public class FilepickerMacosPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "filepicker_macos", binaryMessenger: registrar.messenger)
        let instance = FilepickerMacosPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "pick":
            let args = call.arguments as? Dictionary<String, Any>
            let prompt = args?["prompt"] as? String
            let message = args?["message"] as? String
            let directoryURL = args?["directoryURL"] as? String
            let allowedFileTypes = args?["allowedFileTypes"] as? Array<String>
            let canChooseDirectories = args?["canChooseDirectories"] as? Bool
            let canChooseFiles = args?["canChooseFiles"] as? Bool
            let canCreateDirectories = args?["canCreateDirectories"] as? Bool
            let allowsMultipleSelection = args?["allowsMultipleSelection"] as? Bool
            self.pick(prompt: prompt,
                      message: message,
                      directoryURL: directoryURL,
                      allowedFileTypes: allowedFileTypes,
                      canChooseDirectories:canChooseDirectories,
                      canChooseFiles:canChooseFiles,
                      canCreateDirectories:canCreateDirectories,
                      allowsMultipleSelection: allowsMultipleSelection) { (array) in
                result(array)
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func pick(prompt:String?,
              message:String?,
              directoryURL:String?,
              allowedFileTypes:Array<String>?,
              canChooseDirectories:Bool?,
              canChooseFiles:Bool?,
              canCreateDirectories:Bool?,
              allowsMultipleSelection:Bool?,
              callback:@escaping (Array<String>)->()){
        let openPanel = NSOpenPanel()
        let window = NSApplication.shared.mainWindow
        openPanel.prompt = prompt
        openPanel.message = message
        openPanel.directoryURL = URL.init(string: directoryURL ?? NSHomeDirectory());
        openPanel.allowedFileTypes = allowedFileTypes
        openPanel.canChooseDirectories = canChooseDirectories ?? true
        openPanel.canChooseFiles = canChooseFiles ?? true
        openPanel.canCreateDirectories = canCreateDirectories ?? true
        openPanel.allowsMultipleSelection = allowsMultipleSelection ?? true
        openPanel.beginSheetModal(for: window!) { (modalResponse) in
            if (modalResponse == NSApplication.ModalResponse.OK) {
                let paths = openPanel.urls.map { (url) -> String in
                    url.path
                }
                callback(paths)
            }else  if (modalResponse == NSApplication.ModalResponse.cancel) {
                callback([])
            }
        }
    }
}
