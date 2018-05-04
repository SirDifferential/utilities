/* 
    Simple example of sending an OSC message using oscpack.
*/

#include "osc/OscOutboundPacketStream.h"
#include "ip/UdpSocket.h"


#define ADDRESS "127.0.0.1"
#define PORT 7000

#define OUTPUT_BUFFER_SIZE 1024

int main(int argc, char* argv[])
{
    (void) argc; // suppress unused parameter warnings
    (void) argv; // suppress unused parameter warnings

    UdpTransmitSocket transmitSocket(IpEndpointName(ADDRESS, PORT));
    
    char buffer[OUTPUT_BUFFER_SIZE];
    osc::OutboundPacketStream stream(buffer, OUTPUT_BUFFER_SIZE);
    stream << osc::BeginMessage("foo");
    stream << 8;
    stream << 6;
    stream << 7;
    stream << osc::EndMessage;
    transmitSocket.Send(stream.Data(), stream.Size());
}

