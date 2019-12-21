#ifndef __MULTICAST_SENDER_HPP__
#define __MULTICAST_SENDER_HPP__

#include <fcntl.h> 
#include <pthread.h> 
#include <cstring> 
#include <cstdio> 
#include <signal.h> 

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
	class sender
	{
	public:
		sender(const char* ipaddr, short port)
		{
			int opval = 1;
			m_sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_IP);
			setsockopt(m_sock,SOL_SOCKET,SO_REUSEADDR,(const char*)&opval, sizeof(int));
			memset(&m_multicast_addr, 0, sizeof(sockaddr_in));
			m_multicast_addr.sin_family = AF_INET;
			m_multicast_addr.sin_addr.s_addr = inet_addr(ipaddr);
			m_multicast_addr.sin_port = htons(port);
			memset(m_buffer, 0, sizeof(m_buffer));
 
			sockaddr_in local_addr;
			local_addr.sin_family = AF_INET;
			local_addr.sin_port = htons(port);
			local_addr.sin_addr.s_addr = INADDR_ANY;
			bind(m_sock, (sockaddr*)&local_addr, sizeof(sockaddr_in));
 
			addrinfo ai_hints,*ai_rval;
			struct sockaddr_in listen_addr, dest_addr;
			memset(&ai_hints, 0, sizeof(ai_hints));
			ai_hints.ai_family = AF_UNSPEC;
			ai_hints.ai_socktype = SOCK_DGRAM;
			ai_hints.ai_protocol = 0;
			ai_hints.ai_flags = AI_NUMERICSERV;
			memset(&ai_rval, 0, sizeof(addrinfo));
			getaddrinfo(ipaddr, "50000", &ai_hints, &ai_rval);
			memcpy(&listen_addr,ai_rval->ai_addr,ai_rval->ai_addrlen);
			printf("multicast address:%s:%d\n",inet_ntoa(listen_addr.sin_addr),htons(listen_addr.sin_port));
 
			//memset(&ai_hints, 0, sizeof(ai_hints));
			//ai_hints.ai_family = listen_addr.sin_family;
			//ai_hints.ai_socktype = SOCK_DGRAM;
			//ai_hints.ai_protocol = 0;
			//ai_hints.ai_flags = AI_PASSIVE | AI_NUMERICSERV;
			//getaddrinfo(NULL, "50002", &ai_hints, &ai_rval);
			//memcpy(&dest_addr, ai_rval->ai_addr, ai_rval->ai_addrlen);
			//char *addr = inet_ntoa(dest_addr.sin_addr);
		}
		~sender(){ close(m_sock); }
 
		int send_msg(const char* msg, int len)
		{
			int ret = sendto(m_sock, msg, len, 0, (sockaddr*)&m_multicast_addr, sizeof(m_multicast_addr));
			return ret;
		}
 
	private:
		int m_sock;
		sockaddr_in m_multicast_addr;
		char m_buffer[1024 * 8];
	};
}


int main(int argc, char** argv) {
	multicast::sender sender("238.255.255.255", 9000);
	sender.send_msg("haha", 4);
	return 0;
} 
#endif
