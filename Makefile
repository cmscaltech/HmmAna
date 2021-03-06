CXX      = g++

CXXFLAGS= $(shell root-config --cflags)
LIBS    = $(shell root-config --libs) 

SOURCES = RoccoR.cc MainEvent.cc HmmAnalyzer.cc 
HEADERS = RoccoR.h MainEvent.h HmmAnalyzer.h 
OBJECTS = $(SOURCES:.cc=.o)

EXECUTABLE = analyzeHmm

all: $(SOURCES) $(EXECUTABLE)

%.o: %.cc $(HEADERS)
	@echo Compiling $<...
	$(CXX) $(CXXFLAGS) -c -o $@ $< 

$(EXECUTABLE): $(OBJECTS)
	@echo "Linking $(EXECUTABLE) ..."
	@echo "@$(CXX) $(LIBS) $(OBJECTS) -o $@"
	@$(CXX) -o $@ $^ $(LIBS) 
	@echo "done"

# Specifying the object files as intermediates deletes them automatically after the build process.
.INTERMEDIATE:  $(OBJECTS)

# The default target, which gives instructions, can be called regardless of whether or not files need to be updated.
.PHONY : clean
clean:
	rm -f $(OBJECTS) $(EXECUTABLE)

###
MainEvent.o: MainEvent.h
AnalyzeHmm.o:MainEvent.h HmmAnalyzer.h
