From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: avoid writing power control register
Date: Fri, 16 Oct 2015 15:07:30 +0200
Message-ID: <CAPDyKFqzEm4h7uDY-PQ52NzBb=52tQYe7fPsroaTs-Unby2LOA@mail.gmail.com>
References: <1444981443-38869-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35171 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200AbbJPNHb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Oct 2015 09:07:31 -0400
Received: by wicll6 with SMTP id ll6so9176575wic.0
        for <linux-mmc@vger.kernel.org>; Fri, 16 Oct 2015 06:07:30 -0700 (PDT)
In-Reply-To: <1444981443-38869-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 16 October 2015 at 09:44, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> The eSDHC doesn't have a standard power control register, so when
> writing this register in stack we should do nothing to avoid
> incorrect operation.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>

Thanks, applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 7b9282b..90e94a0 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -183,6 +183,12 @@ static u32 esdhc_writeb_fixup(struct sdhci_host *host,
>         int shift = (spec_reg & 0x3) * 8;
>
>         /*
> +        * eSDHC doesn't have a standard power control register, so we do
> +        * nothing here to avoid incorrect operation.
> +        */
> +       if (spec_reg == SDHCI_POWER_CONTROL)
> +               return old_value;
> +       /*
>          * "DMA select" location is offset 0x28 in SD specification, but on
>          * P5020 or P3041, it's located at 0x29.
>          */
> --
> 2.1.0.27.g96db324
>
