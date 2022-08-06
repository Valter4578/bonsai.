//
//  Subscriptions.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI

struct Subscriptions: View {
    var body: some View {
        List {
            HStack {
                Image("bonsai_4")
                    .resizable()
                    .scaledToFill()
                    .clipped()
            }
            .listRowSeparator(.hidden)
            HStack(alignment: .center) {
                Spacer()
                Text("Choose your plan")
                Spacer()
            }
            ForEach(0..<4) { index in
                SubscriptionCell()
                    .padding(.bottom, 6)
                    .listRowSeparator(.hidden)
            }
            Text("By subscribing you agree to our Terms of Service and Privacy Policy.")
                .lineLimit(3)
                .frame(height: 50)
                .listRowSeparator(.hidden)
            
            Button {
                
            } label: {
                HStack(alignment: .center) {
                    Text("Restore Purchases")
                    Spacer()
                }
            }
            .listRowSeparator(.hidden)
            
            HStack(alignment: .center) {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 13)
                        .frame(width: 192, height: 48)
                        .foregroundColor(BonsaiColor.mainPurple)
                    Text("Get all feutures")
                        .foregroundColor(BonsaiColor.card)
                        .font(.system(size: 17))
                        .bold()
                }
                Spacer()
            }
            .padding(.top, 35)
        }
        .ignoresSafeArea()
        .listStyle(GroupedListStyle())
        .listRowBackground(Color.clear)
        .onAppear {
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().backgroundColor = .clear
        }
    }
}

struct Subscriptions_Previews: PreviewProvider {
    static var previews: some View {
        Subscriptions()
    }
}
