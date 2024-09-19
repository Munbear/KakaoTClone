import SwiftUI
import KakaoMapsSDK
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {

    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        print(db)
        return true
    }
}


@main
struct KakaoTCloneApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var villageInfoViewModel: VillageTagViewModel {
        let repository = FirestoreService()
        let useCase =  VillageTagUseCase(repository: repository)
        return VillageTagViewModel(villageTahUseCase: useCase)
    }
    
    var feedViewModel: FeedViewModel {
//        let repository = FirestoreService()
        let repository = MockFeedService()
        let useCase = FeedUseCase(repository: repository)
        return FeedViewModel(feedUseCase: useCase)
    }
    
    
    init() {
        SDKInitializer.InitSDK(appKey: APIKeys.kakaoMapApiKey)
        print("카카오 맵 SDK 초기화 됨")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(feedViewModel: feedViewModel)
        }
    }
}
