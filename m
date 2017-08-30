From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-xenon: add runtime pm support and
 reimplement standby
Date: Wed, 30 Aug 2017 15:38:47 +0200
Message-ID: <CAPDyKFqAqSXo+u04sbW84oa_k4z5Zx2VhwaY3E6u+dgMaOqS5A@mail.gmail.com>
References: <1504032889-16915-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:33775 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdH3Nis (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Aug 2017 09:38:48 -0400
Received: by mail-io0-f179.google.com with SMTP id s101so5169653ioe.0
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2017 06:38:48 -0700 (PDT)
In-Reply-To: <1504032889-16915-1-git-send-email-zjwu@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, xswang@marvell.com, Wilson Ding <dingwei@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, hongd@marvell.com, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On 29 August 2017 at 20:54, Zhoujie Wu <zjwu@marvell.com> wrote:
> Enable runtime pm support for xenon controller, which uses 50ms
> auto runtime suspend by default.
> Reimplement system standby based on runtime pm API.
> Introduce restore_needed to restore the Xenon specific registers
> when resume.
>
> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> v3: Updated according to the comments from Adrian.
>
> v2: Combined two previous patches(runtime pm support and reimplement standby)
> to one according to the suggestion from Adrian.
>
>  drivers/mmc/host/sdhci-xenon.c | 87 ++++++++++++++++++++++++++++++++++--------
>  drivers/mmc/host/sdhci-xenon.h |  1 +
>  2 files changed, 72 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 306ffaf..2eec2e6 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -18,6 +18,8 @@
>  #include <linux/ktime.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
>
>  #include "sdhci-pltfm.h"
>  #include "sdhci-xenon.h"
> @@ -506,13 +508,24 @@ static int xenon_probe(struct platform_device *pdev)
>         if (err)
>                 goto err_clk;
>
> +       pm_runtime_get_noresume(&pdev->dev);
> +       pm_runtime_set_active(&pdev->dev);
> +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +       pm_runtime_use_autosuspend(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);
> +       pm_suspend_ignore_children(&pdev->dev, 1);
> +
>         err = sdhci_add_host(host);
>         if (err)
>                 goto remove_sdhc;
>
> +       pm_runtime_put_autosuspend(&pdev->dev);
> +
>         return 0;
>
>  remove_sdhc:
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
>         xenon_sdhc_unprepare(host);
>  err_clk:
>         clk_disable_unprepare(pltfm_host->clk);
> @@ -526,6 +539,10 @@ static int xenon_remove(struct platform_device *pdev)
>         struct sdhci_host *host = platform_get_drvdata(pdev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>
> +       pm_runtime_get_sync(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
> +
>         sdhci_remove_host(host, 0);
>
>         xenon_sdhc_unprepare(host);
> @@ -542,40 +559,78 @@ static int xenon_suspend(struct device *dev)
>  {
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>         int ret;
>
> -       ret = sdhci_suspend_host(host);
> -       if (ret)
> -               return ret;
> +       ret = pm_runtime_force_suspend(dev);
>
> -       clk_disable_unprepare(pltfm_host->clk);
> +       priv->restore_needed = true;
>         return ret;
>  }
> +#endif
>
> -static int xenon_resume(struct device *dev)
> +#ifdef CONFIG_PM
> +static int xenon_runtime_suspend(struct device *dev)
>  {
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>         int ret;
>
> -       ret = clk_prepare_enable(pltfm_host->clk);
> +       ret = sdhci_runtime_suspend_host(host);
>         if (ret)
>                 return ret;
>
> +       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> +               mmc_retune_needed(host->mmc);
> +
> +       clk_disable_unprepare(pltfm_host->clk);
>         /*
> -        * If SoCs power off the entire Xenon, registers setting will
> -        * be lost.
> -        * Re-configure Xenon specific register to enable current SDHC
> +        * Need to update the priv->clock here, or when runtime resume
> +        * back, phy don't aware the clock change and won't adjust phy
> +        * which will cause cmd err
>          */
> -       ret = xenon_sdhc_prepare(host);
> -       if (ret)
> +       priv->clock = 0;
> +       return 0;
> +}
> +
> +static int xenon_runtime_resume(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       ret = clk_prepare_enable(pltfm_host->clk);
> +       if (ret) {
> +               dev_err(dev, "can't enable mainck\n");
>                 return ret;
> +       }
>
> -       return sdhci_resume_host(host);
> -}
> -#endif
> +       if (priv->restore_needed) {
> +               ret = xenon_sdhc_prepare(host);
> +               if (ret)
> +                       goto out;
> +               priv->restore_needed = false;
> +       }
>
> -static SIMPLE_DEV_PM_OPS(xenon_pmops, xenon_suspend, xenon_resume);
> +       ret = sdhci_runtime_resume_host(host);
> +       if (ret)
> +               goto out;
> +       return 0;
> +out:
> +       clk_disable_unprepare(pltfm_host->clk);
> +       return ret;
> +}
> +#endif /* CONFIG_PM */
> +
> +static const struct dev_pm_ops sdhci_xenon_dev_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(xenon_suspend,
> +                               pm_runtime_force_resume)
> +       SET_RUNTIME_PM_OPS(xenon_runtime_suspend,
> +                          xenon_runtime_resume,
> +                          NULL)
> +};
>
>  static const struct of_device_id sdhci_xenon_dt_ids[] = {
>         { .compatible = "marvell,armada-ap806-sdhci",},
> @@ -589,7 +644,7 @@ static int xenon_resume(struct device *dev)
>         .driver = {
>                 .name   = "xenon-sdhci",
>                 .of_match_table = sdhci_xenon_dt_ids,
> -               .pm = &xenon_pmops,
> +               .pm = &sdhci_xenon_dev_pm_ops,
>         },
>         .probe  = xenon_probe,
>         .remove = xenon_remove,
> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> index 01937f1..2bc0510 100644
> --- a/drivers/mmc/host/sdhci-xenon.h
> +++ b/drivers/mmc/host/sdhci-xenon.h
> @@ -91,6 +91,7 @@ struct xenon_priv {
>          */
>         void            *phy_params;
>         struct xenon_emmc_phy_regs *emmc_phy_regs;
> +       bool restore_needed;
>  };
>
>  int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
> --
> 1.9.1
>
