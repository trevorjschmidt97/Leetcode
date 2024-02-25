var memo: [Int: Int] = [:]

func fibonacci(_ i: Int) -> Int {
	if i <= 1 { return i }
	if memo[i] == nil {
		memo[i] = fibonacci(i - 1) + fibonacci(i - 2)
	}
	return memo[i]!
}

func minNumCoinsChange(_ coins: [Int], _ target: Int) -> Int {
	var numCoinsChange: [Int] = Array(repeating: target + 1, count: target + 1)
	numCoinsChange[0] = 0
	for i in 0...target {
		for coin in coins {
			let nextCoin = i + coin
			guard nextCoin <= target else { continue }
			numCoinsChange[nextCoin] = min(1 + numCoinsChange[i], numCoinsChange[nextCoin])		
		}
	}
	return (numCoinsChange[target] >= target + 1) ? -1 : numCoinsChange[target]
}

//print(minNumCoinsChange([2], 3))

func uniquePaths(_ m: Int, _ n: Int) -> Int {
	guard m > 1 && n > 1 else { return 1 }
	var grid = Array(repeating: Array(repeating: 0, count: n), count: m)

	for r in 0..<m {
		for c in 0..<n {
			if r == 0 || c == 0 {
				grid[r][c] = 1
			} else {
				grid[r][c] = grid[r - 1][c] + grid[r][c - 1]
			}
			print("\(grid[r][c])\t", terminator: "")
		}
		print()
	}
	
	return grid[m - 1][n - 1]
}

// print("3 and 7 should be 28: \(uniquePaths(3, 7))")
// print("3 and 2 should be 3: \(uniquePaths(3, 2))")

func numIslands(_ grid: [[Character]]) -> Int {
	var grid = grid
	func dfs(_ r: Int, _ c: Int) {
		if r < 0 || r >= grid.count || c < 0 || c >= grid[0].count || grid[r][c] != "1" { return }
		grid[r][c] = "0"
		dfs(r - 1, c)
		dfs(r, c - 1)
		dfs(r + 1, c)
		dfs(r, c + 1)
	}

	var numIslands = 0
	for r in 0..<grid.count {
		for c in 0..<grid[0].count {
			guard grid[r][c] == "1" else { continue }
			numIslands += 1
			dfs(r, c)
		}
	}
	return numIslands
}

let grid: [[Character]] = [
  ["1","1","0","0","0"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
]
print(numIslands(grid))

