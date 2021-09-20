const std = @import("std");
const Allocator = std.mem.Allocator;

/// A parse function with some intentional bugs
pub fn parse(allocator: *Allocator, data: []const u8) !void {
    if (data.len == 0) return;

    switch (data[0]) {
        0 => {
            // alloc without free
            _ = try allocator.alloc(u8, 10);
        },
        1 => {
            // returning an error
            return error.BadInput;
        },
        else => {},
    }
}
