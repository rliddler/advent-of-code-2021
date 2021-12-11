use std::env;
use std::fs;

mod days;
mod advent_error;

use advent_error::AdventError;

fn main() {
    match parse_args(env::args()) {
        Err(error) => println!("{}", error),
        Ok((day, puzzle_input)) => {
            match day {
                1 => print_result(day, days::day_01::call(puzzle_input)),
                2 => print_result(day, days::day_02::call(puzzle_input)),
                3 => print_result(day, days::day_03::call(puzzle_input)),
                _ => println!("There was no matching puzzle day found, get on it!")
            }
        }
    };
}

fn parse_args(mut argv: env::Args) -> Result<(i32, String), AdventError> {
    let day_arg = argv.nth(1)
        .ok_or(AdventError::Custom(String::from("Please specify a puzzle day.")))?;

    let puzzle_day = day_arg.parse::<i32>()?;
    let file_name = &format!("./input/days/day_{:02}.txt", puzzle_day);
    let puzzle_input = fs::read_to_string(file_name)?;

    Ok((puzzle_day, puzzle_input))
}

fn print_result(day: i32, result: String) {
    println!("Result for day {}: {}", day, result)
}
