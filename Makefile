# Makefile adapted from 
# https://stackoverflow.com/questions/30573481/how-to-write-a-makefile-with-separate-source-and-header-directories

CPPFLAGS := -MMD -MP -Ilib/raylib/src -Ilib/raylib-cpp/include
CXXFLAGS := -O3 -Wall -Wextra -std=c++17
LDFLAGS := -Llib/raylib/src
LDLIBS := -lraylib -lGdi32 -lWinMM
BIN_NAME := game-engine

SRC_DIR := src
BIN_DIR := build

BIN := $(BIN_DIR)/$(BIN_NAME).exe
SRC := $(filter-out $(SRC_DIR)/main.cpp, $(filter-out %test.cpp, $(wildcard $(SRC_DIR)/*.cpp)))
OBJ := $(SRC:$(SRC_DIR)/%.cpp=$(BIN_DIR)/%.o)
MAIN_OBJ := $(BIN_DIR)/main.o

TST_BIN := $(BIN_DIR)/$(BIN_NAME)-test.exe
TST_SRC := $(wildcard $(SRC_DIR)/*test.cpp)
TST_OBJ := $(TST_SRC:$(SRC_DIR)/%.cpp=$(BIN_DIR)/%.o)

.PHONY: all clean

all: $(BIN)

run: $(BIN)
	$(BIN)

test: $(TST_BIN)
	$(TST_BIN)

clean:
	@$(RM) -r $(BIN_DIR)

$(BIN): $(MAIN_OBJ) $(OBJ) | $(BIN_DIR)
	$(CXX) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(TST_BIN): $(OBJ) $(TST_OBJ) | $(BIN_DIR)
	$(CXX) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(BIN_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BIN_DIR)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

$(BIN_DIR):
	mkdir $@

-include $(OBJ:.o=.d)
