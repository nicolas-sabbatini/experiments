#include "vendors/raylib.h"
#define CLAY_IMPLEMENTATION
#include "vendors/clay.h"
#include "vendors/clay_raylib_render.c"

#define MIN_W 600
#define MIN_H 400

#define FONT_ID 0

void HandleClayErrors(Clay_ErrorData errorData)
{
	printf("%s", errorData.errorText.chars);
}

void CreateButton(Clay_String text)
{
	CLAY(CLAY_LAYOUT({ .padding = { 8, 8 } }),
	     CLAY_RECTANGLE(
		     { .color = { 100, 100, 100, 255 }, .cornerRadius = 15 }))
	{
		CLAY_TEXT(text, CLAY_TEXT_CONFIG({ .fontId = FONT_ID,
						   .fontSize = 10,
						   .textColor = { 255, 255, 255,
								  255 } }));
	};
}

int main(void)
{
	// Set up screen
	Clay_Raylib_Initialize(MIN_W, MIN_H, "Introducing Clay Demo",
			       FLAG_WINDOW_RESIZABLE | FLAG_WINDOW_HIGHDPI |
				       FLAG_MSAA_4X_HINT | FLAG_VSYNC_HINT);
	SetTargetFPS(60);
	SetWindowMinSize(MIN_W, MIN_H);

	// Set up Clay
	uint64_t clayMemory = Clay_MinMemorySize();
	Clay_Arena arena = (Clay_Arena){
		.memory = malloc(clayMemory),
		.capacity = clayMemory,
	};
	Clay_Initialize(
		arena, (Clay_Dimensions){ GetScreenWidth(), GetScreenHeight() },
		(Clay_ErrorHandler){ HandleClayErrors });
	Clay_SetMeasureTextFunction(Raylib_MeasureText);

	// Setpu fonts
	Raylib_fonts[FONT_ID] = (Raylib_Font){
		.font = LoadFontEx("assets/Sixtyfour-Regular.ttf", 16, 0, 0),
		.fontId = FONT_ID,
	};

	// Main loop
	while (!WindowShouldClose()) {
		// Update
		Clay_SetLayoutDimensions(
			(Clay_Dimensions){ .width = GetScreenWidth(),
					   .height = GetScreenHeight() });

		// Draw UI
		Clay_BeginLayout();
		CLAY(CLAY_ID("main"), CLAY_RECTANGLE({.color = {0, 0, 0, 0}}),
         CLAY_LAYOUT({
             .layoutDirection = CLAY_TOP_TO_BOTTOM,
             .sizing =
                 {
                     .width = CLAY_SIZING_GROW(),
                     .height = CLAY_SIZING_GROW(),
                 },
             .padding = {16, 16},
         })){CLAY(CLAY_ID("top_bar"),
                  CLAY_RECTANGLE(
                      {.color = {255, 109, 194, 255}, .cornerRadius = 15}),
                  CLAY_LAYOUT({
                      .sizing =
                          {
                              .width = CLAY_SIZING_GROW(),
                              .height = CLAY_SIZING_FIXED(66),
                          },
                      .padding = {16, 16},
                      .childAlignment = {
                              .x = CLAY_ALIGN_X_CENTER,
                              .y = CLAY_ALIGN_Y_CENTER
                              },
                      .childGap = 50
                  })){CreateButton(CLAY_STRING("Spawn ball"));
		CreateButton(CLAY_STRING("Spawn rec"));
	}
};
Clay_RenderCommandArray uiCommands = Clay_EndLayout();

// Draw
BeginDrawing();
ClearBackground(BLACK);
Clay_Raylib_Render(uiCommands);
EndDrawing();
}

CloseWindow();
}
