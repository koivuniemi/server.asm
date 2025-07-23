AR  = nasm
LR  = ld
ARF = -felf64 -g
LRF =

PRJDIR = $(realpath $(CURDIR))
SRCDIR = $(PRJDIR)/src
OBJDIR = $(PRJDIR)/obj
BINDIR = $(PRJDIR)/.

SRC = $(shell find $(SRCDIR) -name "*.asm")
OBJ = $(SRC:$(SRCDIR)/%.asm=$(OBJDIR)/%.o)
BIN = server


.PHONY: all
all: $(BIN)


$(BIN): $(OBJDIR) $(OBJ)
	$(LR) $(LRF) $(OBJ) -o $(BIN)

$(OBJDIR)/%.o: $(SRCDIR)/%.asm
	mkdir -p $(dir $@)
	cd $(dir $^) && $(AR) $(ARF) $(notdir $^) -o $@

$(OBJDIR):
	mkdir $(OBJDIR)


.PHONY: clean
clean:
	rm -r $(OBJDIR) $(BIN)
