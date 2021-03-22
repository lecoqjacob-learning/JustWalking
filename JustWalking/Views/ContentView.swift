//
//  ContentView.swift
//  JustWalking
//
//  Created by Jacob LeCoq on 3/21/21.
//

import HealthKit
import SwiftUI

struct ContentView: View {
    // MARK: - PRIVATE PROPERTIES

    @State private var steps = [Step]()
    private var healthStore: HealthStore?
    
    // MARK: - INITIALIZERS
    
    init() {
        self.healthStore = HealthStore()
    }
    
    // MARK: - PRIVATE FUNCS
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.sevenDaysAgo
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, _ in
            
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            
            self.steps.append(step)
        }
    }
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            GraphView(steps: steps)
//            List(self.steps, id: \.id) { step in
//                VStack(alignment: .leading){
//                    Text("\(step.count)")
//                    Text(step.date, style: .date)
//                        .opacity(0.5)
//                }
//            }
            .navigationTitle("Just Walking")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            if let healthStore = self.healthStore {
                healthStore.requestAuthorization { success in
                    if success {
                        healthStore.calculateSteps { statisticsCollection in
                            if let statisticsCollection = statisticsCollection {
                                updateUIFromStatistics(statisticsCollection)
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
