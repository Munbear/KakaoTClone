//
//  VillageTagUseCase.swift
//  KakaoTClone
//
//  Created by 박도원 on 9/14/24.
//

import Foundation


final class VillageTagUseCase {
    let repository: KakaoTRepositoryInterface
    
    init(repository: KakaoTRepositoryInterface) {
        self.repository = repository
    }
    
    func fetchVillageTagInfosTest() async throws -> [VillageTagEntity] {
        let villageTagInfos = try await repository.fetchVillageTagInfosTest()
        return villageTagInfos
    }
}
