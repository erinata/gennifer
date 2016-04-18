CXXFLAGS =	-O2 -g -Wall -fmessage-length=0

OBJS =		variable_name.o

LIBS =

TARGET =	variable_name

$(TARGET):	$(OBJS)
	$(CXX) -o $(TARGET) $(OBJS) $(LIBS)

all:	$(TARGET)

clean:
	rm -f $(OBJS) $(TARGET)
