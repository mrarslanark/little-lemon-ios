//
//  NavigationBar.swift
//  Little Lemon
//
//  Created by Arslan Mushtaq on 3/4/23.
//

import SwiftUI

struct NavigationBar: View {
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
            
        }
        .padding([.top, .bottom])
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
    }
}
