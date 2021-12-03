struct Instruction {
    direction: String,
    amount: i32,
}


pub fn call(puzzle_input: String) -> String {
    let lines = puzzle_input.lines();

    let instructions: Vec<Instruction> = lines.map(|line| {
        let mut parts = line.split(" ");

        let direction = parts.next().unwrap().to_string();
        let amount = parts.next().unwrap().parse::<i32>().unwrap();

        Instruction {
            direction,
            amount
        }
    })
    .collect();

    format!("{}, {}", a(&instructions), b(&instructions))
}

fn a(instructions: &Vec<Instruction>) -> i32 {
    let result = instructions.iter().fold((0,0), |mut acc, instruction| {
        match instruction.direction.as_str() {
            "forward" => acc.0 += instruction.amount,
            "down" => acc.1 += instruction.amount,
            "up" => acc.1 -= instruction.amount,
            _ => ()
        };

        acc
    });

    result.0 * result.1
}

fn b(instructions: &Vec<Instruction>) -> i32 {
    let result = instructions.iter().fold((0,0,0), |mut acc, instruction| {
        match instruction.direction.as_str() {
            "down" => acc.2 += instruction.amount,
            "up" => acc.2 -= instruction.amount,
            "forward" => {
                acc.0 += instruction.amount;
                acc.1 += instruction.amount * acc.2
            }
            _ => ()
        };

        acc
    });

    result.0 * result.1
}
