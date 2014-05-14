From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: SD tuning is broken for some controllers
Date: Wed, 14 May 2014 13:42:51 +0200
Message-ID: <CAPDyKFoAHcB=p7O17fzOFw+orE3VGFaQmfsEKN=MbtMP85CUQA@mail.gmail.com>
References: <1399649647-26350-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:51374 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129AbaENLmw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 May 2014 07:42:52 -0400
Received: by mail-qc0-f169.google.com with SMTP id e16so2540238qcx.14
        for <linux-mmc@vger.kernel.org>; Wed, 14 May 2014 04:42:51 -0700 (PDT)
In-Reply-To: <1399649647-26350-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 9 May 2014 17:34, Al Cooper <alcooperx@gmail.com> wrote:
> The SD Host Controller spec states that the SD Host Controller can
> request that the driver send up to 40 CMD19's while doing tuning
> and that the total time the card spends responding must be < 150ms.
> The sdhci_execute_tuning() function in sdhci.c that loops through
> sending the CMD19's has multiple bugs. First it sets a "timeout"
> variable to 150 and a loop counter variable to 40. It then decrements
> both variables by 1 at the end of each loop. It tries to handle
> violations of the count and time by doing a break when BOTH variables
> are equal to zero, which can never happen because they we set to
> different values and decremented by 1 at the same time. The timeout
> variable is not based on time at all and is totally useless.
> The routine also considers a loop counter of zero to be an error
> which means that any controller that requests the max of 40 CMD19s
> will cause tuning to fail and be disabled.
>
> I've fixed these issues by allowing up to 40 CMD19's and I've removed
> any attempt to handle the 150ms time limit. Removing timeout checking
> seems safe here because each CMD19 is timeout protected and the max
> loop counters insures we don't loop forever. Adding timeout checking
> would not be as simple as snapping the time at the loop start and
> checking for 150ms to pass because the loop queues the CMD19's and
> uses events to wait for completion so the time would include
> all the normal scheduler latencies.
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Thanks Al. This make sense to me.
Unless someone objects, I will include this in the next PR I send to Chris.

Kind regards
Ulf Hansson

> ---
>  drivers/mmc/host/sdhci.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9ddef47..a601c10 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1859,7 +1859,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         u16 ctrl;
>         u32 ier;
>         int tuning_loop_counter = MAX_TUNING_LOOP;
> -       unsigned long timeout;
>         int err = 0;
>         bool requires_tuning_nonuhs = false;
>         unsigned long flags;
> @@ -1918,14 +1917,10 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>          * Issue CMD19 repeatedly till Execute Tuning is set to 0 or the number
>          * of loops reaches 40 times or a timeout of 150ms occurs.
>          */
> -       timeout = 150;
>         do {
>                 struct mmc_command cmd = {0};
>                 struct mmc_request mrq = {NULL};
>
> -               if (!tuning_loop_counter && !timeout)
> -                       break;
> -
>                 cmd.opcode = opcode;
>                 cmd.arg = 0;
>                 cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> @@ -1933,6 +1928,9 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 cmd.data = NULL;
>                 cmd.error = 0;
>
> +               if (tuning_loop_counter-- == 0)
> +                       break;
> +
>                 mrq.cmd = &cmd;
>                 host->mrq = &mrq;
>
> @@ -1990,8 +1988,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 host->tuning_done = 0;
>
>                 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> -               tuning_loop_counter--;
> -               timeout--;
>                 mdelay(1);
>         } while (ctrl & SDHCI_CTRL_EXEC_TUNING);
>
> @@ -1999,17 +1995,15 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>          * The Host Driver has exhausted the maximum number of loops allowed,
>          * so use fixed sampling frequency.
>          */
> -       if (!tuning_loop_counter || !timeout) {
> +       if (tuning_loop_counter < 0) {
>                 ctrl &= ~SDHCI_CTRL_TUNED_CLK;
>                 sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +       }
> +       if (!(ctrl & SDHCI_CTRL_TUNED_CLK)) {
> +               pr_info(DRIVER_NAME ": Tuning procedure"
> +                       " failed, falling back to fixed sampling"
> +                       " clock\n");
>                 err = -EIO;
> -       } else {
> -               if (!(ctrl & SDHCI_CTRL_TUNED_CLK)) {
> -                       pr_info(DRIVER_NAME ": Tuning procedure"
> -                               " failed, falling back to fixed sampling"
> -                               " clock\n");
> -                       err = -EIO;
> -               }
>         }
>
>  out:
> --
> 1.9.0.138.g2de3478
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
