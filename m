From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: extend wait for busy signalling
Date: Mon, 9 Sep 2013 08:35:28 +0200
Message-ID: <CAH9NwWcFS70fC=Rj7KBEreVWXY2m8F=Ui=hPH=Zt4GUHm1ohHA@mail.gmail.com>
References: <loom.20130905T112200-603@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:59667 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab3IIGft convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2013 02:35:49 -0400
Received: by mail-qe0-f48.google.com with SMTP id nd7so2104013qeb.7
        for <linux-mmc@vger.kernel.org>; Sun, 08 Sep 2013 23:35:49 -0700 (PDT)
In-Reply-To: <loom.20130905T112200-603@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi Prasanna

>
> Certain eMMC features like sanitize, BKOPS, cache, erase etc take
> long time (more than max time) to finish operation during which
> the eMMC pulls DAT0 low to indicate busyness.
> In such special rare cases, data timeout will be triggered as an
> error but actually operation is still in progress with DAT0 low!
>
> Hence trigger a workqueue to monitor the DAT0 busy signalling by
> the eMMC and extend wait for successful completion of operation.
>
> Signed-off-by: Prasanna NAVARATNA <prasanna.navaratna@broadcom.com>
> ---
>  drivers/mmc/host/sdhci.c  |   68 +++++++++++++++++++++++++++++++++++=
+++++++++-
>  include/linux/mmc/sdhci.h |    2 +
>  2 files changed, 69 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b4d7f27..5d6b065 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -42,7 +42,8 @@
>  #define SDHCI_USE_LEDS_CLASS
>  #endif
>
> -#define MAX_TUNING_LOOP 40
> +#define MAX_TUNING_LOOP        40
> +#define MAX_BUSY_WAIT_LOOP     100
>
>  static unsigned int debug_quirks =3D 0;
>  static unsigned int debug_quirks2;
> @@ -2100,6 +2101,44 @@ static const struct mmc_host_ops sdhci_ops =3D=
 {
>
>  /*******************************************************************=
**********\
>   *                                                                  =
         *
> + * Workqueues                                                       =
        *
> + *                                                                  =
         *
> +\*******************************************************************=
**********/
> +
> +/* Internal work. Work to wait for the busy signalling to finish. Ce=
rtain
> + * eMMC operations may take too long time to complete.
> + */
> +static void sdhci_work_wait_for_busy(struct work_struct *work)
> +{
> +       struct sdhci_host *host =3D container_of(work, struct sdhci_h=
ost,
> +                                             wait_for_busy_work);
> +       int wait_cnt =3D 0;
> +
> +       /*
> +        * According to Arasan, when DTOERR occured while CMD38/CMD6,
> +        * which is not treated as normal and as an error by the Host=
,
> +        * host driver should reset CMD & DATA Lines for SDHC interna=
l state.
> +        */
> +       pr_debug("Resetting CMD & DATA Lines at once\n");
> +       sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +
> +       pr_info("Waiting for BUSY signalling to end\n");
> +       while (wait_cnt++ < MAX_BUSY_WAIT_LOOP &&
> +               (sdhci_readl(host, SDHCI_PRESENT_STATE) &
> +                       SDHCI_DATA_LVL_DAT0_MASK) =3D=3D 0) {
> +               msleep(100);
> +        }
> +       pr_info("End of BUSY signalling\n");
> +
> +       if (wait_cnt >=3D MAX_BUSY_WAIT_LOOP)
> +               pr_err("%s: Operation takes too long to finish!\n",
> +                               mmc_hostname(host->mmc));
> +
> +       sdhci_finish_command(host);
> +}
> +
> +/*******************************************************************=
**********\
> + *                                                                  =
         *
>   * Tasklets                                                         =
         *
>   *                                                                  =
         *
>  \*******************************************************************=
**********/
> @@ -2328,6 +2367,26 @@ static void sdhci_data_irq(struct sdhci_host *=
host,
> u32 intmask)
>                                 sdhci_finish_command(host);
>                                 return;
>                         }
> +
> +                       /*
> +                        * Some eMMC takes a long time for the erase =
& certain
> +                        * operations to finish. Timeout might be tri=
ggered well
> +                        * before erase or SWITCH operation finishes.=
 If this
> +                        * happens schedule a workqueue work item to =
monitor
> +                        * the DAT0 line to wait for operation to fin=
ish.
> +                        */
> +                       if (intmask & SDHCI_INT_DATA_TIMEOUT &&
> +                                       (host->cmd->opcode =3D=3D MMC=
_ERASE ||
> +                                        host->cmd->opcode =3D=3D MMC=
_SWITCH)) {
> +                               if ((sdhci_readl(host, SDHCI_PRESENT_=
STATE) &
> +                                               SDHCI_DATA_LVL_DAT0_M=
ASK) =3D=3D 0) {
> +                                       schedule_work(&host->wait_for=
_busy_work);
> +                                       return;
> +                               } else {
> +                                       sdhci_finish_command(host);
> +                                       return;
> +                               }
> +                       }
>                 }
>
>                 pr_err("%s: Got data interrupt 0x%08x even "
> @@ -2559,6 +2618,9 @@ int sdhci_suspend_host(struct sdhci_host *host)
>                 host->flags &=3D ~SDHCI_NEEDS_RETUNING;
>         }
>
> +       /* Flush and wait for busy operation to complete */
> +       flush_work(&host->wait_for_busy_work);
> +
>         ret =3D mmc_suspend_host(host->mmc);
>         if (ret) {
>                 if (host->flags & SDHCI_USING_RETUNING_TIMER) {
> @@ -3206,6 +3268,7 @@ int sdhci_add_host(struct sdhci_host *host)
>                 sdhci_tasklet_finish, (unsigned long)host);
>
>         setup_timer(&host->timer, sdhci_timeout_timer, (unsigned long=
)host);
> +       INIT_WORK(&host->wait_for_busy_work, sdhci_work_wait_for_busy=
);
>
>         if (host->version >=3D SDHCI_SPEC_300) {
>                 init_waitqueue_head(&host->buf_ready_int);
> @@ -3308,6 +3371,9 @@ void sdhci_remove_host(struct sdhci_host *host,=
 int dead)
>         sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
>         free_irq(host->irq, host);
>
> +       /* Flush and wait for busy operation to complete */
> +       flush_work(&host->wait_for_busy_work);
> +
>         del_timer_sync(&host->timer);
>
>         tasklet_kill(&host->card_tasklet);
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 3e781b8..3c86e43 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -144,6 +144,8 @@ struct sdhci_host {
>         bool runtime_suspended; /* Host is runtime suspended */
>         bool bus_on;            /* Bus power prevents runtime suspend=
 */
>
> +       struct work_struct wait_for_busy_work; /* work to wait for bu=
sy to end */
> +
>         struct mmc_request *mrq;        /* Current request */
>         struct mmc_command *cmd;        /* Current command */
>         struct mmc_data *data;  /* Current data request */
> --
> 1.7.6
>
>

=46ailes to compile here... I am using a 3.11 kernel with some local pa=
tches.

-----------------------------
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/mach-types.h' is up to date.
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CHK     kernel/config_data.h
  CC      drivers/mmc/host/sdhci.o
drivers/mmc/host/sdhci.c: In function =E2=80=98sdhci_work_wait_for_busy=
=E2=80=99:
drivers/mmc/host/sdhci.c:2128:24: error: =E2=80=98SDHCI_DATA_LVL_DAT0_M=
ASK=E2=80=99
undeclared (first use in this function)
                        SDHCI_DATA_LVL_DAT0_MASK) =3D=3D 0) {
                        ^
drivers/mmc/host/sdhci.c:2128:24: note: each undeclared identifier is
reported only once for each function it appears in
drivers/mmc/host/sdhci.c: In function =E2=80=98sdhci_data_irq=E2=80=99:
drivers/mmc/host/sdhci.c:2382:48: error: =E2=80=98SDHCI_DATA_LVL_DAT0_M=
ASK=E2=80=99
undeclared (first use in this function)

SDHCI_DATA_LVL_DAT0_MASK) =3D=3D 0) {
                                                ^
make[3]: *** [drivers/mmc/host/sdhci.o] Error 1
make[2]: *** [drivers/mmc/host] Error 2
make[1]: *** [drivers/mmc] Error 2
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....

greets
--
Christian Gmeiner, MSc
