From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: esdhc: add quirk to support 3.3v for T4240
Date: Thu, 4 Jun 2015 09:50:59 +0200
Message-ID: <CAPDyKFp7=2L2_Vt1ha3jcFV=P2EDHEg0UwpcRu_t8r+ED-jDdA@mail.gmail.com>
References: <1433228991-24324-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:34454 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbbFDHvA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jun 2015 03:51:00 -0400
Received: by qcej9 with SMTP id j9so14728682qce.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2015 00:50:59 -0700 (PDT)
In-Reply-To: <1433228991-24324-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chrisball@gmail.com>

On 2 June 2015 at 09:09, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> Add SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33 for T4240
>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 22e9111..4f5fe42 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -369,6 +369,9 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>                 host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
>         }
>
> +       if (of_device_is_compatible(np, "fsl,t4240-esdhc"))
> +               host->quirks2 |= SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33;
> +

Instead of checking the compatible, could you check the "ocr_avail"
mask which mmc_of_parse() create from the vmmc regulator?

>         /* call to generic mmc_of_parse to support additional capabilities */
>         ret = mmc_of_parse(host->mmc);
>         if (ret)
> --
> 2.1.0.27.g96db324
>

Kind regards
Uffe
