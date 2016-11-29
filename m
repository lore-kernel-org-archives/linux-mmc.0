From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/8] mmc: core: remove BUG_ONs from core.c
Date: Tue, 29 Nov 2016 13:41:19 +0100
Message-ID: <CAPDyKFoP2HPqy+uDwzrFOuCifFT=Lw8FpeCoEbmY-ULm+kztqQ@mail.gmail.com>
References: <1478071440-12689-1-git-send-email-shawn.lin@rock-chips.com> <1478071576-12857-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f181.google.com ([209.85.210.181]:34281 "EHLO
        mail-wj0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755684AbcK2MlW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2016 07:41:22 -0500
Received: by mail-wj0-f181.google.com with SMTP id mp19so144202506wjc.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2016 04:41:21 -0800 (PST)
In-Reply-To: <1478071576-12857-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 2 November 2016 at 08:26, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> BUG_ONs doesn't help anything except for stop the system from
> running. If it occurs, it implies we should deploy proper error
> handling for that. So this patch is gonna discard these meaningless
> BUG_ONs and deploy error handling if needed.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe


> ---
>
>  drivers/mmc/core/core.c | 34 +++++++++-------------------------
>  1 file changed, 9 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 2553d90..7fc4814 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -306,16 +306,16 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>                 mrq->sbc->mrq = mrq;
>         }
>         if (mrq->data) {
> -               BUG_ON(mrq->data->blksz > host->max_blk_size);
> -               BUG_ON(mrq->data->blocks > host->max_blk_count);
> -               BUG_ON(mrq->data->blocks * mrq->data->blksz >
> -                       host->max_req_size);
> -
> +               if (mrq->data->blksz > host->max_blk_size ||
> +                   mrq->data->blocks > host->max_blk_count ||
> +                   mrq->data->blocks * mrq->data->blksz > host->max_req_size)
> +                       return -EINVAL;
>  #ifdef CONFIG_MMC_DEBUG
>                 sz = 0;
>                 for_each_sg(mrq->data->sg, sg, mrq->data->sg_len, i)
>                         sz += sg->length;
> -               BUG_ON(sz != mrq->data->blocks * mrq->data->blksz);
> +               if (sz != mrq->data->blocks * mrq->data->blksz)
> +                       return -EINVAL;
>  #endif
>
>                 mrq->cmd->data = mrq->data;
> @@ -349,8 +349,6 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
>         int timeout;
>         bool use_busy_signal;
>
> -       BUG_ON(!card);
> -
>         if (!card->ext_csd.man_bkops_en || mmc_card_doing_bkops(card))
>                 return;
>
> @@ -754,8 +752,6 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>         u32 status;
>         unsigned long prg_wait;
>
> -       BUG_ON(!card);
> -
>         if (!card->ext_csd.hpi_en) {
>                 pr_info("%s: HPI enable bit unset\n", mmc_hostname(card->host));
>                 return 1;
> @@ -850,7 +846,6 @@ int mmc_stop_bkops(struct mmc_card *card)
>  {
>         int err = 0;
>
> -       BUG_ON(!card);
>         err = mmc_interrupt_hpi(card);
>
>         /*
> @@ -1666,8 +1661,6 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
>         int err = 0;
>         u32 clock;
>
> -       BUG_ON(!host);
> -
>         /*
>          * Send CMD11 only if the request is to switch the card to
>          * 1.8V signalling.
> @@ -1884,9 +1877,7 @@ void mmc_power_cycle(struct mmc_host *host, u32 ocr)
>   */
>  static void __mmc_release_bus(struct mmc_host *host)
>  {
> -       BUG_ON(!host);
> -       BUG_ON(host->bus_refs);
> -       BUG_ON(!host->bus_dead);
> +       WARN_ON(!host->bus_dead);
>
>         host->bus_ops = NULL;
>  }
> @@ -1926,15 +1917,12 @@ void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops)
>  {
>         unsigned long flags;
>
> -       BUG_ON(!host);
> -       BUG_ON(!ops);
> -
>         WARN_ON(!host->claimed);
>
>         spin_lock_irqsave(&host->lock, flags);
>
> -       BUG_ON(host->bus_ops);
> -       BUG_ON(host->bus_refs);
> +       WARN_ON(host->bus_ops);
> +       WARN_ON(host->bus_refs);
>
>         host->bus_ops = ops;
>         host->bus_refs = 1;
> @@ -1950,8 +1938,6 @@ void mmc_detach_bus(struct mmc_host *host)
>  {
>         unsigned long flags;
>
> -       BUG_ON(!host);
> -
>         WARN_ON(!host->claimed);
>         WARN_ON(!host->bus_ops);
>
> @@ -2865,8 +2851,6 @@ void mmc_stop_host(struct mmc_host *host)
>         }
>         mmc_bus_put(host);
>
> -       BUG_ON(host->card);
> -
>         mmc_claim_host(host);
>         mmc_power_off(host);
>         mmc_release_host(host);
> --
> 2.3.7
>
>
