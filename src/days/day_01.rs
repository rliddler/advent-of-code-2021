pub fn call(puzzle_input: String) -> String {
    let depths: Vec<i32> = puzzle_input
        .lines()
        .map(|x| x.parse::<i32>().unwrap())
        .collect();

    let slice = &depths[..];

    format!("A: {}, B: {}", count_a(slice), count_b(slice))
}

fn count_a(depths: &[i32]) -> i32 {
    depths.windows(2).fold(0, |acc, window| {
        if window[0] < window[1] {
            return acc + 1
        }

        acc
    })
}

fn count_b(depths: &[i32]) -> i32 {
    depths.windows(4).fold(0, |acc, window| {
        let previous_sum: i32 = window[0..3].iter().sum();
        let new_sum: i32 = window[1..4].iter().sum();

        if previous_sum < new_sum {
            return acc + 1
        }

        acc
    })
}
