From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Thu, 1 Sep 2016 16:04:13 +0200
Message-ID: <CAPDyKFqg4jq2dK579eTR1fen1Fhr93p6SpPfDcMxKhiVR9sTPw@mail.gmail.com>
References: <20160901101021.26371-1-pramod.gurav@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35550 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755399AbcIAOEQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2016 10:04:16 -0400
Received: by mail-wm0-f42.google.com with SMTP id w2so78760951wmd.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Sep 2016 07:04:15 -0700 (PDT)
In-Reply-To: <20160901101021.26371-1-pramod.gurav@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pramod Gurav <pramod.gurav@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 1 September 2016 at 12:10, Pramod Gurav <pramod.gurav@linaro.org> wrote:
> Provides runtime PM callbacks to enable and disable clock resources
> when idle. Also support system PM callbacks to be called during system
> suspend and resume.
>
> Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
> ---
> Changes in v2:
> - Moved pm_rutime enabling before adding host
> - Handled pm_rutime in remove
> - Changed runtime handling with reference from sdhci-of-at91.c
>
>  drivers/mmc/host/sdhci-msm.c | 82 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 8ef44a2a..8273a71 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_device.h>
>  #include <linux/delay.h>
>  #include <linux/mmc/mmc.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>
>  #include "sdhci-pltfm.h"
> @@ -658,12 +659,26 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>                 goto clk_disable;
>         }
>
> +       pm_runtime_get_noresume(&pdev->dev);
> +       pm_runtime_set_active(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +       pm_runtime_use_autosuspend(&pdev->dev);
> +
>         ret = sdhci_add_host(host);
>         if (ret)
> -               goto clk_disable;
> +               goto pm_runtime_disable;
> +
> +       platform_set_drvdata(pdev, host);
> +
> +       pm_runtime_put_autosuspend(&pdev->dev);
>
>         return 0;
>
> +pm_runtime_disable:
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_set_suspended(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
>  clk_disable:
>         clk_disable_unprepare(msm_host->clk);
>  pclk_disable:
> @@ -685,6 +700,11 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>                     0xffffffff);
>
>         sdhci_remove_host(host, dead);
> +
> +       pm_runtime_get_sync(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
> +
>         clk_disable_unprepare(msm_host->clk);
>         clk_disable_unprepare(msm_host->pclk);
>         if (!IS_ERR(msm_host->bus_clk))
> @@ -693,12 +713,72 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>         return 0;
>  }
>

Here, add:

#ifdef CONFIG_PM

> +static int sdhci_msm_runtime_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       ret = sdhci_runtime_suspend_host(host);
> +       if (ret)
> +               return ret;
> +
> +       clk_disable_unprepare(msm_host->clk);
> +       clk_disable_unprepare(msm_host->pclk);
> +
> +       return 0;
> +}
> +
> +static int sdhci_msm_runtime_resume(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       ret = clk_prepare_enable(msm_host->clk);
> +       if (ret) {
> +               dev_err(dev, "clk_enable failed: %d\n", ret);
> +               return ret;
> +       }
> +       ret = clk_prepare_enable(msm_host->pclk);
> +       if (ret) {
> +               dev_err(dev, "clk_enable failed: %d\n", ret);
> +               clk_disable_unprepare(msm_host->clk);
> +               return ret;
> +       }
> +
> +       return sdhci_runtime_resume_host(host);
> +}

Here add
#endif

> +
> +static int sdhci_msm_suspend(struct device *dev)
> +{
> +       pm_runtime_force_suspend(dev);
> +
> +       return 0;
> +}
> +
> +static int sdhci_msm_resume(struct device *dev)
> +{
> +       pm_runtime_force_resume(dev);
> +
> +       return 0;
> +}

Remove the above functions and assign the runtime PM callbacks
directly to the pm_runtime_force_suspend|resume() helper functions.

> +
> +static const struct dev_pm_ops sdhci_msm_pm_ops = {
> +       SET_LATE_SYSTEM_SLEEP_PM_OPS(sdhci_msm_suspend, sdhci_msm_resume)
> +       SET_RUNTIME_PM_OPS(sdhci_msm_runtime_suspend, sdhci_msm_runtime_resume,
> +                               NULL)
> +};
> +
>  static struct platform_driver sdhci_msm_driver = {
>         .probe = sdhci_msm_probe,
>         .remove = sdhci_msm_remove,
>         .driver = {
>                    .name = "sdhci_msm",
>                    .of_match_table = sdhci_msm_dt_match,
> +                  .pm = &sdhci_msm_pm_ops,
>         },
>  };
>
> --
> 2.9.3
>


Small fixes needed, otherwise this looks great to me.

Kind regards
Uffe
