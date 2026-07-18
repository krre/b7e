const std = @import("std");

pub fn showHelp() void {
    std.debug.print("Usage: b7e [options] [file]\n", .{});
    std.debug.print("\n", .{});
    std.debug.print("Options:\n", .{});
    std.debug.print("  -v   Print version information and exit\n", .{});
}
