const std = @import("std");

fn Vector(comptime T: type) type {
    return struct {
        len: usize,
        items: []T,
        allocator: std.mem.Allocator,

        fn init(allocator: std.mem.Allocator, start_size: usize) !Vector(T) {
            std.debug.assert(start_size > 0);
            return .{ .len = 0, .items = try allocator.alloc(T, start_size), .allocator = allocator };
        }

        fn push(self: *Vector(T), item: T) !void {
            std.debug.assert(self.items.len > 0);
            if (self.len == self.items.len) {
                const new = try self.allocator.alloc(T, self.items.len * 2);
                @memcpy(new[0..self.items.len], self.items);
                self.allocator.free(self.items);
                self.items = new;
            }
            self.items[self.len] = item;
            self.len += 1;
        }

        fn pop(self: *Vector(T)) T {
            std.debug.assert(self.len > 0);
            const item = self.items[self.len - 1];
            self.len -= 1;
            return item;
        }

        fn free(self: *Vector(T)) void {
            self.allocator.free(self.items);
        }

        fn debug_print(self: Vector(T)) void {
            std.debug.print("[\n", .{});
            for (self.items[0..self.len]) |item| {
                std.debug.print("\t{any}\n", .{item});
            }
            std.debug.print("]\n", .{});
        }
    };
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var vec_usize = try Vector(usize).init(allocator, 1);
    defer vec_usize.free();
    vec_usize.debug_print();
    try vec_usize.push(1);
    try vec_usize.push(2);
    try vec_usize.push(3);
    try vec_usize.push(4);
    try vec_usize.push(5);
    vec_usize.debug_print();
    var item = vec_usize.pop();
    std.debug.print("item: {d}\n", .{item});
    item = vec_usize.pop();
    std.debug.print("item: {d}\n", .{item});
    item = vec_usize.pop();
    std.debug.print("item: {d}\n", .{item});
    vec_usize.debug_print();
    item = vec_usize.pop();
    std.debug.print("item: {d}\n", .{item});
    item = vec_usize.pop();
    std.debug.print("item: {d}\n", .{item});
}
