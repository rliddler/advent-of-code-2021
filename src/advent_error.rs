use std::io;
use std::fmt;
use core::num;


#[derive(Debug)]
pub enum AdventError {
    Io(io::Error),
    Parse(num::ParseIntError),
    Custom(String),
}

impl From<num::ParseIntError> for AdventError {
    fn from(err: num::ParseIntError) -> AdventError {
        AdventError::Parse(err)
    }
}

impl From<io::Error> for AdventError {
    fn from(err: io::Error) -> AdventError {
        AdventError::Io(err)
    }
}

impl fmt::Display for AdventError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            AdventError::Io(ref err) => err.fmt(f),
            AdventError::Parse(ref err) => err.fmt(f),
            AdventError::Custom(ref err) => write!(f, "A custom error occurred {:?}", err),
        }
    }
}
