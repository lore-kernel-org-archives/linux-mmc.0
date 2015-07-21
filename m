From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc: add default quirk SDHCI_QUIRK_NO_HISPD_BIT
Date: Tue, 21 Jul 2015 13:12:04 +0200
Message-ID: <CAPDyKFqHVD0ZKqGBXpDHvq5NtEve0DNoXuajTimQBHJzg+-T9w@mail.gmail.com>
References: <1436499757-16342-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35597 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbbGULMF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2015 07:12:05 -0400
Received: by qkbm65 with SMTP id m65so75901609qkb.2
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jul 2015 04:12:04 -0700 (PDT)
In-Reply-To: <1436499757-16342-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 10 July 2015 at 05:42, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> eSDHC supports high speed mode, but has no enabling bit for it.
> Add this quirk to avoid writing to eSDHC_PROCTL[DTW] by mistake.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>

Thanks, applied!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index 3497cfa..1b2c4f9 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -21,7 +21,8 @@
>  #define ESDHC_DEFAULT_QUIRKS   (SDHCI_QUIRK_FORCE_BLK_SZ_2048 | \
>                                 SDHCI_QUIRK_NO_BUSY_IRQ | \
>                                 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
> -                               SDHCI_QUIRK_PIO_NEEDS_DELAY)
> +                               SDHCI_QUIRK_PIO_NEEDS_DELAY | \
> +                               SDHCI_QUIRK_NO_HISPD_BIT)
>
>  #define ESDHC_SYSTEM_CONTROL   0x2c
>  #define ESDHC_CLOCK_MASK       0x0000fff0
> --
> 2.1.0.27.g96db324
>
