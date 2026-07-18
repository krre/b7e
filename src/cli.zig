const std = @import("std");
const root = @import("root.zig");

pub fn run(args: []const [:0]const u8) void {
    if (args.len == 1) {
        showHelp();
        return;
    }
}

fn showHelp() void {
    std.debug.print("Usage: b7e [options] [file]\n", .{});
    std.debug.print("\n", .{});
    std.debug.print("Options:\n", .{});
    std.debug.print("  -v   Print version information and exit\n", .{});
}
