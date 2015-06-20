From: Andreas Fenkart <afenkart@gmail.com>
Subject: Re: [PATCH 2/3] mmc: host: omap_hsmmc: Handle BADA, DEB and CEB interrupts
Date: Sun, 21 Jun 2015 00:22:58 +0200
Message-ID: <CALtMJECf1biPaB_y+m+5nQu0RX_Wc87FehkU=9RbJ=v2VLYFkw@mail.gmail.com>
References: <1434451039-18195-1-git-send-email-vigneshr@ti.com>
	<1434451039-18195-3-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:34888 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859AbbFTWW7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 20 Jun 2015 18:22:59 -0400
In-Reply-To: <1434451039-18195-3-git-send-email-vigneshr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, NeilBrown <neilb@suse.de>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org

TESTED-BY

2015-06-16 12:37 GMT+02:00 Vignesh R <vigneshr@ti.com>:
> Sometimes BADA, DEB or CEB error interrupts occur when sd card is
> unplugged during data transfer. These interrupts are currently ignored
> by the interrupt handler. But, this results in card not being
> recognised on subsequent insertion. This is because mmcqd is waiting
> forever for the data transfer(for which error occurred) to complete.
> Fix this, by reporting BADA, DEB, CEB errors to mmc-core as -EILSEQ, so
> that the core can do appropriate handling.
>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index d0abdffb0d7c..fb4bfefd9250 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1068,7 +1068,8 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
>                 }
>                 if (status & (CTO_EN | DTO_EN))
>                         hsmmc_command_incomplete(host, -ETIMEDOUT, end_cmd);
> -               else if (status & (CCRC_EN | DCRC_EN))
> +               else if (status & (CCRC_EN | DCRC_EN | DEB_EN | CEB_EN |
> +                                  BADA_EN))
>                         hsmmc_command_incomplete(host, -EILSEQ, end_cmd);
>
>                 if (status & ACE_EN) {
> --
> 2.4.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
