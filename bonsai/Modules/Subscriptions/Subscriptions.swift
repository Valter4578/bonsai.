//
//  Subscriptions.swift
//  bonsai
//
//  Created by antuan.khoanh on 06/08/2022.
//

import SwiftUI
import RevenueCat

struct Subscriptions: View {
    @State var isShowActivityIndicator = false
    @State var id: String = ""
    @State var isFeaturePremiumPresented: Bool = false
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var purchaseService: PurchaseService
    let completion: (() -> Void)?

    
    var packages: [Package] {
        purchaseService.packages
    }
    
    var subscriptions: [Subscription] {
        packages
            .compactMap { Subscription(package: $0, firstMonthPrice: packages.firstMonthPrice) }
            .sorted(by: { $1.discount < $0.discount })
    }
    
    var selectedSubscription: Subscription? {
        if let selectedPackage {
            return Subscription(
                package: selectedPackage,
                firstMonthPrice: packages.firstMonthPrice
            )
        }
        return nil
    }
    
    private var selectedPackage: Package? {
        packages
            .first(where: {
                id.isEmpty ?
                $0.storeProduct.subscriptionPeriod?.unit == .year :
                $0.storeProduct.productIdentifier == id
            })
    }
    
    init(completion: (() -> Void)?) {
        UINavigationBar.changeAppearance(clear: true)
        self.completion = completion
    }
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: $isShowActivityIndicator) {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    VStack(spacing: 8) {
                        ScrollView(showsIndicators: false) {
                            ScrollViewReader { value in
                                gifView()
                                    .padding(.bottom, 12)
                                
                                planDescription()
                                    .padding(.bottom, 12)
                                
                                ForEach(subscriptions, id: \.id) { subscription in
                                    SubscriptionCell(subscription: subscription, id: id)
                                        .onTapGesture { id = subscription.id }
                                        .id(subscription.id)
                                }
                                .padding(.horizontal)
                                .onChange(of: packages, perform: { newValue in
                                    if newValue.isEmpty == false {
                                        value.scrollTo(subscriptions.last?.id)
                                    }
                                })
                                .onAppear {
                                    if packages.isEmpty == false {
                                        value.scrollTo(subscriptions.last?.id)
                                    }
                                }
                            }
                        }
                        .ignoresSafeArea()
                        
                        if let selectedSubscription {
                            dueInfo(
                                price: selectedSubscription.fullPrice,
                                trialPrice: selectedSubscription.trialPrice,
                                daysFree: 7
                            )
                            .padding([.bottom], 8)
                            .padding(.horizontal)
                        }
                        continueButton()
                            .padding([.bottom], 8)
                        
                        textGroup()
                            .padding(.horizontal)
                            .padding([.bottom], 8)
                        
                        restorePurchase()
                            .padding(.horizontal)
                    }
                }
            }
            .popover(isPresented: $isFeaturePremiumPresented) {
                PremiumFeature(isPresented: $isFeaturePremiumPresented, isPresentedFromSubscription: .constant(true))
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text(LocalizedStringKey("Cancel_title"))
                            .foregroundColor(BonsaiColor.secondary)
                    }
                }
            }
        }
    }
    
    private func restorePurchase() -> some View {
        HStack(alignment: .center) {
            Spacer()
            Text(LocalizedStringKey("Restore_Purchases"))
                .font(.system(size: 14))
                .foregroundColor(BonsaiColor.secondary)
                .onTapGesture {
                    isShowActivityIndicator = true
                    purchaseService.restorePurchase {
                        isShowActivityIndicator = false
                        dismiss()
                        completion?()
                    }
                }
            Spacer()
        }
    }
    
    private func dueInfo(
        price: String,
        trialPrice: String,
        daysFree: Int
    ) -> some View {
        VStack(spacing: 4) {
            HStack(spacing: 0) {
                Text({ () -> String in
                    var text = L.due
                    let date = Date().addingTimeInterval(TimeInterval(daysFree * 24 * 60 * 60))
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd MMMM yyyy"
                    text.append(" ")
                    text.append(formatter.string(from: date))
                    return text
                }())
                Spacer()
                Text(price)
            }
            .font(.system(size: 14))
            .foregroundColor(.white)
            .opacity(0.7)
            HStack(spacing: 0) {
                Text(LocalizedStringKey("Due_Today"))
                Text(" ")
                Text(L.daysFree(daysFree))
                    .foregroundColor(BonsaiColor.green)
                Spacer()
                Text(trialPrice)
            }
            .font(.system(size: 14, weight: .medium))
        }
    }
    
    private func gifView() -> some View {
        HStack {
            ZStack {
                GifImage("6666")
                    .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.width / 2)
            }
        }
    }
    
    private func continueButton() -> some View {
        Button {
            isShowActivityIndicator = true
            purchaseService.buy(package: selectedPackage, completion: {
                isShowActivityIndicator = false 
                dismiss()
                completion?()
            })
        } label: {
            Text(LocalizedStringKey("Try_for_free"))
                .foregroundColor(BonsaiColor.card)
                .font(.system(size: 17))
                .bold()
        }
        .foregroundColor(BonsaiColor.mainPurple)
        .buttonStyle(PrimaryButtonStyle())
    }
    
    private func planDescription() -> some View {
        HStack(alignment: .center) {
            Spacer()
            VStack(alignment: .center) {
                Text(LocalizedStringKey("Choose_your_plan"))
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(BonsaiColor.purple6)
                
                Text(LocalizedStringKey("premium_planDescription"))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .foregroundColor(BonsaiColor.purple6)
                    .padding(.top, -2)
                    .padding(.horizontal)
                let learnMore = Text(LocalizedStringKey("Learn_more"))
                    .bold()
                    .foregroundColor(BonsaiColor.blueLight)
                    .shimmering(duration: 2.5)
                
                learnMore.onTapGesture {
                    isFeaturePremiumPresented = true
                }
            }
            Spacer()
        }
    }
    
    private func textGroup() -> some View {
        let termsOfServiceUrl = "https://www.craft.do/s/nk6c7jUpWgPhQg"
        let termsOfServicelink = "[\(L.termsOfService)](\(termsOfServiceUrl))"
        
        let privacyPolicyUrl = "https://www.craft.do/s/H8euwSq2jDDABJ"
        let privacyPolicylink = "[\(L.privacyPolicy)](\(privacyPolicyUrl))"
        
        let text =
        Text(LocalizedStringKey("Subscription_description_1")) +
        Text("\n") +
        Text(LocalizedStringKey("Subscription_description")) +
        Text(.init(termsOfServicelink)).foregroundColor(BonsaiColor.secondary).bold() +
        Text(LocalizedStringKey("Merge_And")) +
        Text(.init(privacyPolicylink))
            .foregroundColor(BonsaiColor.secondary).bold() +
        Text(".")
        
        return text
            .font(BonsaiFont.caption_12)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
    }
    
}


struct Subscriptions_Previews: PreviewProvider {
    static var previews: some View {
        Subscriptions(completion: {})
            .environmentObject(PurchaseService())
    }
}


