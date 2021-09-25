//
//  NetworkMonitor.swift
//  Colchugina_2memoryTest
//
//  Created by Ирина Кольчугина on 25.09.2021.
//

import Foundation
import Network

final class NetworkMonitor {
    //MARK: - Public properties
    static let shared = NetworkMonitor()
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown

    enum ConnectionType {
        case wifi
        case enthernet
        case cellular
        case unknown
    }

    //MARK: - Private properties
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor

    //MARK: - Private initialization
    private init() {
        monitor = NWPathMonitor()
    }

    //MARK: - Public methods
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
    }

    public func stopMonitoring() {
        monitor.cancel()
    }

    //MARK: - Private methods
    private func getConnectionType (_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        }
        else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        }
        else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .enthernet
        }
        else {
            connectionType = .unknown
        }
    }

}
