const std = @import("std");
const Linenoise = @import("linenoise").Linenoise;

const RplErrors = error{CtrlC};

pub fn main() !void {
    var reader_buffer: [2048]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&reader_buffer);
    const allocator = fba.allocator();

    var ln = Linenoise.init(allocator);
    defer ln.deinit();

    const stdout = std.io.getStdOut().writer();
    try stdout.print("Welcome to Zlisp a small and dumb lisp interpreter!\n", .{});
    try stdout.print("---------------- Created by Nicolás C. Sabbatini V.\n", .{});
    try stdout.print("------------------------------------ Version: 0.0.1\n\n", .{});

    while (try ln.linenoise("lisp > ")) |input| {
        defer allocator.free(input);
        try stdout.print("{s}\n", .{input});
        try ln.history.add(input);
    }
}
