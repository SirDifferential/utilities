CC=g++
CFLAGS=-std=c++0x -pthread -lboost_thread -lGL -lGLU -lGLEW -lSDL -lSDL_image -lSDL_ttf -lSDL_mixer -g -o0 2>&1
LDFLAGS=
SOURCES=$(wildcard ./*.cpp)
OBJECTS=$(SOURCES:.cpp=.o)
EXECUTABLE=cool_program

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(CFLAGS) -o $(EXECUTABLE) $(OBJECTS) $(LDFLAGS)

%.o: %.cpp
	$(CC) $(CFLAGS) $(LDFLAGS) -c -o $@ $<

clean:
	rm *.o

