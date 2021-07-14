//
//  SwiftUIView.swift
//  ASoulZhiWang_iOS
//
//  Created by YES on 2021/7/13.
//

import SwiftUI

struct HomeTabView: View {
    
    @State var selectedTab: TabSelection = .page1
    
    var body: some View {
        TabView(selection: $selectedTab){
            HomeView()
                .tabItem {
                    Image(systemName: "a.square")
                    Text("Main")
                }
                .tag(TabSelection.page1)
            
            Text("Soul")
                .tabItem {
                    Image(systemName: "s.square")
                    Text("Other")
                }
                .tag(TabSelection.page2)
            
        }
    }
}

enum TabSelection {
    case page1
    case page2
    case page3
    case page4
    case page5
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
