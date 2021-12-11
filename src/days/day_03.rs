pub fn call(puzzle_input: String) -> String {
    let lines = puzzle_input.lines();

    let rows: Vec<Vec<char>> = lines.map(|line| {
        line.chars().collect()
    }).collect();

    let cols = transpose(&rows, rows.len(), rows[0].len());
    let _gamma: Vec<char> = cols.iter().map(|col| {
        let count = col.iter().fold(0, |acc, val| {
            if *val == '1' {
                return acc + 1;
            }

            acc
        });

        if count > col.len()/2 {
            return '1'
        } else {
            return '0'
        }
    }).collect();

    println!("converted: {:?}", i32::from_str_radix("011110011001",2));

    "hello".to_string()
}

fn transpose(rows: &Vec<Vec<char>>, col_width: usize, row_width: usize) -> Vec<Vec<char>> {
    let mut cols: Vec<Vec<char>> = vec![vec!['0'; col_width]; row_width];

    for (i, row) in rows.iter().enumerate() {
        for (j, &ch) in row.iter().enumerate() {
            cols[j][i] = ch
        }
    }

    cols
}

// fn most_common_bits(rows: &Vec<Vec<char>>) -> Vec<char> {

//     let col_totals: Vec<Vec<i32>> = Vec
//     // set some totals [0,0,0,0,0]
//     // iterate rows and add to totals
//     // build response from those?


//     vec!['a']
// }
