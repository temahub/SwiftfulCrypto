//
//  ChartView.swift
//  SwiftfulCrypto
//
//  Created by Artyom Jalilov on 7/2/25.
//

import SwiftUI

struct ChartView: View {
  private let data: [Double]
  private let maxY: Double
  private let minY: Double
  private let lineColor: Color
  private let startingDate: Date
  private let endingDate: Date
  @State private var percentage: CGFloat = 0
  
  init(coin: CoinModel) {
    self.data = coin.sparklineIn7D?.price ?? []
    self.maxY = data.max() ?? 0
    self.minY = data.min() ?? 0
    
    let priceChange = (data.last ?? 0) - (data.first ?? 0)
    self.lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
    
    endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
    startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60)
  }
  
  var body: some View {
    VStack {
      chartView
        .frame(height: 200)
        .background(chartBackground)
        .overlay(alignment: .leading) {
          chartYAxis
            .padding(.horizontal, 4)
        }
      chartDateLabel
        .padding(.horizontal, 4)
    }
    .font(.caption)
    .foregroundStyle(Color.theme.secondaryText)
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        withAnimation(.linear(duration: 2.0)) {
          percentage = 1.0
        }
      }
    }
  }
}

extension ChartView {
  private var chartView: some View {
    GeometryReader { geometry in
      // Create an array of points from your data.
      // Adjust the x-position calculation so that the first point starts at x = 0.
      let points: [CGPoint] = data.indices.map { index in
        // Using data.count - 1 so that the last point is at the full width.
        let xPosition = geometry.size.width / CGFloat(data.count - 1) * CGFloat(index)
        let yAxis = maxY - minY
        // Calculate the y-position so that higher data values are higher on the view.
        let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
        return CGPoint(x: xPosition, y: yPosition)
      }
      
      // If there are enough points, smooth them using Catmull-Rom interpolation.
      let interpolatedPoints = points.count >= 4 ? points.catmullRomInterpolated(segments: 10) : points
      
      // Draw the path using the interpolated points.
      Path { path in
        guard let firstPoint = interpolatedPoints.first else { return }
        path.move(to: firstPoint)
        
        for point in interpolatedPoints.dropFirst() {
          path.addLine(to: point)
        }
      }
      .trim(from: 0, to: percentage)
      .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
      // Add shadows as before.
      .shadow(color: lineColor.opacity(0), radius: 10, x: 0.0, y: 10)
      .shadow(color: lineColor.opacity(1), radius: 10, x: 0.0, y: 10)
      .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 10)
      .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 20)
      .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 30)
    }
  }
  
  
  private var chartBackground: some View {
    VStack {
      Divider()
      Spacer()
      Divider()
      Spacer()
      Divider()
    }
  }
  
  private var chartYAxis: some View {
    VStack(alignment: .leading) {
      Text(maxY.formattedWithAbbreviations())
      Spacer()
      Text(((maxY + minY) / 2).formattedWithAbbreviations())
      Spacer()
      Text(minY.formattedWithAbbreviations())
    }
  }
  
  private var chartDateLabel: some View {
    HStack {
      Text(startingDate.asShortDateString())
      Spacer()
      Text(endingDate.asShortDateString())
    }
  }
}

#Preview {
  ChartView(coin: MockCoinModel.sampleCoin)
}
