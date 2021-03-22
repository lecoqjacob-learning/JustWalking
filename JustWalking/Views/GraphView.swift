//
//  GraphView.swift
//  JustWalking
//
//  Created by Jacob LeCoq on 3/22/21.
//  
//

import SwiftUI

struct GraphView: View {
    // MARK: - PROPERTIES
    
    static let dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter
    }()

    let steps: [Step]
    
    var totalSteps: Int {
        self.steps.map { $0.count }.reduce(0,+)
    }
    
    // MARK: - BODY

    var body: some View {
        VStack {
            HStack(alignment: .lastTextBaseline){
                ForEach(steps, id: \.id) { step in
                    let yValue = Swift.min(step.count / 20, 300)
                    
                    VStack {
                        Text("\(step.count)")
                            .font(.caption)
                            .foregroundColor(.white)
                        Rectangle()
                            .fill(step.count > 10000 ? Color.green : Color.red)
                            .frame(width: 25, height: CGFloat(yValue))
                        
                        Text("\(step.date, formatter: Self.dateFormatter)")
                            .font(.caption)
                            .foregroundColor(.white)
                    } //: VSTACK
                } //: LOOP
            } //: HSTACK
            
            Text("Total Steps: \(totalSteps)")
                .padding(.top, 100)
                .foregroundColor(.white)
                .opacity(0.5)
        } //: VSTACK
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
        .cornerRadius(10)
        .padding(10)
    }
}

// MARK: - PREVIEW

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        let steps = [
            Step(count: 3456, date: Date()),
            Step(count: 1234, date: Date()),
            Step(count: 4252, date: Date()),
            Step(count: 100, date: Date()),
            Step(count: 606060, date: Date())
        ]
        
        return GraphView(steps: steps)
    }
}
