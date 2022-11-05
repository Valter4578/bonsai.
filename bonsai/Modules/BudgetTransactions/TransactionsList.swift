//
//  TransactionsList.swift
//  bonsai
//
//  Created by hoang on 08.12.2021.
//

import OrderedCollections
import SwiftUI

struct TransactionsList: View {

   enum kind { case all, budget }
   let kind: kind

   @FetchRequest(sortDescriptors: [SortDescriptor(\.date)])
   var transactions: FetchedResults<Transaction>

   @FetchRequest(sortDescriptors: [])
   private var budgets: FetchedResults<Budget>
   private var budget: Budget? { budgets.first }

   var allowedTransactions: any Sequence<Transaction> {
      switch self.kind {
      case .all:
         return transactions
      case .budget:
         if let budget {
            return transactions.onlyFromBudget(budget)
         }
         return transactions
      }
   }

   func sortedTransactions() -> OrderedDictionary<String, [Transaction]> {
      allowedTransactions
         .reduce(into: OrderedDictionary<String, [Transaction]>()) { partialResult, transaction in
            let date = transaction.date.dateString()
            if var arr = partialResult[date] {
               arr.append(transaction)
               partialResult[date] = arr
            } else {
               partialResult[date] = [transaction]
            }
         }
   }

   @Binding var isPresented: Bool
   @State var isTransactionDetailsPresented: Bool = false
   @State var selectedTransaction: Transaction?

   var body: some View {
      VStack(alignment: .leading) {
         BudgetTransactionHeader()
            .contentShape(Rectangle())
            .padding(.vertical)
         List {
            ForEach(sortedTransactions().elements, id: \.key) { element in
               Section(header: Text(element.key)
                  .font(BonsaiFont.body_15)
                  .foregroundColor(Color.white)
               ) {
                  ForEach(element.value) { transaction in
                     TransactionCell(model: .init(transaction: transaction))
                        .onTapGesture(perform: {
                           selectedTransaction = transaction
                           isTransactionDetailsPresented = true
                        })
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                  } // ForEach
               } // Section
            } // ForEach
         } // ScrollView
      }
      .listStyle(.plain)
      .popover(isPresented: $isTransactionDetailsPresented) { [selectedTransaction] in
         OperationDetails(
            isPresented: $isTransactionDetailsPresented,
            transaction: selectedTransaction
         )
      }
   }
}

struct TransactionsList_Previews: PreviewProvider {
   static var previews: some View {
      TransactionsList(kind: .all, isPresented: .constant(true))
      .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
      .previewDisplayName("iPhone 12")
   }
}