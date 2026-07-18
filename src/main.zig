const std = @import("std");
const b7e = @import("b7e");

pub fn main(init: std.process.Init) !void {
    const arena = init.arena.allocator();
    const args = try init.minimal.args.toSlice(arena);
    b7e.cli.run(args);
}
