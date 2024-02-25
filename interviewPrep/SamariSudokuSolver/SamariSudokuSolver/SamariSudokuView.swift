//
//  ContentView.swift
//  SamariSudokuSolver
//
//  Created by Trevor Schmidt on 11/22/23.
//

import SwiftUI

struct SamariSudokuView: View {
    
    @State private var isSolving = false
    @State private var board = [
        [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
        [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1, 0, 0, 0, 0, 0, 0, 0, 0, 0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
    ]
    
    func valid(forSubSudoku sub: Int, _ r: Int, _ c: Int, _ num: Int) -> Bool {
        var r2 = 0
        var c2 = 0
        switch sub {
        case 0:
            r2 = 0
            c2 = 12
        case 1:
            r2 = 6
            c2 = 6
        case 2:
            r2 = 6
            c2 = 18
        case 3:
            r2 = 12
            c2 = 0
        case 4:
            r2 = 12
            c2 = 12
        case 5:
            r2 = 0
            c2 = 24
        case 6:
            r2 = 18
            c2 = 6
        case 7:
            r2 = 18
            c2 = 18
        case 8:
            r2 = 24
            c2 = 12
        default:
            break
        }
        
        let r = r
        let c = c
        
        // Check entire row/col
//        for i in 0..<9 {
//            if board[r][i] == num { return false }
//            if board[i][c] == num { return false }
//        }

        

        return true
    }
    
    func isValid(_ r: Int, _ c: Int, _ num: Int) -> Bool {
        
        // r1 and c1 mark the top left of the 3x3 grid
        let r1 = (r / 3) * 3
        let c1 = (c / 3) * 3
        
        for rowBox in 0..<3 {
            for colBox in 0..<3 {
                let row = r1 + rowBox
                let col = c1 + colBox
                if board[row][col] == num { return false }
            }
        }
        
        if r1 <= 1 {
            if 4 <= c1 && c1 <= 6 { if !valid(forSubSudoku: 0, r, c, num) { return false } }
        }
        if r1 == 2 {
            if 2 <= c1 && c1 <= 4 { if !valid(forSubSudoku: 1, r, c, num) { return false } }
            if 4 <= c1 && c1 <= 6 { if !valid(forSubSudoku: 0, r, c, num) { return false } }
            if 6 <= c1 && c1 <= 8 { if !valid(forSubSudoku: 2, r, c, num) { return false } }
        }
        if r1 == 3 {
            if 2 <= c1 && c1 <= 4 { if !valid(forSubSudoku: 1, r, c, num) { return false } }
            if 6 <= c1 && c1 <= 8 { if !valid(forSubSudoku: 2, r, c, num) { return false } }
        }
        if r1 == 4 {
            if 0 <= c1 && c1 <= 2 { if !valid(forSubSudoku: 3, r, c, num) { return false } }
            if 2 <= c1 && c1 <= 4 { if !valid(forSubSudoku: 1, r, c, num) { return false } }
            if 4 <= c1 && c1 <= 6 { if !valid(forSubSudoku: 4, r, c, num) { return false } }
            if 6 <= c1 && c1 <= 8 { if !valid(forSubSudoku: 2, r, c, num) { return false } }
            if 8 <= c1 && c1 <= 10 { if !valid(forSubSudoku: 5, r, c, num) { return false } }
        }
        if r1 == 5 {
            if 0 <= c1 && c1 <= 2 { if !valid(forSubSudoku: 3, r, c, num) { return false } }
            if 4 <= c1 && c1 <= 6 { if !valid(forSubSudoku: 4, r, c, num) { return false } }
            if 8 <= c1 && c1 <= 10 { if !valid(forSubSudoku: 5, r, c, num) { return false } }
        }
        if r1 == 6 {
            if 0 <= c1 && c1 <= 2 { if !valid(forSubSudoku: 3, r, c, num) { return false } }
            if 2 <= c1 && c1 <= 4 { if !valid(forSubSudoku: 6, r, c, num) { return false } }
            if 4 <= c1 && c1 <= 6 { if !valid(forSubSudoku: 4, r, c, num) { return false } }
            if 6 <= c1 && c1 <= 8 { if !valid(forSubSudoku: 7, r, c, num) { return false } }
            if 8 <= c1 && c1 <= 10 { if !valid(forSubSudoku: 5, r, c, num) { return false } }
        }
        if r1 == 7 {
            if 2 <= c1 && c1 <= 4 { if !valid(forSubSudoku: 6, r, c, num) { return false } }
            if 6 <= c1 && c1 <= 8 { if !valid(forSubSudoku: 7, r, c, num) { return false } }
        }
        if r1 == 8 {
            if 2 <= c1 && c1 <= 4 { if !valid(forSubSudoku: 1, r, c, num) { return false } }
            if 4 <= c1 && c1 <= 6 { if !valid(forSubSudoku: 8, r, c, num) { return false } }
            if 6 <= c1 && c1 <= 8 { if !valid(forSubSudoku: 7, r, c, num) { return false } }
        }
        if r1 >= 9 { if !valid(forSubSudoku: 8, r, c, num) { return false } }
        
        return true
    }

    /// -1 is you can't touch
    /// 0 is you need to update
    /// 1 - 9 is solved
    func solveSamariSudoku() {
        guard board.count == 33 && board[0].count == 33 else { return }
        
        @discardableResult
        func dfs() -> Bool {
            for r in 0..<board.count / 3 * 2 {
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
                ForEach(0..<33) { i in
                    GridRow {
                        ForEach(0..<33) { j in
                            Text("\(board[i][j] == -1 ? "." : "\(board[i][j])")")
                                .font(.caption)
                        }
                    }
                }
            }
        }
            .safeAreaInset(edge: .bottom) {
                if isSolving {
                    Button("Stop") {
                        isSolving.toggle()
                    }
                } else {
                    Button("Solve") {
                        DispatchQueue.global().async {
                            solveSamariSudoku()
                        }
                    }
                }
            }
    }
}

#Preview {
    SamariSudokuView()
}
