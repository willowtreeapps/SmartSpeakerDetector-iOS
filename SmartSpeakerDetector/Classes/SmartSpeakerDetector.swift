//
//  SmartSpeakerDetector.swift
//  SmartSpeakerDetectorSample
//
//  Created by Greg Niemann on 4/5/18.
//  Copyright © 2018 Willowtree Apps. All rights reserved.
//

import Foundation

private extension String {
    static let googleService = "_googlecast._tcp."
    static let localDomain = "local."
}

public protocol SmartSpeakerDetectorLogger: class {
    func log(event: String)
}

public class SmartSpeakerDetector: NSObject {
    private let serviceBrowser = NetServiceBrowser()
    private var castableDevices: [NetService] = []
    private var onDetect: ((Bool) -> Void)?
    private var netBrowsingFinished: Bool = false
    private weak var timeoutTimer: Timer?
    public weak var logger: SmartSpeakerDetectorLogger?
    
    public func detectGoogleHome(_ completion: @escaping (Bool) -> Void) {
        onDetect = completion
        serviceBrowser.delegate = self
        serviceBrowser.searchForServices(ofType: .googleService, inDomain: .localDomain)
        timeoutTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
            self?.noHomeDetected()
        }
        logger?.log(event: "Starting search for Google Home devices...")
    }
    
    public func stop(success: Bool) {
        serviceBrowser.stop()
        timeoutTimer?.invalidate()
        castableDevices = []
        onDetect?(success)
    }
    
    private func homeDetected() {
        stop(success: true)
        logger?.log(event: "Found Google Home device.")
    }
    
    private func noHomeDetected() {
        stop(success: false)
        logger?.log(event: "No Google Home devices detected.")
    }
}

extension SmartSpeakerDetector: NetServiceBrowserDelegate {
    public func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        castableDevices.append(service)
        service.delegate = self
        service.resolve(withTimeout: 5.0)
        netBrowsingFinished = !moreComing
        logger?.log(event: "Found service: \(service.name)")
    }
    
    public func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        onDetect?(false)
        logger?.log(event: "Error occured: \(errorDict.description)")
    }
}

extension SmartSpeakerDetector: NetServiceDelegate {
    public func netServiceDidResolveAddress(_ sender: NetService) {
        castableDevices = castableDevices.filter { $0 !== sender }
        if let txtRecord = sender.txtRecordData(), let record = String(data: txtRecord, encoding: .ascii), record.contains("Google Home") {
            homeDetected()
        } else if castableDevices.isEmpty && netBrowsingFinished {
            noHomeDetected()
        }
    }
    
    public func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        castableDevices = castableDevices.filter { $0 !== sender }
        logger?.log(event: "Failed to resolve service: \(errorDict.description)")
    }
}
