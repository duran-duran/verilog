VERILOG = iverilog

BUILD_DIR = build
SRC_DIR = src
SRCS = $(wildcard $(SRC_DIR)/*.v) $(wildcard $(SRC_DIR)/elements/*.v)

EXECUTABLE = design

.PHONY: all clean

all: $(EXECUTABLE)

$(EXECUTABLE) : $(BUILD_DIR) $(SRCS)
	$(VERILOG) -o $(BUILD_DIR)/$(EXECUTABLE) $(SRCS)

% :
	$(VERILOG) -o $(BUILD_DIR)/$(notdir $(basename $*)) $(SRC_DIR)/$*.v

$(BUILD_DIR) :
	mkdir $(BUILD_DIR)

clean:
	rm -r $(BUILD_DIR)
