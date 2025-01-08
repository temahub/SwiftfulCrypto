//
//  StatisticView.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 7/1/25.
//

import SwiftUI

struct StatisticView: View {
  
  let stat: StatisticModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(stat.title)
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
      
      Text(stat.value)
        .font(.headline)
        .foregroundStyle(Color.theme.accent )
      
      
//      if let percentageChange = stat.percentageChange {
//        Text(percentageChange.asPercentString())
//      }
      HStack(spacing: 4) {
        Image(systemName: "triangle.fill")
          .font(.caption2)
          .rotationEffect(Angle(degrees:
                                  (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
        
        Text(stat.percentageChange?.asPercentString() ?? "")
          .font(.caption)
          .bold()
      }
      .foregroundStyle((stat.percentageChange ?? 0) >= 0 ?
                       Color.theme.green : Color.theme.red)
      .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  StatisticView(stat: MockStatisticModel.sample1StatisticModel)
    .preferredColorScheme(.light)
}

#Preview(traits: .sizeThatFitsLayout) {
  StatisticView(stat: MockStatisticModel.sample2StatisticModel)
    .preferredColorScheme(.dark)
}

#Preview(traits: .sizeThatFitsLayout) {
  StatisticView(stat: MockStatisticModel.sample3StatisticModel)
    .preferredColorScheme(.dark)
}
