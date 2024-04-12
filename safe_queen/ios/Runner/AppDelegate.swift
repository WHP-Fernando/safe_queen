import UIKit
import Flutter
import MessageUI

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "platform_service", binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if (call.method == "sendSMSAlert") {
                if let arguments = call.arguments as? Dictionary<String, Any>,
                    let phoneNumber = arguments["phoneNumber"] as? String,
                    let message = arguments["message"] as? String {
                    self.sendSMSAlert(phoneNumber: phoneNumber, message: message, result: result)
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        })
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func sendSMSAlert(phoneNumber: String, message: String, result: @escaping FlutterResult) {
        if MFMessageComposeViewController.canSendText() {
            let composeVC = MFMessageComposeViewController()
            composeVC.messageComposeDelegate = self
            composeVC.recipients = [phoneNumber]
            composeVC.body = message
            UIApplication.shared.keyWindow?.rootViewController?.present(composeVC, animated: true, completion: nil)
            result(nil)
        } else {
            result(FlutterError(code: "SMS_NOT_AVAILABLE", message: "SMS functionality is not available", details: nil))
        }
    }
}

extension AppDelegate: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
