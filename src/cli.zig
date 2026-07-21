const std = @import("std");
const Stdout = @import("Stdout.zig");
const build_options = @import("build_options");

pub fn run(io: std.Io, allocator: std.mem.Allocator, stdout: *Stdout, args: []const [:0]const u8) !void {
    if (args.len == 1) {
        try showHelp(stdout);
        return;
    }

    const arg_1 = args[1];

    if (std.mem.eql(u8, arg_1, "-v")) {
        try showVersion(stdout);
        return;
    }

    try runWasm(io, allocator, arg_1, stdout);
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

fn runWasm(io: std.Io, allocator: std.mem.Allocator, file_name: [:0]const u8, stdout: *Stdout) !void {
    try stdout.print("run file: {s}\n", .{file_name});

    const cwd = std.Io.Dir.cwd();
    const file = try cwd.openFile(io, file_name, .{ .mode = .read_only });
    defer file.close(io);

    const size = try file.length(io);
    const buf = try allocator.alloc(u8, size);

    var reader = file.reader(io, &.{});
    try reader.interface.readSliceAll(buf);

    std.debug.print("buffer len: {d}\n", .{buf.len});
    std.debug.print("buffer content: {s}\n", .{buf});
}
