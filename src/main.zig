const std = @import("std");
pub const cli = @import("cli.zig");
pub const Stdout = @import("Stdout.zig");

pub fn main(init: std.process.Init) !void {
    const arena = init.arena.allocator();
    const args = try init.minimal.args.toSlice(arena);

    const io = init.io;
    const stdout = try Stdout.init(io, arena);

    try cli.run(io, arena, stdout, args[1..]);
}
