From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-at91: set clocks and presets after
 resume from deepest PM
Date: Wed, 12 Jul 2017 17:05:09 +0200
Message-ID: <CAPDyKFqnNRLMNJ02J19xwJNjn1qaFsD8JvQmSAcO2wjqk8bZYQ@mail.gmail.com>
References: <20170712141519.15684-1-quentin.schulz@free-electrons.com> <20170712141519.15684-2-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170712141519.15684-2-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, nicolas.ferre@microchip.com, cyrille.pitchen@wedev4u.fr
List-Id: linux-mmc@vger.kernel.org

On 12 July 2017 at 16:15, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> This adds deepest (Backup+Self-Refresh) PM support to the ATMEL SAMA5D2
> SoC's SDHCI controller.
>
> When resuming from deepest state, it is required to restore preset
> registers as the registers are lost since VDD core has been shut down
> when entering deepest state on the SAMA5D2. The clocks need to be
> reconfigured as well.
>
> The other registers and init process are taken care of by the SDHCI
> core.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>
> v2:
>   - use runtime_resume as system_resume,
>   - set a flag to tell when restoring presets is needed,
>   - use a flag to tell runtime_resume to restore presets,
>   - surround sdhci_at91_suspend with ifdef CONFIG_PM_SLEEP instead of CONFIG_PM,
>
>
>  drivers/mmc/host/sdhci-of-at91.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index fb8c6011f13d..828076965277 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -41,6 +41,7 @@ struct sdhci_at91_priv {
>         struct clk *hclock;
>         struct clk *gck;
>         struct clk *mainck;
> +       bool restore_needed;
>  };
>
>  static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned int clock)
> @@ -206,6 +207,19 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>         return 0;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int sdhci_at91_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +       priv->restore_needed = true;

Nitpick:
You should probably move this below pm_runtime_force_suspend() as to
make sure the ->runtime_resume() callback isn't invoked in-between.

> +
> +       return pm_runtime_force_suspend(dev);
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
>  #ifdef CONFIG_PM
>  static int sdhci_at91_runtime_suspend(struct device *dev)
>  {
> @@ -233,6 +247,15 @@ static int sdhci_at91_runtime_resume(struct device *dev)
>         struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
>         int ret;
>
> +       if (priv->restore_needed) {
> +               ret = sdhci_at91_set_clks_presets(dev);
> +               if (ret)
> +                       return ret;
> +
> +               priv->restore_needed = false;
> +               goto out;
> +       }
> +
>         ret = clk_prepare_enable(priv->mainck);
>         if (ret) {
>                 dev_err(dev, "can't enable mainck\n");
> @@ -251,13 +274,13 @@ static int sdhci_at91_runtime_resume(struct device *dev)
>                 return ret;
>         }
>
> +out:
>         return sdhci_runtime_resume_host(host);
>  }
>  #endif /* CONFIG_PM */
>
>  static const struct dev_pm_ops sdhci_at91_dev_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -                               pm_runtime_force_resume)
> +       SET_SYSTEM_SLEEP_PM_OPS(sdhci_at91_suspend, pm_runtime_force_resume)
>         SET_RUNTIME_PM_OPS(sdhci_at91_runtime_suspend,
>                            sdhci_at91_runtime_resume,
>                            NULL)
> @@ -306,6 +329,8 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>         if (ret)
>                 goto sdhci_pltfm_free;
>
> +       priv->restore_needed = false;
> +
>         ret = mmc_of_parse(host->mmc);
>         if (ret)
>                 goto clocks_disable_unprepare;
> --
> 2.11.0
>

Otherwise this looks good to me.

Br
Uffe
