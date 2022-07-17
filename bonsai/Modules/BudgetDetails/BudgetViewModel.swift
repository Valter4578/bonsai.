//
//  BudgetViewModel.swift
//  bonsai
//
//  Created by antuan.khoanh on 17/07/2022.
//

import Foundation

protocol BudgetViewModelProtocol {
   var totalBudget: NSDecimalNumber { get }
   var totalMoneyLeft: NSDecimalNumber { get }
   var totalMoneySpent: NSDecimalNumber { get }
   var budgetDaily: NSDecimalNumber { get }
   var transactions: [Transaction] { get }
}

struct BudgetViewModel: BudgetViewModelProtocol {
   
   private let budgetService: BudgetCalculationServiceProtocol
   public private(set) var transactions: [Transaction] = []
   
   init(budgetService: BudgetServiceProtocol, transactions: [Transaction]) {
      self.budgetService = budgetService
      self.transactions = transactions
      /*
       for manual test
       1 delete app from simulator and uncomment createBudget()
       2 create some transactions
       */
//      budgetService.createBudget(name: "Tailand", with: 9000, on: 30)
   }
   
   private var transactionsAmounts: [NSDecimalNumber] {
      transactions.map { $0.amount }
   }
   
   var totalBudget: NSDecimalNumber {
      budgetService.getTotalBudget() ?? 0
   }
   
   var totalMoneyLeft: NSDecimalNumber {
      budgetService.getTotalMoneyLeft(with: transactionsAmounts) ?? 0
   }
   
   var totalMoneySpent: NSDecimalNumber {
      budgetService.getTotalMoneySpent(with: transactionsAmounts) ?? 0
   }
   
   var budgetDaily: NSDecimalNumber {
      budgetService.getMoneyCanSpendDaily(with: transactionsAmounts) ?? 0
   }
}
