#![deny(clippy::all)]
#![deny(clippy::pedantic)]
#![deny(clippy::nursery)]
#![deny(clippy::cargo)]
#![deny(missing_docs)]
// ==============================================================
#![allow(clippy::module_name_repetitions)]
#![allow(clippy::items_after_statements)]
// ==============================================================
#![doc(html_root_url = "https://docs.rs/verbosity/0.1.0")]

//! Intended for use with `cli` commands this library lets you set a singleton [`Verbosity`]
//! option to indicate different levels of reporting, i.e. `Quite` | `Terse` | `Verbose`
//!
//! ## Example
//!
//! ```no_run
//! # use std::str::FromStr;
//! # use verbosity::Verbosity;
//! # use verbosity::Verbosity::*;
//! let level = Verbosity::from_str(
//!         &std::env::args().last().unwrap_or(String::new())
//!     ).unwrap_or(Verbosity::Quite);
//!
//! level.set_as_global();
//!
//! match Verbosity::level() {
//!     Quite => {}
//!     Terse =>
//!         println!("terse message"),
//!     Verbose =>
//!         println!("overly verbose message for some command")
//! }
//! ```
//!
//! ## Related Crate
//!
//! The [`cli-toolbox`] crate uses this library to provide a more ergonomic way of
//! controlling reporting output
//!
//! _i.e._
//! ```no_compile
//! let level = Verbosity::from_str(
//!         &std::env::args().last().unwrap_or(String::new())
//!     ).unwrap_or(Verbosity::Quite);
//!
//! level.set_as_global();
//!
//! report! {
//!     @terse "terse message"
//!     @verbose "overly verbose message for some command"
//! }
//! ```
//! [`Verbosity`]: verbosity::Verbosity
//! [`cli-toolbox`]: <https://crates.io/crates/cli-toolbox>

pub use crate::verbosity::Verbosity;

#[cfg(test)]
mod tests;

mod verbosity;
