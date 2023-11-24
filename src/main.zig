const std = @import("std");

const c = @cImport({
    @cInclude("raylib.h");
    // @cInclude("raygui.h");
    @cDefine("RAYGUI_IMPLEMENTATION", {});
    @cInclude("./raygui.h");
});

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!

    c.InitWindow(800, 450, "raylib [core] example - basic window");
    c.SetTargetFPS(30);

    c.SetWindowState(c.FLAG_WINDOW_RESIZABLE);
    while (!c.WindowShouldClose()) {
        c.BeginDrawing();
        c.ClearBackground(c.RAYWHITE);
        c.DrawText("Congrats! You created your first window!", 190, 200, 20, c.LIGHTGRAY);
        c.EndDrawing();

        var rec: c.Rectangle = undefined;
        rec.x = 50;
        rec.y = 50;
        rec.height = 50;
        rec.width = 50;
        _ = c.GuiButton(rec, "ok");
    }
    c.CloseWindow();
}
