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

public class SmartSpeakerDetector: NSObject {
    private let serviceBrowser = NetServiceBrowser()
    private var castableDevices: [NetService] = []
    private var onDetect: ((Bool) -> Void)?
    private weak var timeoutTimer: Timer?
    
    public func detectGoogleHome(_ completion: @escaping (Bool) -> Void) {
        onDetect = completion
        serviceBrowser.delegate = self
        serviceBrowser.searchForServices(ofType: .googleService, inDomain: .localDomain)
        
        timeoutTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
            self?.noHomeDetected()
        }
    }
    
    public func stop(success: Bool) {
        serviceBrowser.stop()
        timeoutTimer?.invalidate()
        castableDevices = []
        onDetect?(success)
    }
    
    private func homeDetected() {
        stop(success: true)
    }
    
    private func noHomeDetected() {
        stop(success: false)
    }
}

extension SmartSpeakerDetector: NetServiceBrowserDelegate {
    public func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        castableDevices.append(service)
        service.delegate = self
        service.resolve(withTimeout: 5.0)
    }
    
    public func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        onDetect?(false)
    }
}

extension SmartSpeakerDetector: NetServiceDelegate {
    public func netServiceDidResolveAddress(_ sender: NetService) {
        if let txtRecord = sender.txtRecordData(), let record = String(data: txtRecord, encoding: .ascii), record.contains("Google Home") {
            homeDetected()
        }
        
        castableDevices = castableDevices.filter { $0 !== sender }
    }
    
    public func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        castableDevices = castableDevices.filter { $0 !== sender }
    }
}
