//
//  Subscriptions.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI

struct Subscriptions: View {
    
    @State var isSelected: Bool = false
    
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
                    .font(.system(size: 28))
                    .bold()
                    .foregroundColor(BonsaiColor.purple7)
                Spacer()
            }
            ForEach(0..<4) { index in
                /*
                 product subscription
                 */
                SubscriptionCell()
                    .padding(.bottom, 6)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        
                        /*
                         product subscription
                         update checkmark
                         unselect another 
                         */
                    }
            }
            
            Group {
                Text("By subscribing you agree to our ")
                +
                Text("Terms of Service ").foregroundColor(BonsaiColor.secondary) +
                Text("and ") +
                Text("Privacy Policy").foregroundColor(BonsaiColor.secondary) +
                Text(".")
            }
            .font(.system(size: 12))
            .lineLimit(3)
            .frame(height: 50)
            .listRowSeparator(.hidden)
            
            Button {
                
            } label: {
                HStack(alignment: .center) {
                    Text("Restore Purchases")
                        .font(.system(size: 12))
                        .foregroundColor(BonsaiColor.secondary)
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