const std = @import("std");
const builtin = @import("builtin");
const rl = @import("raylib");
const gui = @import("raygui");

const SCREEN_WIDTH = 800;
const SCREEN_HEIGHT = 600;

fn Vec(comptime T: type) type {
    return struct {
        items: []T,
        allocator: std.mem.Allocator,
        size: usize,

        fn init(allocator: std.mem.Allocator) !Vec(T) {
            return .{ .allocator = allocator, .items = try allocator.alloc(T, 2), .size = 0 };
        }

        fn free(self: Vec(T)) void {
            self.allocator.free(self.items);
        }

        fn capacity(self: Vec(T)) usize {
            return self.items.len;
        }

        fn push(self: *Vec(T), newValue: T) !void {
            if (self.capacity() <= self.size) {
                const newMem = try self.allocator.realloc(self.items, self.capacity() * 2);
                self.items = newMem;
            }
            self.items[self.size] = newValue;
            self.size += 1;
        }

        fn debug(self: Vec(T)) void {
            std.debug.print("Vec: \n\tsize: {any},\n\tcapacity: {any}\n", .{ self.size, self.capacity() });
        }
    };
}

const Ball = struct {
    x: i32,
    y: i32,
    radius: f32,
    color: rl.Color,

    fn new() Ball {
        const x = rl.getRandomValue(0, SCREEN_WIDTH);
        const y = rl.getRandomValue(0, SCREEN_HEIGHT);
        const r: f32 = @floatFromInt(rl.getRandomValue(10, 50));
        const c = rl.Color.init(@intCast(rl.getRandomValue(100, 255)), @intCast(rl.getRandomValue(100, 255)), @intCast(rl.getRandomValue(100, 255)), 255);

        return .{
            .x = x,
            .y = y,
            .radius = r,
            .color = c,
        };
    }
};

pub fn main() anyerror!void {
    // Initialization
    //----------------------------------------------------------------------------------
    // rl.setConfigFlags(rl.ConfigFlags{ .window_resizable = true });

    rl.initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib_zig");
    defer rl.closeWindow();

    rl.setTargetFPS(60);
    rl.setWindowMinSize(SCREEN_WIDTH, SCREEN_HEIGHT);
    //----------------------------------------------------------------------------------

    var spawn = false;

    const base_allocator = if (builtin.target.cpu.arch.isWasm()) std.heap.c_allocator else std.heap.page_allocator;
    var arena = std.heap.ArenaAllocator.init(base_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var vec = try Vec(Ball).init(allocator);
    defer vec.free();

    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        if (spawn) {
            try vec.push(Ball.new());
        }
        spawn = false;
        //----------------------------------------------------------------------------------
        // Draw
        //----------------------------------------------------------------------------------
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.white);

        for (vec.items[0..vec.size]) |ball| {
            rl.drawCircle(ball.x, ball.y, ball.radius, ball.color);
        }

        // The gui acts on release trash
        if (gui.button(rl.Rectangle.init(24.0, 24.0, 120.0, 30.0), "Spawn ball")) {
            spawn = true;
        }
        //----------------------------------------------------------------------------------
    }
}
