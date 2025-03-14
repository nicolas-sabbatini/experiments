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

const Krilling = struct {
    name: []const u8 = "Krilling",
    power: usize = 8999,
};

const Goku = struct {
    name: []const u8 = "Goku",
    power: usize = 9001,
};

fn is_powerfull(z_warrior: anytype) void {
    if (z_warrior.power > 9000) {
        std.debug.print("*Vegeta points at {s}*: ITS OVER NINE THOUSAND!!!!\n", .{z_warrior.name});
    } else {
        std.debug.print("*Vegeta points at {s}*: Its a weakling\n", .{z_warrior.name});
    }
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Go z wariors\n", .{});
    var goku = ZWarrior{
        .name = "GOKU",
    };
    try goku.charge_ki(stdout);
    try ZWarrior.charge_ki(&goku, stdout);

    is_powerfull(Krilling{});
    is_powerfull(Goku{});
}
