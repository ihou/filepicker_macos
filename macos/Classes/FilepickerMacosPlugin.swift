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
    case "pickFiles":
        pickFile { (array) in
            result(array)
        }
     
    case "pickDir":
        pickDir { (array) in
            result(array)
        }
    default:
      result(FlutterMethodNotImplemented)
    }
  }

    func pickFile(callback:@escaping (Array<String>)->()){
          let openPanel = NSOpenPanel()
          let window = NSApplication.shared.mainWindow
          openPanel.canChooseFiles = true
          openPanel.canChooseDirectories = true
          openPanel.canChooseFiles = true
          openPanel.canCreateDirectories = false
          openPanel.allowsOtherFileTypes = true
          openPanel.allowsMultipleSelection = true
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
 func pickDir(callback:@escaping (Array<String>)->()){
          let openPanel = NSOpenPanel()
          let window = NSApplication.shared.mainWindow
          openPanel.canChooseFiles = true
          openPanel.canChooseDirectories = true
          openPanel.canChooseFiles = false
          openPanel.canCreateDirectories = true
          openPanel.allowsOtherFileTypes = false
          openPanel.allowsMultipleSelection = false
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
