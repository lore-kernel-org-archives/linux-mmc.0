From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: extend wait for busy signalling
Date: Mon, 9 Sep 2013 09:41:17 +0200
Message-ID: <CAPDyKFppfnZ18Vev8mzaqQSDTEcDXM0eOcCM1FYKM5xSXORQQw@mail.gmail.com>
References: <loom.20130905T112200-603@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:42297 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab3IIHlR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Sep 2013 03:41:17 -0400
Received: by mail-ve0-f174.google.com with SMTP id jy13so3108167veb.5
        for <linux-mmc@vger.kernel.org>; Mon, 09 Sep 2013 00:41:17 -0700 (PDT)
In-Reply-To: <loom.20130905T112200-603@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 5 September 2013 11:23, Prasanna NAVARATNA
<prasanna.navaratna@gmail.com> wrote:
> From 20efc7e04ebef28c03912824c7edb1bd8f14a20a Mon Sep 17 00:00:00 2001
> From: Prasanna NAVARATNA <prasanna.navaratna@broadcom.com>
> Date: Tue, 3 Sep 2013 17:31:46 +0530
> Subject: [PATCH] mmc: sdhci: extend wait for busy signalling
>
> Certain eMMC features like sanitize, BKOPS, cache, erase etc take
> long time (more than max time) to finish operation during which
> the eMMC pulls DAT0 low to indicate busyness.
> In such special rare cases, data timeout will be triggered as an
> error but actually operation is still in progress with DAT0 low!

I don't think this kind of protocol related code shall remain in the
host driver. Better keep this in the protocol layer.

Moreover, most commands can be followed with status command (CMD13) to
check for busy assertion. I believe this could be a better option to
use from a generic point of view, since not all mmc controllers
support hw-check for busy signalling.

In the cases were CMD13 is not allowed, there are two options to
improve the situation.
1. Extend the usage of host->ops->card_busy in the protocol layer,
thus provide the option for a host driver to implement a software busy
check (could be by re-routing pins to GPIO for example)
2. MMC_CAP_WAIT_WHILE_BUSY is set by host, thus the hw support busy check.

Kind regards
Ulf Hansson

>
> Hence trigger a workqueue to monitor the DAT0 busy signalling by
> the eMMC and extend wait for successful completion of operation.
>
> Signed-off-by: Prasanna NAVARATNA <prasanna.navaratna@broadcom.com>
> ---
>  drivers/mmc/host/sdhci.c  |   68 ++++++++++++++++++++++++++++++++++++++++++++-
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
>  static unsigned int debug_quirks = 0;
>  static unsigned int debug_quirks2;
> @@ -2100,6 +2101,44 @@ static const struct mmc_host_ops sdhci_ops = {
>
>  /*****************************************************************************\
>   *                                                                           *
> + * Workqueues                                                               *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +/* Internal work. Work to wait for the busy signalling to finish. Certain
> + * eMMC operations may take too long time to complete.
> + */
> +static void sdhci_work_wait_for_busy(struct work_struct *work)
> +{
> +       struct sdhci_host *host = container_of(work, struct sdhci_host,
> +                                             wait_for_busy_work);
> +       int wait_cnt = 0;
> +
> +       /*
> +        * According to Arasan, when DTOERR occured while CMD38/CMD6,
> +        * which is not treated as normal and as an error by the Host,
> +        * host driver should reset CMD & DATA Lines for SDHC internal state.
> +        */
> +       pr_debug("Resetting CMD & DATA Lines at once\n");
> +       sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +
> +       pr_info("Waiting for BUSY signalling to end\n");
> +       while (wait_cnt++ < MAX_BUSY_WAIT_LOOP &&
> +               (sdhci_readl(host, SDHCI_PRESENT_STATE) &
> +                       SDHCI_DATA_LVL_DAT0_MASK) == 0) {
> +               msleep(100);
> +        }
> +       pr_info("End of BUSY signalling\n");
> +
> +       if (wait_cnt >= MAX_BUSY_WAIT_LOOP)
> +               pr_err("%s: Operation takes too long to finish!\n",
> +                               mmc_hostname(host->mmc));
> +
> +       sdhci_finish_command(host);
> +}
> +
> +/*****************************************************************************\
> + *                                                                           *
>   * Tasklets                                                                  *
>   *                                                                           *
>  \*****************************************************************************/
> @@ -2328,6 +2367,26 @@ static void sdhci_data_irq(struct sdhci_host *host,
> u32 intmask)
>                                 sdhci_finish_command(host);
>                                 return;
>                         }
> +
> +                       /*
> +                        * Some eMMC takes a long time for the erase & certain
> +                        * operations to finish. Timeout might be triggered well
> +                        * before erase or SWITCH operation finishes. If this
> +                        * happens schedule a workqueue work item to monitor
> +                        * the DAT0 line to wait for operation to finish.
> +                        */
> +                       if (intmask & SDHCI_INT_DATA_TIMEOUT &&
> +                                       (host->cmd->opcode == MMC_ERASE ||
> +                                        host->cmd->opcode == MMC_SWITCH)) {
> +                               if ((sdhci_readl(host, SDHCI_PRESENT_STATE) &
> +                                               SDHCI_DATA_LVL_DAT0_MASK) == 0) {
> +                                       schedule_work(&host->wait_for_busy_work);
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
>                 host->flags &= ~SDHCI_NEEDS_RETUNING;
>         }
>
> +       /* Flush and wait for busy operation to complete */
> +       flush_work(&host->wait_for_busy_work);
> +
>         ret = mmc_suspend_host(host->mmc);
>         if (ret) {
>                 if (host->flags & SDHCI_USING_RETUNING_TIMER) {
> @@ -3206,6 +3268,7 @@ int sdhci_add_host(struct sdhci_host *host)
>                 sdhci_tasklet_finish, (unsigned long)host);
>
>         setup_timer(&host->timer, sdhci_timeout_timer, (unsigned long)host);
> +       INIT_WORK(&host->wait_for_busy_work, sdhci_work_wait_for_busy);
>
>         if (host->version >= SDHCI_SPEC_300) {
>                 init_waitqueue_head(&host->buf_ready_int);
> @@ -3308,6 +3371,9 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
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
>         bool bus_on;            /* Bus power prevents runtime suspend */
>
> +       struct work_struct wait_for_busy_work; /* work to wait for busy to end */
> +
>         struct mmc_request *mrq;        /* Current request */
>         struct mmc_command *cmd;        /* Current command */
>         struct mmc_data *data;  /* Current data request */
> --
> 1.7.6
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
