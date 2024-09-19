import Foundation
import FirebaseFirestore

class FirestroeService: ObservableObject {
    @Published var areaInfoName = ""
    @Published var areaInfoList: [AreaInfoModel] = []
    
    final let db = Firestore.firestore()
    
    
    
    // 동네 테그 불러오기
    func fetchData() {
        let ref = db.collection("areaInfo").document("euZaEVN6Nswji75xdVHQ")
        ref.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("데이터: \(data)")
                    
                }
            }
        }
    }
    
    func getAreaData() async throws -> [AreaInfoModel] {
        let ref = db.collection("areaInfo")
        let snapshot = try await ref.getDocuments()
        let areaInfos: [AreaInfoModel] = snapshot.documents.compactMap { document in
            let data = document.data()
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                let areaInfo = try JSONDecoder().decode(AreaInfoModel.self, from: jsonData)
                print("데이터 2: \(areaInfo)")
                return areaInfo
            } catch {
                print("Decoding error: \(error)")
                return nil
            }
        }
        return areaInfos
    }
    
    init() {
        fetchData()
    }
}

