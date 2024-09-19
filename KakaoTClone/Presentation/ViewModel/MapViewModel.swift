//
//  kakaoMapExample.swift
//  KakaoTClone
//
//  Created by 박도원 on 9/5/24.
//

import Foundation
import UIKit
import SwiftUI
import KakaoMapsSDK
import Combine


struct MapViewModel: UIViewRepresentable {
    @Binding var draw: Bool
    
    class KakaoMapCoordinator: NSObject, MapControllerDelegate {
        var controller: KMController?
        var first: Bool = true
        var cancellables = Set<AnyCancellable>()
        
        let enginReady = PassthroughSubject<Void, Never>() // 엔진 준비 상태를 나타내는 Publisher
        
        
        override init() {
            super.init()
            setupSubscriptions()
        }
        
        // KMController 객체 생성 및 이벤트 delegate 지정
        func createController(_ view: KMViewContainer) {
            controller = KMController(viewContainer: view)
            controller?.delegate = self
        }
        
        // Combine을 사용한 엔진 준비 구독 설정
        func setupSubscriptions() {
            enginReady
                .delay(for: .seconds(2), scheduler: RunLoop.main)
                .sink { [weak self] in
                    self?.controller?.prepareEngine()
                    print("엔진 준비 완료")
                    self?.controller?.activateEngine()
                }
                .store(in: &cancellables)
        }
        
        // KMControllerDelegate Protocol method 구현
        func addViews() {
            let defaultPosition = MapPoint(longitude: 126.901915, latitude: 37.533992)
            let mapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition, defaultLevel: 15)
//            createLabelLayer()
            
            
            controller?.addView(mapviewInfo)
        }
        
        func addViewSucceeded(_ viewName: String, viewInfoName: String) {
            print("뷰 추가 성공")

        }
        
        // 포인터 생성하기
        func createLabelLayer() {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layerOption = LabelLayerOptions(layerID: "PoiLayer", competitionType: .none, competitionUnit: .symbolFirst, orderType: .rank, zOrder: 0)
            let _ = manager.addLabelLayer(option: layerOption)
            
        }
        
        func createPoiStyle() {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            
            // PoiBadge는 스타일에도 추가될 수 있다. 이렇게 추가된 Badge는 해당 스타일이 적용될 때 함께 그려진다.
//            let noti1 = PoiBadge(badgeID: "badge1", image: UIImage(named: "noti.png"), offset: CGPoint(x: 0.9, y: 0.1), zOrder: 0)
            let iconStyle1 = PoiIconStyle(symbol: UIImage(named: "pin_green.png"), anchorPoint: CGPoint(x: 0.0, y: 0.5))
//            let noti2 = PoiBadge(badgeID: "badge2", image: UIImage(named: "noti2.png"), offset: CGPoint(x: 0.9, y: 0.1), zOrder: 0)
            let iconStyle2 = PoiIconStyle(symbol: UIImage(named: "pin_red.png"), anchorPoint: CGPoint(x: 0.0, y: 0.5))
            
            // 5~11, 12~21 에 표출될 스타일을 지정한다.
            let poiStyle = PoiStyle(styleID: "PerLevelStyle", styles: [
                PerLevelPoiStyle(iconStyle: iconStyle1, level: 5),
                PerLevelPoiStyle(iconStyle: iconStyle2, level: 15)
            ])
            manager.addPoiStyle(poiStyle)
        }
        
        func createPois() {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layer = manager.getLabelLayer(layerID: "PoiLayer")
            let poiOption = PoiOptions(styleID: "PerLevelStyle")
            poiOption.rank = 0
            
            let poi1 = layer?.addPoi(option:poiOption, at: MapPoint(longitude: 126.901915, latitude: 37.533992))
            poi1?.show()
        }
          
        
        func addViewFailed(_ viewName: String, viewInfoName: String) {
            print("View 추가 실패")
        }
        
        func authenticationSucceeded() {
            print("인증 성공")
            enginReady.send() // 인증 성공 시 엔진 준비 트리거
        }
        
        func authenticationFailed(_ errorCode: Int, desc: String) {
            print("인증 실패")
            print("에러 코드: \(errorCode)")
            print(desc)
        }
        
        func containerDidResized(_ size: CGSize) {
            let mapView: KakaoMap? = controller?.getView("mapview") as? KakaoMap
            mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
            
            if first {
                let cameraUpdate = CameraUpdate.make(
                    target: MapPoint(longitude: 14135167.020272, latitude: 4518393.389136),
                    zoomLevel: 10,
                    mapView: mapView!
                )
                mapView?.moveCamera(cameraUpdate)
                first = false
            }
        }
    }
    
    /// UIView를 상속한 KMViewContainer를 생성한다.
    func makeUIView(context: Self.Context) -> KMViewContainer {
        let view: KMViewContainer = KMViewContainer()
        view.sizeToFit()
        context.coordinator.createController(view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            context.coordinator.authenticationSucceeded()
        }
        
        return view
    }
    
    func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
        if draw {
            context.coordinator.controller?.activateEngine()
            print("엔진 활성화")
        } else {
            context.coordinator.controller?.resetEngine()
            print("엔진 비활성화")
        }
    }
    
    /// Coordinator 생성
    func makeCoordinator() -> KakaoMapCoordinator {
        return KakaoMapCoordinator()
    }
    
    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
        // 리소스 해제 (필요시)
        coordinator.cancellables.removeAll()
    }
    
}




