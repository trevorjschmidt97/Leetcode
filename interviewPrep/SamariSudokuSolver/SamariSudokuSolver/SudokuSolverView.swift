//
//  SudokuSolverView.swift
//  SamariSudokuSolver
//
//  Created by Trevor Schmidt on 11/23/23.
//

import SwiftUI

struct SudokuSolverView: View {
    
    @State private var board = [
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0]
    ]
    
    func isValid(_ r: Int, _ c: Int, _ num: Int) -> Bool {
        for i in 0..<9 {
            if board[r][i] == num { return false }
            if board[i][c] == num { return false }
        }

        for rowBox in 0..<3 {
            for colBox in 0..<3 {
                let row = r / 3 * 3 + rowBox
                let col = c / 3 * 3 + colBox
                if board[row][col] == num { return false }
            }
        }

        return true
    }
    
    func solveSudoku() {
        
        @discardableResult
        func dfs() -> Bool {
            for r in 0..<board.count{
                for c in 0..<board[r].count where board[r][c] == 0 {
                    for num in 1...9 where isValid(r, c, num) {
                        board[r][c] = num
                        if dfs() { return true }
                        else { board[r][c] = 0 }
                    }
                    return false
                }
            }
            return true
        }
        
        dfs()
    }
    
    var body: some View {
        ScrollView {
            Grid {
                ForEach(0..<9) { i in
                    GridRow {
                        ForEach(0..<9) { j in
                            Text("\(board[i][j] == -1 ? "." : "\(board[i][j])")")
                                .font(.caption)
                        }
                    }
                }
            }
        }
            .safeAreaInset(edge: .bottom) {
                Button("Solve") {
                    DispatchQueue.global().async {
                        solveSudoku()
                    }
                }
            }
    }
}

#Preview {
    SudokuSolverView()
}
