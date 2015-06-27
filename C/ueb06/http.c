#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

/* Windows-System */
#ifdef _WIN32
#include <winsock.h>
#include <io.h>

/* Unix-System */
#else
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <unistd.h>
#endif

#define HTTP_PORT 80

int main(int argc, char **argv)
{
    int sock;
    struct sockaddr_in host_addr;
    struct hostent *hostinfo;
    char *host, *file;
    char command[1024];
    char buf[1024];
    unsigned int bytes_sent, bytes_recv;

    /* Ist der Aufruf korrekt? */
    if (argc != 3) {
        fprintf (stderr, "Aufruf: httprecv host file\n");
        exit (EXIT_FAILURE);
    }

    host = argv[1];
    file  = argv[2];

    /* ggf. Winsock initialisieren */
    #ifdef _WIN32
    WSADATA wsaData;
    if (WSAStartup (MAKEWORD(1, 1), &wsaData) != 0) {
        fprintf (stderr, "WSAStartup(): Kann Winsock nicht initialisieren.\n");
        exit (EXIT_FAILURE);
    }
    #endif

    /* Socket erzeugen */
    sock = socket (AF_INET, SOCK_STREAM, 0);
    if (sock == -1) {
        perror ("socket()");
        exit (EXIT_FAILURE);
    }

    /* Adresse des Servers festlegen */
    memset( &host_addr, 0, sizeof (host_addr));
    host_addr.sin_family = AF_INET;
    host_addr.sin_port = htons (HTTP_PORT);

    host_addr.sin_addr.s_addr = inet_addr (host);
    if (host_addr.sin_addr.s_addr == INADDR_NONE) {
        /* Server wurde nicht mit IP sondern mit dem Namen angegeben */
        hostinfo = gethostbyname (host);
        if (hostinfo == NULL) {
            perror ("gethostbyname()");
            exit (EXIT_FAILURE);
        }
        memcpy((char*) &host_addr.sin_addr.s_addr, hostinfo->h_addr, hostinfo->h_length);
    }

    /* Verbindung aufbauen */
    if (connect(sock, (struct sockaddr *) &host_addr, sizeof(struct sockaddr)) == -1) {
        perror ("connect()");
        exit (EXIT_FAILURE);
    }

    /* HTTP-GET-Befehl erzeugen */
    sprintf (command, "GET %s HTTP/1.0\nHost: %s\n\n", file, host);

    /* Befehl senden */
    bytes_sent = send (sock, command, strlen (command), 0);
    if (bytes_sent == -1) {
        perror ("send()");
        exit (EXIT_FAILURE);
    }

    // Antwort des Servers empfangen und ausgeben */
    while ((bytes_recv = recv (sock, buf, sizeof(buf), 0)) > 0) {
        write (1, buf, bytes_recv);
    }
    if (bytes_recv == -1) {
        perror ("recv()");
        exit (EXIT_FAILURE);
    }

    printf ("\n");

    #ifdef _WIN32
    closesocket(sock);
    WSACleanup();
    #else
    close(sock);

    #endif

    return 0;

}
