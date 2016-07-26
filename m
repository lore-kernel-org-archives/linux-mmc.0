From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: avoid unused function warnings
Date: Tue, 26 Jul 2016 21:41:50 +0800
Message-ID: <CAA+hA=RPKfRgDc-SesHR8pBFwo0fsbYT=sY=QYyqiAV7U=k_hA@mail.gmail.com>
References: <20160726123246.879426-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:32830 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbcGZNlw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jul 2016 09:41:52 -0400
In-Reply-To: <20160726123246.879426-1-arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Dong Aisheng <aisheng.dong@nxp.com>, Haibo Chen <haibo.chen@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Arnd,

On Tue, Jul 26, 2016 at 8:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The driver has just gained a slightly incorrect pm-sleep implementation that causes
> warnings when CONFIG_PM is set but CONFIG_PM_SLEEP is not:
>
> drivers/mmc/host/sdhci-esdhc-imx.c:1302:12: error: 'sdhci_esdhc_resume' defined but not used [-Werror=unused-function]
>  static int sdhci_esdhc_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~
> drivers/mmc/host/sdhci-esdhc-imx.c:1297:12: error: 'sdhci_esdhc_suspend' defined but not used [-Werror=unused-function]
>  static int sdhci_esdhc_suspend(struct device *dev)
>
> This replaces the incorrect #ifdef with a __maybe_unused annotation that does
> the right thing in all configurations and is more readable.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: b70d0b3b5b29 ("mmc: sdhci-esdhc-imx: add esdhc specific suspend resume callback")

Thanks for the fix.
Looks like the default kernel Makefile does not enable
-Werror=unused-function wanrings,
so did not expose it before.

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 2bb326bbc34a..593e34053c4b 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1293,13 +1293,12 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM
> -static int sdhci_esdhc_suspend(struct device *dev)
> +static int __maybe_unused sdhci_esdhc_suspend(struct device *dev)
>  {
>         return sdhci_pltfm_suspend(dev);
>  }
>
> -static int sdhci_esdhc_resume(struct device *dev)
> +static int __maybe_unused sdhci_esdhc_resume(struct device *dev)
>  {
>         struct sdhci_host *host = dev_get_drvdata(dev);
>
> @@ -1309,7 +1308,7 @@ static int sdhci_esdhc_resume(struct device *dev)
>         return sdhci_pltfm_resume(dev);
>  }
>
> -static int sdhci_esdhc_runtime_suspend(struct device *dev)
> +static int __maybe_unused sdhci_esdhc_runtime_suspend(struct device *dev)
>  {
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1327,7 +1326,7 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
>         return ret;
>  }
>
> -static int sdhci_esdhc_runtime_resume(struct device *dev)
> +static int __maybe_unused sdhci_esdhc_runtime_resume(struct device *dev)
>  {
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1341,7 +1340,6 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
>
>         return sdhci_runtime_resume_host(host);
>  }
> -#endif
>
>  static const struct dev_pm_ops sdhci_esdhc_pmops = {
>         SET_SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
> --
> 2.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
