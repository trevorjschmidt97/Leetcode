func rotateMatrix(grid: [[Int]]) -> [[Int]] {
	var grid = grid
	let n = grid.count

	// swap along the diagonal
	for i in 0..<n {
		for j in i..<n {
			let temp = grid[i][j]
			grid[i][j] = grid[j][i]
			grid[j][i] = temp
		}
	}
	
	// flip each row
	for i in 0..<n {
		for j in 0..<(n / 2) {
			let temp = grid[i][j]
			grid[i][j] = grid[i][n - j - 1]
			grid[i][n - j - 1] = temp
		}
	}

	return grid
}

let grid = [
	[1, 2, 3, 4],
	[5, 6, 7, 8],
	[9,10,11,12],
	[13,14,15,16]
]

for row in grid {
	print(row)
}
print("Swaps to")
for row in rotateMatrix(grid: grid) {
	print(row)
}
		