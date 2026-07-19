const std = @import("std");
const root = @import("root.zig");
const Stdout = @import("Stdout.zig");

pub fn run(stdout: *Stdout, args: []const [:0]const u8) !void {
    if (args.len == 1) {
        try showHelp(stdout);
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
