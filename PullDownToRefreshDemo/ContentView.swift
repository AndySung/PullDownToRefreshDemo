//
//  ContentView.swift
//  PullDownToRefreshDemo
//
//  Created by Andy on 2022/8/30.
//

import SwiftUI
import BBSwiftUIKit

struct ContentView: View {
    @State var list: [Int] = (0..<50).map{$0}
    @State var isRefereshing: Bool = false
    @State var isLoadingMore: Bool = false

    var body: some View {
        BBTableView(list) { i in
            Text("Text \(i)")
                .padding()
                .background(Color.blue)
        }
        .bb_setupRefreshControl({ control in
            control.tintColor = .red
            control.attributedTitle = NSAttributedString(string: "加载中...", attributes: [.foregroundColor: UIColor.red])
        })
        .bb_pullDownToRefresh(isRefreshing: $isRefereshing) {
            print("Refresh")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.list = (0..<50).map{$0}
                self.isRefereshing = false
            }
        }
        .bb_pullUpToLoadMore(bottomSpace: 30) {
            if self.isLoadingMore || self.list.count >= 100 {return}
            self.isLoadingMore = true
            print("Loadmore")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let more = self.list.count..<self.list.count + 10
                self.list.append(contentsOf: more)
                self.isLoadingMore = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
