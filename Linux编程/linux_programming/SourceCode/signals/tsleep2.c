#include    <signal.h>
#include	<unistd.h>
#include    "ourhdr.h"

unsigned int    sleep2(unsigned int);
static void        sig_int(int);

int
main(void)
{
    unsigned int    unslept;

    if (signal(SIGINT, sig_int) == SIG_ERR)
        err_sys("signal(SIGINT) error");

    //unslept = sleep2(5);
    unslept = sleep(5);
    printf("sleep2 returned: %u\n", unslept);

    exit(0);
}

static void
sig_int(int signo)
{
    int                i, k;
    volatile int    j;

    printf("\nsig_int starting\n");
	for (k = 0; k < 1000; k++)
        for (i = 0; i < 2000000; i++)
            j += i * i;
    printf("sig_int finished\n");
    return;
}
