From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 6/6] mmc: core: mmc DDR mode should not depend on UHS_DDR50
Date: Wed, 30 Oct 2013 23:36:36 +0100
Message-ID: <CAPDyKFpu-HEZ_YRX-2-g1vqww3v9-NObrBvg6pYnKbtn7ZyN8Q@mail.gmail.com>
References: <1383142193-24950-1-git-send-email-b29396@freescale.com>
	<1383142193-24950-7-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:40750 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab3J3Wgh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 18:36:37 -0400
Received: by mail-qc0-f169.google.com with SMTP id x12so1221282qcv.14
        for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2013 15:36:36 -0700 (PDT)
In-Reply-To: <1383142193-24950-7-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, wsa@the-dreams.de

On 30 October 2013 15:09, Dong Aisheng <b29396@freescale.com> wrote:
> The MMC_CAP_UHS_DDR50 must work on 1.8v.
> However, the eMMC DDR mode can work on either 1.8v or 3.3v and
> should not depend on UHS_DDR50.
> So get rid of this limitation to let controller without 1.8v
> signal voltage support can also work for eMMC DDR mode if it claims.
>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/core/mmc.c |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f631f5a..98e9eb0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1119,14 +1119,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>          */
>         if (mmc_card_highspeed(card)) {
>                 if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_8V)
> -                       && ((host->caps & (MMC_CAP_1_8V_DDR |
> -                            MMC_CAP_UHS_DDR50))
> -                               == (MMC_CAP_1_8V_DDR | MMC_CAP_UHS_DDR50)))
> +                       && (host->caps & MMC_CAP_1_8V_DDR))
>                                 ddr = MMC_1_8V_DDR_MODE;
>                 else if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_2V)
> -                       && ((host->caps & (MMC_CAP_1_2V_DDR |
> -                            MMC_CAP_UHS_DDR50))
> -                               == (MMC_CAP_1_2V_DDR | MMC_CAP_UHS_DDR50)))
> +                       && (host->caps & MMC_CAP_1_2V_DDR))
>                                 ddr = MMC_1_2V_DDR_MODE;
>         }
>
> --
> 1.7.2.rc3
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
