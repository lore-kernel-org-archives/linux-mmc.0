From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 27/38] mmc: sdhci-of-esdhc: remove platform_suspend/platform_resume
 callbacks
Date: Thu, 24 Apr 2014 09:32:30 +0200
Message-ID: <CAPDyKFrNpxFPfKQNWZ9iwzh=NKZpCzkA8gYnrqnPb-683QcgwA@mail.gmail.com>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
	<E1Wd2Wy-0003w6-9y@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:57086 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbaDXHcb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Apr 2014 03:32:31 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so2135293qcx.27
        for <linux-mmc@vger.kernel.org>; Thu, 24 Apr 2014 00:32:30 -0700 (PDT)
In-Reply-To: <E1Wd2Wy-0003w6-9y@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 23 April 2014 21:08, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> We don't need these hooks in order to insert code in these paths, we
> can just provide our own handlers and call the main sdhci handlers as
> appropriate.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 55 +++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index fcaeae5f55b8..605815e52f5f 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -241,20 +241,6 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>         mdelay(1);
>  }
>
> -#ifdef CONFIG_PM
> -static u32 esdhc_proctl;
> -static void esdhc_of_suspend(struct sdhci_host *host)
> -{
> -       esdhc_proctl = sdhci_be32bs_readl(host, SDHCI_HOST_CONTROL);
> -}
> -
> -static void esdhc_of_resume(struct sdhci_host *host)
> -{
> -       esdhc_of_enable_dma(host);
> -       sdhci_be32bs_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
> -}
> -#endif
> -
>  static void esdhc_of_platform_init(struct sdhci_host *host)
>  {
>         u32 vvn;
> @@ -302,16 +288,47 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
>         .get_max_clock = esdhc_of_get_max_clock,
>         .get_min_clock = esdhc_of_get_min_clock,
>         .platform_init = esdhc_of_platform_init,
> -#ifdef CONFIG_PM
> -       .platform_suspend = esdhc_of_suspend,
> -       .platform_resume = esdhc_of_resume,
> -#endif
>         .adma_workaround = esdhci_of_adma_workaround,
>         .set_bus_width = esdhc_pltfm_set_bus_width,
>         .reset = sdhci_reset,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>
> +#ifdef CONFIG_PM

This should be CONFIG_PM_SLEEP

> +
> +static u32 esdhc_proctl;
> +static int esdhc_of_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +
> +       esdhc_proctl = sdhci_be32bs_readl(host, SDHCI_HOST_CONTROL);
> +
> +       return sdhci_suspend_host(host);
> +}
> +
> +static void esdhc_of_resume(device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       int ret = sdhci_resume_host(host);
> +
> +       if (ret == 0) {
> +               /* Isn't this already done by sdhci_resume_host() ? --rmk */
> +               esdhc_of_enable_dma(host);
> +               sdhci_be32bs_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct dev_pm_ops esdhc_pmops = {
> +       .suspend        = esdhci_of_suspend,
> +       .resume         = esdhci_of_resume,
> +};
> +#define ESDHC_PMOPS (&esdhc_pmops)
> +#else
> +#define ESDHC_PMOPS NULL
> +#endif
> +

I would suggest to use the SIMPLE_DEV_PM_OPS macro to simplify code a bit.

>  static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
>         /*
>          * card detection could be handled via GPIO
> @@ -373,7 +390,7 @@ static struct platform_driver sdhci_esdhc_driver = {
>                 .name = "sdhci-esdhc",
>                 .owner = THIS_MODULE,
>                 .of_match_table = sdhci_esdhc_of_match,
> -               .pm = SDHCI_PLTFM_PMOPS,
> +               .pm = ESDHC_PMOPS,
>         },
>         .probe = sdhci_esdhc_probe,
>         .remove = sdhci_esdhc_remove,
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Ulf Hansson
