From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 7/7] mmc: sdhci: clarify DDR timing mode between SD-UHS
 and eMMC
Date: Thu, 16 Jan 2014 11:25:35 +0100
Message-ID: <CAPDyKFqY7RyS4qvpeRRKVK03==ukttwx5Hj7WmPrdC_tnBFe-Q@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<002501cf11fb$e014d980$a03e8c80$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:45437 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbaAPKZf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 05:25:35 -0500
Received: by mail-qa0-f52.google.com with SMTP id j15so1966826qaq.11
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2014 02:25:35 -0800 (PST)
In-Reply-To: <002501cf11fb$e014d980$a03e8c80$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 15 January 2014 15:12, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Added MMC_DDR52 as eMMC's DDR mode distinguished from SD-UHS.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/sdhci.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ec3eb30..6c3482a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1505,6 +1505,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>
>                 /* In case of UHS-I modes, set High Speed Enable */
>                 if ((ios->timing == MMC_TIMING_MMC_HS200) ||
> +                   (ios->timing == MMC_TIMING_MMC_DDR52) ||
>                     (ios->timing == MMC_TIMING_UHS_SDR50) ||
>                     (ios->timing == MMC_TIMING_UHS_SDR104) ||
>                     (ios->timing == MMC_TIMING_UHS_DDR50) ||
> @@ -1565,7 +1566,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>                                 ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
>                         else if (ios->timing == MMC_TIMING_UHS_SDR50)
>                                 ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> -                       else if (ios->timing == MMC_TIMING_UHS_DDR50)
> +                       else if ((ios->timing == MMC_TIMING_UHS_DDR50) ||
> +                                (ios->timing == MMC_TIMING_MMC_DDR52))
>                                 ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
>                         sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>                 }
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
