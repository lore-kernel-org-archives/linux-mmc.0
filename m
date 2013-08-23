From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc:core: Avoid useless detecting task when card is busy
Date: Fri, 23 Aug 2013 12:16:45 +0200
Message-ID: <CAPDyKFqZ1Wqvmf5Y3yyu9-HgqSvqkks29-TC3TVvSoByefxV+A@mail.gmail.com>
References: <1377081858-17430-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:53415 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313Ab3HWKQq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 06:16:46 -0400
Received: by mail-ve0-f178.google.com with SMTP id ox1so295696veb.37
        for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2013 03:16:46 -0700 (PDT)
In-Reply-To: <1377081858-17430-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, galak@kernel.crashing.org, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>, scottwood@freescale.com, X.Xie@freescale.com

Hi Haijun,

On 21 August 2013 12:44, Haijun Zhang <Haijun.Zhang@freescale.com> wrote:
> When card is in cpu polling mode to detect card present. Card detecting
> task will be scheduled about once every second. When card is busy in large
> file transfer, detecting task will be hang and call trace will be prompt.
> In this case, when card is busy assume that card is present and just return
> in detecting task. Only polling card in case card is free to reduce conflict
> with data transfer.
>
> <7>mmc0: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
> INFO: task kworker/u:1:12 blocked for more than 120 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/u:1     D 00000000     0    12      2 0x00000000
> Call Trace:
> [ee06dd50] [44042028] 0x44042028
>  (unreliable)
>  [ee06de10] [c0007a0c] __switch_to+0xa0/0xf0
>  [ee06de30] [c04dd50c] __schedule+0x1f8/0x4a4
>
>  [ee06dea0] [c04dd898] schedule+0x30/0xbc
>
>  [ee06deb0] [c03816a4] __mmc_claim_host+0x98/0x19c
>
>  [ee06df00] [c0385f88] mmc_sd_detect+0x38/0xc0
>
>  [ee06df10] [c0382b0c] mmc_rescan+0x294/0x2e0
>  [ee06df40] [c00661cc] process_one_work+0x140/0x3e0
>
>  [ee06df70] [c0066bf8] worker_thread+0x18c/0x36c
>  [ee06dfb0] [c006bf10] kthread+0x7c/0x80
>
>  [ee06dff0] [c000de58] kernel_thread+0x4c/0x68
>  <7>sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
>
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---
>  drivers/mmc/core/core.c | 5 +++++
>  drivers/mmc/core/mmc.c  | 3 ++-
>  drivers/mmc/core/sd.c   | 3 ++-
>  drivers/mmc/core/sdio.c | 3 ++-
>  4 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 49a5bca..d51d9bd 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -924,15 +924,20 @@ EXPORT_SYMBOL(__mmc_claim_host);
>   */
>  int mmc_try_claim_host(struct mmc_host *host)
>  {
> +       struct mmc_card *card;
>         int claimed_host = 0;
>         unsigned long flags;
>
> +       card = host->card;
> +       pm_runtime_get_sync(&card->dev);

This wont work since it very well might trigger a mmc_claim_host,
which mean you will not be "trying" any more.

> +
>         spin_lock_irqsave(&host->lock, flags);
>         if (!host->claimed || host->claimer == current) {
>                 host->claimed = 1;
>                 host->claimer = current;
>                 host->claim_cnt += 1;
>                 claimed_host = 1;
> +               set_current_state(TASK_RUNNING);
>         }
>         spin_unlock_irqrestore(&host->lock, flags);
>         if (host->ops->enable && claimed_host && host->claim_cnt == 1)
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6d02012..90e5555 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1447,7 +1447,8 @@ static void mmc_detect(struct mmc_host *host)
>         BUG_ON(!host);
>         BUG_ON(!host->card);
>
> -       mmc_get_card(host->card);
> +       if (!mmc_try_claim_host(host))
> +               return;
>

I believe this is not a safe solution. You will solve the 120s hang
timeout, but you will instead invent a possible glitch for were a card
will not be removed when it should be.

Look into this sequence:
-> block layer handles request (mmc_get_card has been done)
  -> block layer do error handling
    -> mmc_detect_card_removed
      -> mmc_detect_change is triggered to as soon as possible remove the card.

Then we have race, if the rescan job will run before the block layer
has fully completed mmc_put_card (which also involves a runtime auto
suspend of the card), the card might not be removed.

I think we need to make another solution here, could you maybe prevent
the polling rescan to be re-scheduled once the block layer is
operating on request? Using the runtime pm callbacks maybe? Could that
work?

Kind regards
Ulf Hansson


>         /*
>          * Just check if our card has been removed.
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 176d125..6aae8d1 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1042,7 +1042,8 @@ static void mmc_sd_detect(struct mmc_host *host)
>         BUG_ON(!host);
>         BUG_ON(!host->card);
>
> -       mmc_get_card(host->card);
> +       if (!mmc_try_claim_host(host))
> +               return;
>
>         /*
>          * Just check if our card has been removed.
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 80d89cff..e0cabf5 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -875,7 +875,8 @@ static void mmc_sdio_detect(struct mmc_host *host)
>                 }
>         }
>
> -       mmc_claim_host(host);
> +       if (!mmc_try_claim_host(host))
> +               return;
>
>         /*
>          * Just check if our card has been removed.
> --
> 1.8.0
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
