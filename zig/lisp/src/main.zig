const std = @import("std");
const Linenoise = @import("linenoise").Linenoise;

const RplErrors = error{CtrlC};

pub fn main() !void {
    // Se puede utilizar el PageAlocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var ln = Linenoise.init(allocator);
    defer ln.deinit();

    const stdout = std.io.getStdOut().writer();
    try stdout.print("\n", .{});
    try stdout.print("Welcome to Zlisp a small and dumb lisp interpreter!\n", .{});
    try stdout.print("                 Created by Nicolás C. Sabbatini V.\n", .{});
    try stdout.print("                                     Version: 0.0.1\n", .{});
    try stdout.print("---------------------------------------------------\n", .{});
    try stdout.print("        PRESS \"CTRL+C\" or \"CTRL+D\" to exit     \n", .{});
    try stdout.print("---------------------------------------------------\n", .{});

    while (ln.linenoise("lisp > ") catch |err| {
        // En caso de que el usuario precione CTRL+C no queremos creashear
        if (err == RplErrors.CtrlC) {
            return;
        }
        // Si es otro error si crasheamos
        return err;
    }) |input| {
        defer allocator.free(input);
        try stdout.print("{s}\n", .{input});
        try ln.history.add(input);
    }
}
