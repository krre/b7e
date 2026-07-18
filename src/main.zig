const std = @import("std");
const b7e = @import("b7e");

pub fn main(init: std.process.Init) !void {
    const arena: std.mem.Allocator = init.arena.allocator();
    const args = try init.minimal.args.toSlice(arena);

    if (args.len == 1) {
        b7e.showHelp();
        return;
    }
}
