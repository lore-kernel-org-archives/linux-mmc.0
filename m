From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 3/3] mmc: sdhci-of-arasan: add runtime pm support
Date: Tue, 20 Oct 2015 11:19:17 +0200
Message-ID: <CAPDyKFqU6ifQC-pmTc5vdf_eBbXnz-XEmauFWwFcw7imakcozg@mail.gmail.com>
References: <1445324727-31448-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445324727-31448-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 20 October 2015 at 09:05, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> This patch add runtime_suspend and runtime_resume for
> sdhci-of-arasan. Currently we also suspend phy at
> runtime_suspend for power-saving.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
> Changes in v2: None
>
>  drivers/mmc/host/sdhci-of-arasan.c | 80 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 77 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 85bd0f9d..579f7bb 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -30,6 +30,8 @@
>  #define CLK_CTRL_TIMEOUT_MASK          (0xf << CLK_CTRL_TIMEOUT_SHIFT)
>  #define CLK_CTRL_TIMEOUT_MIN_EXP       13
>
> +#define ARASAN_RPM_DELAY_MS            50
> +
>  /**
>   * struct sdhci_arasan_data
>   * @clk_ahb:   Pointer to the AHB clock
> @@ -183,8 +185,70 @@ static int sdhci_arasan_resume(struct device *dev)
>  }
>  #endif /* ! CONFIG_PM_SLEEP */
>
> -static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
> -                        sdhci_arasan_resume);
> +
> +#ifdef CONFIG_PM
> +static int sdhci_arasan_runtime_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
> +       int ret;
> +
> +       ret = sdhci_runtime_suspend_host(host);
> +       if (ret)
> +               return ret;
> +
> +       if (!IS_ERR(sdhci_arasan->phy)) {
> +               ret = sdhci_arasan_suspend_phy(sdhci_arasan->phy);
> +               if (ret) {
> +                       dev_err(dev, "Cannot suspend phy at runtime.\n");
> +                       sdhci_runtime_resume_host(host);
> +                       return ret;
> +               }
> +       }
> +
> +       clk_disable_unprepare(sdhci_arasan->clk_ahb);
> +       clk_disable_unprepare(pltfm_host->clk);

This looks correct, but comparing to the system PM callbacks clocks is
gated via clk_disable() and not via clk_disable_unprepare(). So, you
need to fix this for system PM.

> +
> +       return 0;
> +}
> +
> +static int sdhci_arasan_runtime_resume(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
> +       int ret;
> +
> +       clk_prepare_enable(pltfm_host->clk);
> +       clk_prepare_enable(sdhci_arasan->clk_ahb);
> +
> +       if (!IS_ERR(sdhci_arasan->phy)) {
> +               ret = sdhci_arasan_resume_phy(sdhci_arasan->phy);
> +               if (ret) {
> +                       dev_err(dev, "Cannot resume phy at runtime.\n");
> +                       clk_disable_unprepare(sdhci_arasan->clk_ahb);
> +                       clk_disable_unprepare(pltfm_host->clk);
> +                       return ret;
> +               }
> +       }
> +
> +       return sdhci_runtime_resume_host(host);

The error handling in a runtime resume function sometimes tends to be
a bit tricky.

In this case you have decided to care only about the errors from the
phy API, but ignores the other ones. That isn't consistent, so I think
you need to decide if you want error handling and then for all cases,
or not.

> +}
> +#endif
> +
> +#ifdef CONFIG_PM

Remove this ifdef..

> +static const struct dev_pm_ops sdhci_arasan_pmops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(sdhci_arasan_suspend, sdhci_arasan_resume)

Since you enabled runtime PM, that means sdhci_arasan_suspend() can
end up being invoked when the device is runtime suspended. You don't
deal with that case.

In the ideal scenario you could assign the system PM callbacks to
pm_runtime_force_suspend|resume(), unless you have specific wakeup
settings to manage at system PM. Using this solution would solve the
above problem, in other case you need to deal with it from
sdhci_arasan_suspend|resume().

> +       SET_RUNTIME_PM_OPS(sdhci_arasan_runtime_suspend,
> +                               sdhci_arasan_runtime_resume, NULL)
> +};
> +

... and everything below towards the endif.

Then use the reference of sdhci_arasan_pmops directly when needed below instead.

The minor overhead of having an empty sdhci_arasan_pmops struct when
CONFIG_PM isn't set can be neglected.

> +#define SDHCI_ARASAN_PMOPS (&sdhci_arasan_pmops)
> +
> +#else
> +#define SDHCI_ARASAN_PMOPS NULL
> +#endif
>
>  static int sdhci_arasan_probe(struct platform_device *pdev)
>  {
> @@ -272,6 +336,11 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                 goto clk_disable_all;
>         }
>
> +       pm_runtime_set_autosuspend_delay(&pdev->dev, ARASAN_RPM_DELAY_MS);
> +       pm_runtime_use_autosuspend(&pdev->dev);

pm_runtime_set_active() is missing.

> +       pm_runtime_enable(&pdev->dev);
> +       pm_suspend_ignore_children(&pdev->dev, 1);
> +
>         ret = sdhci_add_host(host);
>         if (ret)
>                 goto err_pltfm_free;
> @@ -279,6 +348,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         return 0;
>
>  err_pltfm_free:
> +       pm_runtime_disable(&pdev->dev);
>         sdhci_pltfm_free(pdev);
>  clk_disable_all:
>         clk_disable_unprepare(clk_xin);
> @@ -297,6 +367,10 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>         if (!IS_ERR(sdhci_arasan->phy))
>                 phy_exit(sdhci_arasan->phy);
>
> +       pm_runtime_get_sync(&pdev->dev);
> +       pm_runtime_dont_use_autosuspend(&pdev->dev);

pm_runtime_dont_use_autosuspend() shouldn't be needed here I think.

> +       pm_runtime_disable(&pdev->dev);
> +
>         clk_disable_unprepare(sdhci_arasan->clk_ahb);
>
>         return sdhci_pltfm_unregister(pdev);
> @@ -314,7 +388,7 @@ static struct platform_driver sdhci_arasan_driver = {
>         .driver = {
>                 .name = "sdhci-arasan",
>                 .of_match_table = sdhci_arasan_of_match,
> -               .pm = &sdhci_arasan_dev_pm_ops,
> +               .pm = SDHCI_ARASAN_PMOPS,
>         },
>         .probe = sdhci_arasan_probe,
>         .remove = sdhci_arasan_remove,
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Kind regards
Uffe
