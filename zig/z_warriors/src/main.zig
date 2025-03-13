const std = @import("std");

const ZWarrior = struct {
    name: []const u8,
    ki: usize = 0,
    const MAX_KI: usize = 9001;
    pub fn charge_ki(self: *ZWarrior, out: std.fs.File.Writer) !void {
        if (self.ki >= MAX_KI) {
            try out.print("{s}: MAXIMUM POWER!!!!!!\n", .{self.name});
        } else {
            self.ki += 9001;
            try out.print("{s}: AHHHHHHHHHHHHHHHHHHHHHHHH!!!!!!\n", .{self.name});
        }
    }
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Go z wariors\n", .{});
    var goku = ZWarrior{
        .name = "GOKU",
    };
    try goku.charge_ki(stdout);
    try ZWarrior.charge_ki(&goku, stdout);
}
