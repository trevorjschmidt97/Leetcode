func zeroMatrix(grid: [[Int]]) -> [[Int]] {
	var grid = grid
	var rowZeros: Set<Int> = []
	var colZeros: Set<Int> = []

	for i in 0..<grid.count {
		for j in 0..<grid[0].count {
			if grid[i][j] == 0 {
				rowZeros.insert(i)
				colZeros.insert(j)
			}
		}
	}

	for i in 0..<grid.count {
		for j in 0..<grid[0].count {
			if rowZeros.contains(i) || colZeros.contains(j) {
				grid[i][j] = 0
			}
		}
	}

	return grid
}

func zeroMatrixConstantSpace(grid: [[Int]]) -> [[Int]] {
	var grid = grid
	let rowCount = grid.count
	guard rowCount > 0 else { return grid }
	let colCount = grid[0].count
	var rowZero = false

	for i in 0..<rowCount {
		for j in 0..<colCount {
			if grid[i][j] == 0 {
				grid[0][j] = 0
				if i > 0 {
					grid[i][0] = 0
				} else {
					rowZero = true
				}
			}
		}
	}

	for i in 1..<rowCount {
		for j in 1..<colCount {
			if grid[0][j] == 0 || grid[i][0] == 0 {
				grid[i][j] = 0
			}
		}
	}

	if grid[0][0] == 0 {
		for i in 0..<rowCount {
			grid[i][0] = 0
		}
	}

	if rowZero {
		for j in 0..<colCount {
			grid[0][j] = 0
		}
	}
	
	return grid
}

let grid = [
	[1, 2, 3, 4],
	[5, 0, 7, 8],
	[9,10,11,12],
	[13,14,15,16]
]

for row in grid {
	print(row)
}
print("zeros to")
for row in zeroMatrix(grid: grid) {
	print(row)
}
		