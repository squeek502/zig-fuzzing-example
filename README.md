zig-fuzzing-example
===================

A full example project demonstrating the methods for fuzzing [Zig](https://ziglang.org/) code detailed in [the blog post 'Fuzzing Zig Code with AFL++'](https://www.ryanliptak.com/blog/fuzzing-zig-code/).

Requires [`afl++`](https://github.com/AFLplusplus/AFLplusplus) with `afl-clang-lto` to be installed.

## Building

- Clone this repository
- Run `zig build fuzz`

## Fuzzing

After building, run:

```
afl-fuzz -i test/input -o test/output -- ./zig-out/bin/fuzz
```

You should quickly see results like:

```
total execs : 44.4k │ total crashes : 4279 (2 unique)
```

Once the crashes are found, full stack traces can be gotten with the `fuzz-debug` executable:

```sh
$ cat 'test/output/default/crashes/id:000000,sig:06,src:000000,time:2,op:havoc,rep:8' | ./zig-out/bin/fuzz-debug
error(gpa): memory address 0x7ffff7ff8000 leaked: 
/home/ryan/Programming/zig/zig-fuzzing-example/src/example.zig:10:36: 0x207e80 in .example.parse (fuzz-debug)
            _ = try allocator.alloc(u8, 10);
                                   ^
/home/ryan/Programming/zig/zig-fuzzing-example/test/fuzz.zig:25:22: 0x205e52 in main (fuzz-debug)
    try example.parse(allocator, data);
                     ^
...
```
