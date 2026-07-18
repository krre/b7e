const std = @import("std");
const b7e = @import("b7e");

pub fn main(init: std.process.Init) !void {
    const arena = init.arena.allocator();
    const io = init.io;
    const args = try init.minimal.args.toSlice(arena);
    try b7e.cli.run(io, args);
}
