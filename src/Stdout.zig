const std = @import("std");

pub const Stdout = @This();

buffer: [1024]u8 = undefined,
writer: std.Io.File.Writer,

pub fn init(io: std.Io, allocator: std.mem.Allocator) !*Stdout {
    var stdout = try allocator.create(Stdout);
    stdout.writer = std.Io.File.stdout().writer(io, &stdout.buffer);
    return stdout;
}

pub fn print(self: *Stdout, comptime fmt: []const u8, args: anytype) !void {
    try self.writer.interface.print(fmt, args);
    try self.writer.interface.flush();
}

pub fn bufPrint(self: *Stdout, comptime fmt: []const u8, args: anytype) !void {
    try self.writer.interface.print(fmt, args);
}

pub fn flush(self: *Stdout) !void {
    try self.writer.interface.flush();
}
