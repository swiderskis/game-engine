# Makefile adapted from 
# https://stackoverflow.com/questions/30573481/how-to-write-a-makefile-with-separate-source-and-header-directories

CPPFLAGS := -MMD -MP -isystemlib/raylib/src -isystemlib/raylib-cpp/include
CXXFLAGS := -O3 -Wall -Wextra -std=c++17
LDFLAGS := -Llib/raylib/src
LDLIBS := -lraylib -lopengl32 -lgdi32 -lwinmm
BIN_NAME := game-engine.exe

SRC_DIR := src
BIN_DIR := build
RAYLIB_DIR := lib/raylib/src

BIN := $(BIN_DIR)/$(BIN_NAME)
SRC := $(wildcard $(SRC_DIR)/*.cpp)
OBJ := $(SRC:$(SRC_DIR)/%.cpp=$(BIN_DIR)/%.o)
RAYLIB := $(RAYLIB_DIR)/libraylib.a

.PHONY: all run clean clean_raylib

all: $(BIN)

run: $(BIN)
	$(BIN)

clean:
	@$(RM) -r $(BIN_DIR)

clean_raylib:
	@$(RM) -r $(BIN_DIR)
	$(MAKE) clean_shell_sh -C $(RAYLIB_DIR)

$(BIN): $(RAYLIB) $(OBJ) | $(BIN_DIR)
	$(CXX) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(BIN_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BIN_DIR)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(RAYLIB):
	$(MAKE) PLATFORM=PLATFORM_DESKTOP -C $(RAYLIB_DIR)

$(BIN_DIR):
	mkdir $@

-include $(OBJ:.o=.d)
