/* 
    Example of two different ways to process received OSC messages using oscpack.
    Receives the messages from the SimpleSend.cpp example.
*/

#include <iostream>
#include <cstring>
#include <vector>

#if defined(__BORLANDC__) // workaround for BCB4 release build intrinsics bug
namespace std {
using ::__strcmp__;  // avoid error: E2316 '__strcmp__' is not a member of 'std'.
}
#endif

#include "osc/OscReceivedElements.h"
#include "osc/OscPacketListener.h"
#include "ip/UdpSocket.h"

#define PORT 7777 

class ExamplePacketListener : public osc::OscPacketListener {
protected:

    virtual void ProcessMessage( const osc::ReceivedMessage& m, 
				const IpEndpointName& remoteEndpoint )
    {
        (void) remoteEndpoint; // suppress unused parameter warning

            // example of parsing single messages. osc::OsckPacketListener
            // handles the bundle traversal
            std::string msg_address = m.AddressPattern();
            std::vector<std::string> filters;
            filters.push_back("/some_filtered_message");
            for (auto& iter : filters)
            {
                if (msg_address.find(iter) != std::string::npos)
                    return;
            }

            std::cout << "address: " << m.AddressPattern() << std::endl;

            osc::ReceivedMessageArgumentIterator iter = m.ArgumentsBegin();
            while (iter != m.ArgumentsEnd())
            {
                try {
                    //std::cout << iter->AsString() << std::endl;
                    std::cout << iter->AsFloat() << std::endl;
                }
                catch (...)
                {
                    try
                    {
                        std::cout << iter->AsInt32() << std::endl;
                    }
                    catch (...)
                    {
                        try
                        {
                            std::cout << iter->AsString() << std::endl;
                        }
                        catch (...)
                        {
                        }
                    }
                }
                iter++;
            }
            std::cout << "----" << std::endl;
    }
};

int main(int argc, char* argv[])
{
    (void) argc; // suppress unused parameter warnings
    (void) argv; // suppress unused parameter warnings

    std::cout << "Starting listener at port " << PORT << std::endl;

    ExamplePacketListener listener;
    UdpListeningReceiveSocket s(
            IpEndpointName( IpEndpointName::ANY_ADDRESS, PORT ),
            &listener );

    std::cout << "press ctrl-c to end\n";

    s.RunUntilSigInt();

    return 0;
}

