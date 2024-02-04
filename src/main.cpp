#include <raylib-cpp.hpp>

constexpr int SCREEN_WIDTH = 1920;
constexpr int SCREEN_HEIGHT = 1080;
constexpr int TARGET_FPS = 60;

int main()
{
    raylib::Color text_color(LIGHTGRAY);
    raylib::Window window(SCREEN_WIDTH, SCREEN_HEIGHT, "Raylib C++ Starter Kit Example");

    SetTargetFPS(TARGET_FPS);

    while (!window.ShouldClose()) {
        BeginDrawing();
        ClearBackground(RAYWHITE);
        text_color.DrawText("Congrats! You created your first window!", 190, 200, 20);
        EndDrawing();
    }

    return 0;
}
