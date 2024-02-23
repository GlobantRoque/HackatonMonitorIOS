//
//  MainView.swift
//  APIStatusMonitor
//
//  Created by Fidel Eduardo López Mayorga on 23/02/24.
//

import SwiftUI
import Combine

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        VStack {
            Text("Última actualización: \(viewModel.lastUpdated)")
            Text("Próxima actualización: \(viewModel.nextUpdate)")
            List(viewModel.endpoints) { endpoint in
                HStack {
                    Text(endpoint.name)
                    Spacer()
                    Circle()
                        .fill(endpoint.isActive ? Color.green : Color.red)
                        .frame(width: 10, height: 10)
                }
            }
        }
        .onAppear {
            self.viewModel.loadEndpoints()
        }
    }
}
