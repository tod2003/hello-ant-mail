#ifndef __MULTICAST_RECEIVER_HPP__
#define __MULTICAST_RECEIVER_HPP__
//#include <ws2ipdef.h>

#include <fcntl.h>
#include <pthread.h>
#include <cstring>
#include <cstdio>
#include <signal.h>
#include <string>

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/un.h>
#include <netdb.h>


namespace multicast{
	class receiver
	{
	public:
		receiver(const char* ipaddr, int port)
		{
			if (ipaddr)
			{
				int opval = 1;
				m_sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_IP);
				setsockopt(m_sock, SOL_SOCKET, SO_REUSEADDR, (const char*)&opval, sizeof(int));
				m_multi_addr = ipaddr;
				m_multicast_addr.sin_family = AF_INET;
				m_multicast_addr.sin_addr.s_addr = inet_addr(ipaddr);
 
				sockaddr_in local_addr;
				local_addr.sin_family = AF_INET;
				local_addr.sin_port = htons(port);
				local_addr.sin_addr.s_addr = /*inet_addr("192.168.6.226")*/INADDR_ANY;
				bind(m_sock, (sockaddr*)&local_addr, sizeof(sockaddr_in));
 
				ip_mreq mreq;
				mreq.imr_multiaddr.s_addr = inet_addr(ipaddr);
				mreq.imr_interface.s_addr = INADDR_ANY;
				setsockopt(m_sock, IPPROTO_IP, IP_ADD_MEMBERSHIP, (const char*)&mreq, sizeof(mreq));
				int loop = 1;
				setsockopt(m_sock, IPPROTO_IP, IP_MULTICAST_LOOP, (const char*)&loop, sizeof(loop));
 
				addrinfo ai_hints, *ai_rval;
				struct sockaddr_in listen_addr, dest_addr;
				memset(&ai_hints, 0, sizeof(ai_hints));
				ai_hints.ai_family = AF_UNSPEC;
				ai_hints.ai_socktype = SOCK_DGRAM;
				ai_hints.ai_protocol = 0;
				ai_hints.ai_flags = AI_NUMERICSERV;
				memset(&ai_rval, 0, sizeof(addrinfo));
				getaddrinfo(ipaddr, "50000", &ai_hints, &ai_rval);
				memcpy(&listen_addr, ai_rval->ai_addr, ai_rval->ai_addrlen);
				printf("multicast address:%s:%d\n", inet_ntoa(listen_addr.sin_addr), htons(listen_addr.sin_port));
			}
		}
		~receiver(){
			ip_mreq mreq;
			mreq.imr_multiaddr.s_addr = inet_addr(m_multi_addr.c_str());
			mreq.imr_interface.s_addr = INADDR_ANY;
			setsockopt(m_sock, IPPROTO_IP, IP_DROP_MEMBERSHIP, (const char*)&mreq, sizeof(mreq));
			close(m_sock);
		}
 
		int recv_msg(char* buffer,int len)
		{
			sockaddr_in from_addr;
			socklen_t fromlen = sizeof(from_addr);
			int ret = recvfrom(m_sock, buffer, len, 0, (sockaddr*)&from_addr, &fromlen);
			printf("%s\n", buffer);
			if (ret > 0)
			{
				printf("%s:%d\n",inet_ntoa(from_addr.sin_addr),ntohs(from_addr.sin_port));
				char temp[1024] = { 0 };
				sprintf(temp, "response msg");
				//ret = sendto(m_sock, temp, 1024, 0, (sockaddr*)&from_addr, fromlen);
			}
			return ret;
		}
 
	private:
		int m_sock;
		//224.0.0.1-239.255.255.255 组播地址范围
		std::string m_multi_addr;
		sockaddr_in m_multicast_addr;
	};
}

int main(int argc, char** argv) {
	multicast::receiver receiver("238.255.255.255", 9000);

	char buf[1024];
	receiver.recv_msg(buf, 1024);
    return 0;
}
 
#endif
