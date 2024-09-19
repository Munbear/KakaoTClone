//
//  MapView.swift
//  KakaoTClone
//
//  Created by 박도원 on 9/12/24.
//

import SwiftUI

struct MapView: View {
    @State var draw: Bool = true
    var body: some View {
        MapViewModel(draw: $draw).onAppear(perform: {
            self.draw = true
        }).onDisappear(perform: {
            self.draw = false
        }).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
    }

#Preview {
    MapView()
}
