//
//  BudgetViewModelAssembler.swift
//  bonsai
//
//  Created by antuan.khoanh on 17/07/2022.
//

import Foundation
import CoreData

struct BudgetViewModelAssembler: Assembler {
   private var transactions: [Transaction] = []

   init(mainContext: NSManagedObjectContext = DataController.sharedInstance.container.viewContext) {
      let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
      do {
         let transactions = try mainContext.fetch(fetchRequest)
         self.transactions = transactions
      } catch {
         
      }
   }
   
   func assembly() -> BudgetViewModelProtocol {
      BudgetViewModel(
         budgetService: BudgetService(
            budgetRepository: BudgetRepository(),
            budgetCalculations: BudgetCalculations()),
         transactions: transactions)
   }
}