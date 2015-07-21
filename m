From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-esdhc: add workaround for T4240
 incorrect HOSTVER value
Date: Tue, 21 Jul 2015 15:02:15 +0200
Message-ID: <CAPDyKFpf6Ayw28dmbHhLJ8HSOSie60sUjaAnK7qqONHsRN4BDA@mail.gmail.com>
References: <1437471937-34218-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36068 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbbGUNCP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2015 09:02:15 -0400
Received: by qkdv3 with SMTP id v3so131903018qkd.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jul 2015 06:02:15 -0700 (PDT)
In-Reply-To: <1437471937-34218-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Scott Wood <scottwood@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 21 July 2015 at 11:45, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> For T4240-R1.0-R2.0, the HOSTVER register has incorrcet vender
> version value and sdhc spec version value. This will break down
> the ADMA data transfer. So add workaround to get right value
> VVN=0x13, SVN = 0x1.

So T4240-R1.0-R2.0 is the version of the controller, right?

If I understand correct you are checking what CPU/SoC you are running
on, to figure out which controller version you are using, as that
can't be fetched (trusted) from the registers of the esdhc controller
itself!?

Instead, you could deal with this directly in the DTS files. I assume
you have some DTS file for each SoC/board variant, right?

In principle, in your DTS file specific for the board/SoC that holds
the T4240-R1.0-R2.0 version of the controller, should add a specific
esdhc DT property to indicate this errata. This DT property will then
be parsed by the esdhc driver.

>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc.h    |  5 +++++
>  drivers/mmc/host/sdhci-of-esdhc.c | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index 3497cfa..5174233 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -47,4 +47,9 @@
>
>  #define ESDHC_HOST_CONTROL_RES 0x05
>
> +unsigned int esdhc_errata;
> +
> +/* Incorrect host version in T4240 HOSTVER register */
> +#define ESDHC_ERRATA_T4240_ERROR_HOSTVER               (1<<0)
> +
>  #endif /* _DRIVERS_MMC_SDHCI_ESDHC_H */
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 1295a96..c0ad765 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -59,6 +59,11 @@ static u16 esdhc_readw(struct sdhci_host *host, int reg)
>                 ret = in_be32(host->ioaddr + base) & 0xffff;
>         else
>                 ret = (in_be32(host->ioaddr + base) >> shift) & 0xffff;
> +
> +       if ((reg == SDHCI_HOST_VERSION) &&
> +                       (esdhc_errata & ESDHC_ERRATA_T4240_ERROR_HOSTVER))
> +               ret = (VENDOR_V_23 << SDHCI_VENDOR_VER_SHIFT) | SDHCI_SPEC_200;
> +
>         return ret;
>  }
>
> @@ -352,6 +357,9 @@ static void esdhc_get_property(struct platform_device *pdev)
>  {
>         struct device_node *np = pdev->dev.of_node;
>         struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct device_node *cpus;
> +       const u32 *prop;
> +       u8 rev = 0xff;
>
>         sdhci_get_of_property(pdev);
>
> @@ -359,6 +367,11 @@ static void esdhc_get_property(struct platform_device *pdev)
>         mmc_of_parse(host->mmc);
>         mmc_of_parse_voltage(np, &host->ocr_mask);
>
> +       cpus = of_find_node_by_path("/cpus");
> +       prop = of_get_property(cpus, "cpu-rev", NULL);
> +       if (prop)
> +               rev = *(u8 *)prop;
> +
>         if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
>             of_device_is_compatible(np, "fsl,p5020-esdhc") ||
>             of_device_is_compatible(np, "fsl,p4080-esdhc") ||
> @@ -373,6 +386,11 @@ static void esdhc_get_property(struct platform_device *pdev)
>                  */
>                 host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
>         }
> +
> +       esdhc_errata = 0;
> +
> +       if (of_device_is_compatible(np, "fsl,t4240-esdhc") && rev <= 0x20)
> +               esdhc_errata |= ESDHC_ERRATA_T4240_ERROR_HOSTVER;
>  }
>
>  static int sdhci_esdhc_probe(struct platform_device *pdev)
> --
> 2.1.0.27.g96db324
>

Kind regards
Uffe
