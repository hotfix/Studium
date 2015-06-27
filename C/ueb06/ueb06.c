/***********************************************************************
*
*C-Uebung 6/Socket Programmierung
*
*A.Albrant(winf2862)
*J.C.Benecke(winf2880)
*
************************************************************************/

#ifdef WIN32
    #include <windows.h> 


#else
  #include <sys/socket.h>
  #include <netinet/in.h>
  #include <arpa/inet.h>
  #include <netdb.h>
  #include <unistd.h>
  #include <strings.h>
  #include <stdlib.h>

#endif

  #include <stdio.h>
  #include <string.h> 



/* Funktion um Winsock zu starten, falls Sie nicht in einer WIN32-Umgebung aufgerufen wird
liefert sie 0 zurueck.

  Referenzen: http://msdn.microsoft.com/library/default.asp?url=/library/en-us/winsock/winsock/wsastartup_2.asp

*/


int startWinsock(void)
{
#ifdef WIN32
  WSADATA wsa;
  return WSAStartup(MAKEWORD(2,2),&wsa);
#else
  return 0;
#endif
}

/* Funktion zum Ausgeben des Hilfetextes */

void Hilfe (void) {
  printf("\nC-Uebung 6 \n");
  printf("---------- \n\n");
  printf("Aufruf: \n"); 
  printf("./ueb06 <Protokoll>//<Server><Dokument> (z.B. http://www.fh-wedel.de/~bek)\n");
  printf("./ueb06 <Server><Dokument> (z.B. www.fh-wedel.de/~bek)\n");
  printf("./ueb06 <Protokoll>//<Server> (z.B. http://www.fh-wedel.de)\n");
  printf("./ueb06 <Server> (z.B. www.fh-wedel.de)\n");
}


/* Nach http und :// in dem Uebergabewert suchen,
   entweder die Position des ersten Zeichens nach
   http:// zurückgeben oder -1                     */

char *httpcheck(char *eingabe)
{
  char *pointer;
  if((strstr(eingabe,"http"))!=NULL) /* http gefunden */
  {
      pointer=strstr(eingabe,"http"); /* zeigen auf die stelle von http setzen */
      pointer=pointer+4;			  /* um 4 zeichen weiterschieben */
      if ((strstr(pointer, "://"))!=NULL)  /* :// gefunden */
      {
	pointer=strstr(pointer, "://");   /* zeiger auf die stelle von .// setzen */
        pointer=pointer+3;			  /* 3 Zeichen weiterschieben */
      }
      else {pointer="-1";}			  /* -1 falls Sinnlos */

  }
  else pointer=eingabe;				  /* wenn kein http dann alles wieder zurueck */
  return pointer;					  /* Position vom ersten Zeichen nach http:// zurueckliefern */
}


/* Hauptfunktion */


int main(int argc, char * argv[])
{
  long rc;
  int s;
  struct sockaddr_in addr;
  struct hostent* ip;
  char *eingabe;
  char *server;
  char *seite;
  char *mark;
  char *endung;
  char send_buf[256];
  char recv_buf[256];
  char trash[10];
  int  inttrash1;
  int  inttrash2;
  int  status;

  if (argc != 2) { /* Wenn kein Argument dann gleich Hilfe ausgeben */
	  Hilfe();
	  return 0;
  }
  else
  {
      if ((eingabe=httpcheck(argv[1]))=="-1")
      {   Hilfe();
          return 0;
      }
      else {
             if((mark=strchr(eingabe,'/'))==NULL)
               {  seite="/"; }
             else {
	         seite=++mark;

		 if ((mark=strrchr(seite,'/')) != NULL)
                 {
		    endung=++mark;
		    if ((mark=strchr(endung,'.')) == NULL) { strcat(seite, "/"); }
                 }
	         else {strcat(seite, "/"); }

              }

              server=strtok(eingabe,"/");

	           rc=startWinsock();

	          if(rc!=0)
	          {
		         printf("Error: startWinsock, fehler code: %ld\n",rc);
		         return 1;
	          }
	          else
              {
	             s=socket(AF_INET,SOCK_STREAM,0);
	             #ifdef WIN32
				 if(s==INVALID_SOCKET)
				 #else
				 if(s==-1)
				 #endif
	          {
		      printf("Error: Der Socket konnte nicht erstellt werden");
		      return 1;
	          }
	           else
	  	   	  {
		      #ifdef WIN32
				  memset(&addr,0,sizeof(SOCKADDR_IN));
		      #endif
	              addr.sin_family=AF_INET;
	              addr.sin_port=htons(80); /* wir verwenden port 80*/

				
				  if(!(ip=gethostbyname(server))) {
					  printf("\nKann den angegebenen Host nicht finden . . . . \n");
					  exit(1);
				  }
				 
				 
				

        	      #ifdef WIN32
	  	      	    strncpy((char*)&addr.sin_addr.s_addr,ip->h_addr,4);
				  
					rc=( connect(s,(SOCKADDR*)&addr,sizeof(SOCKADDR)));
				    if (rc==SOCKET_ERROR) {
		      	  #else
	  	      		bcopy(ip->h_addr,&addr.sin_addr,ip->h_length);
					rc=connect(s,(struct sockaddr*) &addr, sizeof(struct sockaddr));
					if (rc==-1) {
		      	  #endif


						printf("Super Verbindungfehler! %ld\n", rc);
						return 0;
					}
					else
					{

  	  	      printf("Server: %s\n", server);
	  	      printf("Document: %s\n", seite);
          	  sprintf(send_buf,"GET /%s HTTP/1.0\r\nHost: %s\r\nUser-Agent: ueb06\r\n\r\n",seite, server);

			  send(s,send_buf,strlen(send_buf),0);/* Senden der Anfrage an den Server */

	  	      recv(s,recv_buf,255,0); /* Empfangen der Antwort auf die Anfrage an den Server */
		      sscanf(recv_buf, "HTTP/%d.%d %d %s", &inttrash1, &inttrash2, &status, trash);
		      printf("HTTP-Status: %d\n", status);
		      printf("%s", recv_buf);
		      while((rc=recv(s,recv_buf,256,0))>0)
	  	      {
                	 recv_buf[rc]= '\0';
	        	 printf("%s",recv_buf);

          	      }

      		      #ifdef WIN32
					  WSACleanup();
                      closesocket(s);
      	              #endif
      		      return 0;

			} /*end else*/
	         } /*end else 3*/
    	      }  /*end else 2*/
       } /*end else*/
   } /*end else*/
} /*end main*/



