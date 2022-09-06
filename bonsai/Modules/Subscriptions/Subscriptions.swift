//
//  Subscriptions.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI
import RevenueCat

struct Subscriptions: View {
   
   @State var id: String = ""
    @State var showAllSet: Bool = false
    @Binding var isPresented: Bool

   @EnvironmentObject private var purchaseService: PurchaseService
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
      
   var body: some View {
      ZStack {
         BonsaiColor.back
            .ignoresSafeArea()
         List {
            HStack {
               Image("undraw_japan_ubgk 1")
                  .resizable()
                  .scaledToFill()
                  .clipped()
                  .padding([.leading, .trailing], 73)
            }
            .listRowBackground(BonsaiColor.back)
            .listRowSeparator(.hidden)
            .padding(.bottom, 12)
            .padding(.top, 20)
            HStack(alignment: .center) {
               Spacer()
               Text("Choose your plan")
                  .font(.system(size: 28))
                  .bold()
                  .foregroundColor(BonsaiColor.purple6)
               Spacer()
            }
            .listRowBackground(BonsaiColor.back)
            .padding(.bottom, 12)
            
            ForEach(Array(purchaseService.availablePackages.enumerated()), id: \.offset) { index, pkg in
               
               let storeProduct = pkg.storeProduct
               let productId = storeProduct.productIdentifier
               let periodName = storeProduct.subscriptionPeriod!.periodTitle
               let price = storeProduct.localizedPriceString
               let isMostPopular = storeProduct.subscriptionPeriod?.unit == .year
               
               let subscription = Subscription(
                  id: productId,
                  periodName: periodName,
                  price: price,
                  isMostPopular: isMostPopular)
               
               SubscriptionCell(
                  subscription: subscription, id: id)
               .listRowSeparator(.hidden)
               .onTapGesture {
                  id = pkg.storeProduct.productIdentifier
               }
            }
            .listRowBackground(BonsaiColor.back)
            
            let termsOfServiceUrl = "https://duckduckgo.com"
            let termsOfServicelink = "[Terms of Service](\(termsOfServiceUrl))"
            
            let privacyPolicyUrl = "https://duckduckgo.com"
            let privacyPolicylink = "[Privacy Policy](\(privacyPolicyUrl))"
            
            Group {
               Text("By subscribing you agree to our ") +
               Text(.init(termsOfServicelink)).foregroundColor(BonsaiColor.secondary) +
               Text(" and ") +
               Text(.init(privacyPolicylink)).foregroundColor(BonsaiColor.secondary) +
               Text(".")
            }
            .font(.system(size: 12))
            .lineLimit(3)
            .listRowSeparator(.hidden)
            .listRowBackground(BonsaiColor.back)
            
            Button {
               
            } label: {
               HStack(alignment: .center) {
                  Text("Restore Purchases")
                     .font(.system(size: 12))
                     .foregroundColor(BonsaiColor.secondary)
                     .onTapGesture {
                        purchaseService.restorePurchase()
                     }
                  Spacer()
               }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(BonsaiColor.back)
            
            HStack(alignment: .center) {
               Spacer()
               ZStack {
                  RoundedRectangle(cornerRadius: 13)
                     .frame(width: 192, height: 48)
                     .foregroundColor(BonsaiColor.mainPurple)
                     .onTapGesture {
                        
                        let package = purchaseService
                           .availablePackages
                           .first(where: {
                              id.isEmpty ?
                              $0.storeProduct.subscriptionPeriod?.unit == .year :
                              $0.storeProduct.productIdentifier == id
                           })

                         purchaseService.buy(package: package, completion: {
                             
                             showAllSet = true
                             
                             DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                 showAllSet = false
                                 isPresented = false
                             }
                         })
                     }
                  Text("Try for free")
                     .foregroundColor(BonsaiColor.card)
                     .font(.system(size: 17))
                     .bold()
               }
               Spacer()
            }
            .padding(.bottom, 30)
            .listRowSeparator(.hidden)
            .listRowBackground(BonsaiColor.back)
         }
         .onAppear {
            UITableView.appearance().showsVerticalScrollIndicator = false
         }
         .listStyle(PlainListStyle())
         .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
          
          AllSet()
              .offset(y: showAllSet ?
                      0 :
                    UIScreen.main.bounds.height)
              .animation(
                .interpolatingSpring(
                    mass: 1,
                    stiffness: 50,
                    damping: 10,
                    initialVelocity: 0
                ))
      }
   }
   
}


struct Subscriptions_Previews: PreviewProvider {
   static var previews: some View {
       Subscriptions(isPresented: .constant(false))
   }
}
