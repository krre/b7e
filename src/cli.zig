const std = @import("std");
const Stdout = @import("Stdout.zig");
const build_options = @import("build_options");
const fatal = std.process.fatal;

const usage =
    \\Usage: b7e [options] [file]
    \\
    \\Options:
    \\  -h, --help     Print help and exit
    \\  -v, --version  Print version information and exit
    \\
;

pub fn run(io: std.Io, allocator: std.mem.Allocator, stdout: *Stdout, args: []const []const u8) !void {
    if (args.len == 0) {
        try printUsage(stdout);
        return;
    }

    const arg = args[0];

    if (std.mem.startsWith(u8, arg, "-")) {
        if (std.mem.eql(u8, arg, "-v") or std.mem.eql(u8, arg, "--version")) {
            try printVersion(stdout);
            return;
        } else if (std.mem.eql(u8, arg, "-h") or std.mem.eql(u8, arg, "--help")) {
            try printUsage(stdout);
            return;
        } else {
            fatal("Unrecognized option: '{s}'", .{arg});
        }
    }

    try runWasm(io, allocator, arg, stdout);
}

fn printUsage(stdout: *Stdout) !void {
    try stdout.writeAll(usage);
}

fn printVersion(stdout: *Stdout) !void {
    try stdout.print("{s}\n", .{build_options.version});
}

fn runWasm(io: std.Io, allocator: std.mem.Allocator, file_name: []const u8, stdout: *Stdout) !void {
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
