const std = @import("std");
const root = @import("root.zig");

pub fn run(io: std.Io, args: []const [:0]const u8) !void {
    if (args.len == 1) {
        try showHelp(io);
        return;
    }
}

fn showHelp(io: std.Io) !void {
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.Io.File.stdout().writer(io, &stdout_buffer);
    const stdout = &stdout_writer.interface;

    try stdout.print("Usage: b7e [options] [file]\n", .{});
    try stdout.print("\n", .{});
    try stdout.print("Options:\n", .{});
    try stdout.print("  -v   Print version information and exit\n", .{});

    try stdout.flush();
}
