From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] mmc: core: fold mmc_set_bus_width calls into sdio_enable_4bit_bus.
Date: Mon, 23 Mar 2015 10:34:27 +0100
Message-ID: <CAPDyKFoLi84222xngM2BnvxHu+n63dQ_rjw0BuW=qUbzuZ=Cwg@mail.gmail.com>
References: <20150224024023.22719.32436.stgit@notabene.brown>
	<20150224024223.22719.90256.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33256 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbbCWJe2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Mar 2015 05:34:28 -0400
Received: by qgfa8 with SMTP id a8so140952470qgf.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2015 02:34:27 -0700 (PDT)
In-Reply-To: <20150224024223.22719.90256.stgit@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Andreas Fenkart <afenkart@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, NeilBrown <neil@brown.name>, linux-omap <linux-omap@vger.kernel.org>

On 24 February 2015 at 03:42, NeilBrown <neilb@suse.de> wrote:
> Every call to sdio_enable_4bit_bus is followed (on success) but a call

/s /but / by

> to mmc_set_bus_width().
>
> To simplify the code, include those calls directly in
> sdio_enable_4bit_bus().
>
> Signed-off-by: NeilBrown <neil@brown.name>

Nice cleanup! Applied for next with the above minor change.

Kind regards
Uffe

> ---
>  drivers/mmc/core/sdio.c |   32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index ce6cc47206b0..5bc6c7dbbd60 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -293,19 +293,22 @@ static int sdio_enable_4bit_bus(struct mmc_card *card)
>         int err;
>
>         if (card->type == MMC_TYPE_SDIO)
> -               return sdio_enable_wide(card);
> -
> -       if ((card->host->caps & MMC_CAP_4_BIT_DATA) &&
> -               (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
> +               err = sdio_enable_wide(card);
> +       else if ((card->host->caps & MMC_CAP_4_BIT_DATA) &&
> +                (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
>                 err = mmc_app_set_bus_width(card, MMC_BUS_WIDTH_4);
>                 if (err)
>                         return err;
> +               err = sdio_enable_wide(card);
> +               if (err <= 0)
> +                       mmc_app_set_bus_width(card, MMC_BUS_WIDTH_1);
>         } else
>                 return 0;
>
> -       err = sdio_enable_wide(card);
> -       if (err <= 0)
> -               mmc_app_set_bus_width(card, MMC_BUS_WIDTH_1);
> +       if (err > 0) {
> +               mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
> +               err = 0;
> +       }
>
>         return err;
>  }
> @@ -547,13 +550,8 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
>         /*
>          * Switch to wider bus (if supported).
>          */
> -       if (card->host->caps & MMC_CAP_4_BIT_DATA) {
> +       if (card->host->caps & MMC_CAP_4_BIT_DATA)
>                 err = sdio_enable_4bit_bus(card);
> -               if (err > 0) {
> -                       mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
> -                       err = 0;
> -               }
> -       }
>
>         /* Set the driver strength for the card */
>         sdio_select_driver_type(card);
> @@ -803,9 +801,7 @@ try_again:
>                  * Switch to wider bus (if supported).
>                  */
>                 err = sdio_enable_4bit_bus(card);
> -               if (err > 0)
> -                       mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
> -               else if (err)
> +               if (err)
>                         goto remove;
>         }
>  finish:
> @@ -983,10 +979,6 @@ static int mmc_sdio_resume(struct mmc_host *host)
>         } else if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
>                 /* We may have switched to 1-bit mode during suspend */
>                 err = sdio_enable_4bit_bus(host->card);
> -               if (err > 0) {
> -                       mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
> -                       err = 0;
> -               }
>         }
>
>         if (!err && host->sdio_irqs) {
>
>
