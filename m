From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 06/18] mmc: meson-gx: simplify bounce buffer setting in meson_mmc_start_cmd
Date: Wed, 15 Feb 2017 09:14:27 -0800
Message-ID: <m21suzbclo.fsf@baylibre.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
        <10457b8c-401b-d473-0a24-30dfacb4eb48@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36375 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdBORO3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 12:14:29 -0500
Received: by mail-pf0-f175.google.com with SMTP id 189so32889063pfu.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 09:14:29 -0800 (PST)
In-Reply-To: <10457b8c-401b-d473-0a24-30dfacb4eb48@gmail.com> (Heiner
        Kallweit's message of "Tue, 14 Feb 2017 21:06:26 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> If xfer_bytes is zero we can configure the chip to use the bounce
> buffer as well because it won't get used anyway.
> And we don't have to reset bit CMD_CFG_DATA_NUM because cmd_cfg
> was zero-initialized and this bit isn't set.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index c7bf0e12..423b4b17 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -505,15 +505,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>  			cmd_cfg &= ~CMD_CFG_DATA_WR;
>  		}
>  
> -		if (xfer_bytes > 0) {
> -			cmd_cfg &= ~CMD_CFG_DATA_NUM;
> -			cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
> -		} else {
> -			/* write data to data_addr */
> -			cmd_cfg |= CMD_CFG_DATA_NUM;
> -			cmd_data = 0;
> -		}
> -
> +		cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;

Could use a comment above this, mentioning (similar to the changelog)
that when CMD_CFG_DATA_NUM is set, this isn't used.

Otherwise:

Acked-by: Kevin Hilman <khilman@baylibre.com>
