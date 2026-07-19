const std = @import("std");
const Stdout = @import("Stdout.zig");
const build_options = @import("build_options");

pub fn run(stdout: *Stdout, args: []const [:0]const u8) !void {
    if (args.len == 1) {
        try showHelp(stdout);
        return;
    }

    const arg_1 = args[1];

    if (std.mem.eql(u8, arg_1, "-v")) {
        try showVersion(stdout);
        return;
    }
}

fn showHelp(stdout: *Stdout) !void {
    try stdout.writeAll(
        \\Usage: b7e [options] [file]
        \\
        \\Options:
        \\  -v   Print version information and exit
    );
}

fn showVersion(stdout: *Stdout) !void {
    try stdout.writeAll(build_options.version);
}
