# Verbosity

Intended for use with `cli` commands this library lets you set a singleton [`Verbosity`]
option to indicate different levels of reporting, i.e. `Quite` | `Terse` | `Verbose`

## Example

```
let level = Verbosity::from_str(
        &std::env::args().last().unwrap_or(String::new())
    ).unwrap_or(Verbosity::Quite);

level.set_as_global();

match Verbosity::level() {
    Quite => {}
    Terse =>
        println!("terse message"),
    Verbose =>
        println!("overly verbose message for some command")
}
```

## Related Crate

The [`cli-toolbox`] crate uses this library to provide a more ergonomic way of
controlling reporting output

_i.e._
```
let level = Verbosity::from_str(
        &std::env::args().last().unwrap_or(String::new())
    ).unwrap_or(Verbosity::Quite);

level.set_as_global();

report! {
    @terse "terse message"
    @verbose "overly verbose message for some command"
}
```
[`cli-toolbox`]: <https://crates.io/crates/cli-toolbox>

## Resources
* [Docs](https://docs.rs/verbosity/0.1.0/verbosity/) for more detailed information

## Usage


```toml
[dependencies]
verbosity = "0.1"
```
