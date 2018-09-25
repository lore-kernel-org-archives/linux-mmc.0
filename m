From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] sdhci: arasan: Add runtime PM support
Date: Tue, 25 Sep 2018 08:59:25 +0200
Message-ID: <CAPDyKFqmyCg_BL6bAEB7x48KtvYmS45VR9KC4jyQ9=9Pt3QMjA@mail.gmail.com>
References: <1537283046-13985-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537283046-13985-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Manish Narani <manish.narani@xilinx.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 18 September 2018 at 17:04, Manish Narani <manish.narani@xilinx.com> wrote:
> Add runtime PM support in Arasan SDHCI driver.

According to the patch you seem to deploy support for it, but since
you call pm_runtime_forbid() in ->probe(), this means in practice that
the code becomes unused, at least until user-space decides to change
it.

Does it mean that you haven't tested the code or that there are some problems?

In either case, it would be good to know so please add this
information to the changelog.

>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 80 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index a40bcc2..370ada5 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -23,6 +23,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regmap.h>
>  #include <linux/of.h>
> @@ -30,6 +31,7 @@
>  #include "cqhci.h"
>  #include "sdhci-pltfm.h"
>
> +#define SDHCI_ARASAN_AUTOSUSPEND_DELAY 2000 /* ms */
>  #define SDHCI_ARASAN_VENDOR_REGISTER   0x78
>  #define SDHCI_ARASAN_CQE_BASE_ADDR     0x200
>  #define VENDOR_ENHANCED_STROBE         BIT(0)
> @@ -363,6 +365,70 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>                         SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  };
>
> +#ifdef CONFIG_PM
> +static int sdhci_arasan_runtime_suspend(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       if (sdhci_arasan->has_cqe) {
> +               ret = cqhci_suspend(host->mmc);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret = sdhci_runtime_suspend_host(host);
> +       if (ret)
> +               return ret;
> +
> +       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> +               mmc_retune_needed(host->mmc);
> +
> +       clk_disable(pltfm_host->clk);
> +       clk_disable(sdhci_arasan->clk_ahb);
> +
> +       return 0;
> +}
> +
> +static int sdhci_arasan_runtime_resume(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       ret = clk_enable(sdhci_arasan->clk_ahb);
> +       if (ret) {
> +               dev_err(dev, "Cannot enable AHB clock.\n");
> +               return ret;
> +       }
> +
> +       ret = clk_enable(pltfm_host->clk);
> +       if (ret) {
> +               dev_err(dev, "Cannot enable SD clock.\n");
> +               return ret;
> +       }
> +
> +       ret = sdhci_runtime_resume_host(host);
> +       if (ret)
> +               goto out;
> +
> +       if (sdhci_arasan->has_cqe)
> +               return cqhci_resume(host->mmc);
> +
> +       return 0;
> +out:
> +       clk_disable(pltfm_host->clk);
> +       clk_disable(sdhci_arasan->clk_ahb);
> +
> +       return ret;
> +}
> +#endif /* ! CONFIG_PM */
> +
>  #ifdef CONFIG_PM_SLEEP
>  /**
>   * sdhci_arasan_suspend - Suspend method for the driver
> @@ -455,8 +521,10 @@ static int sdhci_arasan_resume(struct device *dev)
>  }
>  #endif /* ! CONFIG_PM_SLEEP */
>
> -static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
> -                        sdhci_arasan_resume);
> +static const struct dev_pm_ops sdhci_arasan_dev_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(sdhci_arasan_suspend, sdhci_arasan_resume)
> +       SET_RUNTIME_PM_OPS(sdhci_arasan_runtime_suspend,
> +                          sdhci_arasan_runtime_resume, NULL) };
>
>  static const struct of_device_id sdhci_arasan_of_match[] = {
>         /* SoC-specific compatible strings w/ soc_ctl_map */
> @@ -821,6 +889,14 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_add_host;
>
> +       pm_runtime_set_active(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_set_autosuspend_delay(&pdev->dev,
> +                                        SDHCI_ARASAN_AUTOSUSPEND_DELAY);
> +       pm_runtime_mark_last_busy(&pdev->dev);
> +       pm_runtime_use_autosuspend(&pdev->dev);
> +       pm_runtime_forbid(&pdev->dev);

When sdhci_arasan_suspend|resume() gets called, which calls into
sdhci_suspend|resume_host(), we requires that the host is already
runtime resumed. I am guessing that's why you are calling
pm_runtime_forbid() here?

To me, it looks like you may want to look into using
pm_runtime_force_suspend|resume() from the system suspend/resume
callbacks. The tricky part seems to be to manage the phy correctly, as
there seems to be some constraints while changing the clock in regards
to the state of the phy - and of course make sure to deal with wakeups
correctly.

I suggest you to have a look at how sdhci-of-at91 has implemented PM
support, that might give you an idea of how it could be done.

> +
>         return 0;
>
>  err_add_host:
> --
> 2.1.1
>

Kind regards
Uffe
