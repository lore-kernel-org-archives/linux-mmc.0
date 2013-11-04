From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 5/5] mmc: sdhci-esdhc-imx: add runtime pm support
Date: Mon, 4 Nov 2013 14:11:02 +0100
Message-ID: <CAPDyKFpWwCM5kFCHb=bi-X0rgf56fh8_JMSFrwobUVj=X5vS0A@mail.gmail.com>
References: <1383554309-29065-1-git-send-email-b29396@freescale.com>
	<1383554309-29065-6-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f44.google.com ([209.85.128.44]:45521 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab3KDNLG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2013 08:11:06 -0500
Received: by mail-qe0-f44.google.com with SMTP id 6so4086308qeb.3
        for <linux-mmc@vger.kernel.org>; Mon, 04 Nov 2013 05:11:04 -0800 (PST)
In-Reply-To: <1383554309-29065-6-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>

On 4 November 2013 09:38, Dong Aisheng <b29396@freescale.com> wrote:
> The root clock will be disabled in runtime pm which can be used to save power.
>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   49 +++++++++++++++++++++++++++++++++++-
>  1 files changed, 48 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index da8026b..6e64981 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -27,6 +27,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_data/mmc-esdhc-imx.h>
> +#include <linux/pm_runtime.h>
>  #include "sdhci-pltfm.h"
>  #include "sdhci-esdhc.h"
>
> @@ -1121,6 +1122,12 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         if (err)
>                 goto disable_clk;
>
> +       pm_runtime_set_active(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +       pm_runtime_use_autosuspend(&pdev->dev);
> +       pm_suspend_ignore_children(&pdev->dev, 1);
> +
>         return 0;
>
>  disable_clk:
> @@ -1141,6 +1148,9 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>
>         sdhci_remove_host(host, dead);
>
> +       pm_runtime_dont_use_autosuspend(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +
>         clk_disable_unprepare(imx_data->clk_per);
>         clk_disable_unprepare(imx_data->clk_ipg);
>         clk_disable_unprepare(imx_data->clk_ahb);
> @@ -1150,12 +1160,49 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +#ifdef CONFIG_PM_RUNTIME
> +static int sdhci_esdhc_runtime_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct pltfm_imx_data *imx_data = pltfm_host->priv;
> +       int ret;
> +
> +       ret = sdhci_runtime_suspend_host(host);
> +
> +       clk_disable_unprepare(imx_data->clk_per);
> +       clk_disable_unprepare(imx_data->clk_ipg);
> +       clk_disable_unprepare(imx_data->clk_ahb);
> +
> +       return ret;
> +}
> +
> +static int sdhci_esdhc_runtime_resume(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct pltfm_imx_data *imx_data = pltfm_host->priv;
> +
> +       clk_prepare_enable(imx_data->clk_per);
> +       clk_prepare_enable(imx_data->clk_ipg);
> +       clk_prepare_enable(imx_data->clk_ahb);
> +
> +       return sdhci_runtime_resume_host(host);
> +}
> +#endif
> +
> +static const struct dev_pm_ops sdhci_esdhc_pmops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_suspend, sdhci_pltfm_resume)
> +       SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
> +                               sdhci_esdhc_runtime_resume, NULL)
> +};
> +
>  static struct platform_driver sdhci_esdhc_imx_driver = {
>         .driver         = {
>                 .name   = "sdhci-esdhc-imx",
>                 .owner  = THIS_MODULE,
>                 .of_match_table = imx_esdhc_dt_ids,
> -               .pm     = SDHCI_PLTFM_PMOPS,
> +               .pm     = &sdhci_esdhc_pmops,
>         },
>         .id_table       = imx_esdhc_devtype,
>         .probe          = sdhci_esdhc_imx_probe,
> --
> 1.7.2.rc3
>
>
