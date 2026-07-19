const std = @import("std");
const b7e = @import("b7e");

pub fn main(init: std.process.Init) !void {
    const arena = init.arena.allocator();
    const args = try init.minimal.args.toSlice(arena);

    const io = init.io;
    const stdout = try b7e.Stdout.init(io, arena);

    try b7e.cli.run(stdout, args);
}
