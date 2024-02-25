//
//  SamariSudokuSolverApp.swift
//  SamariSudokuSolver
//
//  Created by Trevor Schmidt on 11/22/23.
//

import SwiftUI

@main
struct SudokuSolverApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                SudokuSolverView()
                    .tabItem {
                        Label {
                            Text("Sudoku")
                        } icon: {
                            Image(systemName: "square.grid.2x2")
                        }
                    }
                SamariSudokuView()
                    .tabItem {
                        Label {
                            Text("Samari")
                        } icon: {
                            Image(systemName: "square.grid.3x3")
                        }
                    }
            }
        }
    }
}
