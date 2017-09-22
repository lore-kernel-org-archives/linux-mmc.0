From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-msm: Utilize bulk clock API
Date: Fri, 22 Sep 2017 13:22:17 +0200
Message-ID: <CAPDyKFpE9AmRF79Fqd5WM-WYi8=3WNgEcrVyKDTHgyjnDwP_sg@mail.gmail.com>
References: <20170915233524.1375-1-bjorn.andersson@linaro.org> <20170915233524.1375-2-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:45441 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751933AbdIVLWS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 07:22:18 -0400
Received: by mail-io0-f182.google.com with SMTP id g32so2309613ioj.2
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2017 04:22:18 -0700 (PDT)
In-Reply-To: <20170915233524.1375-2-bjorn.andersson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 16 September 2017 at 01:35, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> By stuffing the runtime controlled clocks into a clk_bulk_data array we
> can utilize the newly introduced bulk clock operations and clean up the
> error paths. This allow us to handle additional clocks in subsequent
> patch, without the added complexity.
>
> Cc: Ritesh Harjani <riteshh@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Apparently clk_bulk_* isn't exported, which triggers the follow build errors.

https://storage.kernelci.org/ulfh/next/v4.14-rc1-23-g22a5146dde6b/arm64/allmodconfig/build.log

Can you perhaps send a patch exporting them, and tell Mike/Stephen to
pick it up as a part of the 4.14 rcs?

Kind regards
Uffe

> ---
>
> Changes since v1:
> - Dropped "clk" and "pclk" from sdhci_msm_host
>
>  drivers/mmc/host/sdhci-msm.c | 80 +++++++++++++++++++-------------------------
>  1 file changed, 34 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 9d601dc0d646..b9ca1b1ef9a8 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -127,10 +127,9 @@ struct sdhci_msm_host {
>         struct platform_device *pdev;
>         void __iomem *core_mem; /* MSM SDCC mapped address */
>         int pwr_irq;            /* power irq */
> -       struct clk *clk;        /* main SD/MMC bus clock */
> -       struct clk *pclk;       /* SDHC peripheral bus clock */
>         struct clk *bus_clk;    /* SDHC bus voter clock */
>         struct clk *xo_clk;     /* TCXO clk needed for FLL feature of cm_dll*/
> +       struct clk_bulk_data bulk_clks[2]; /* core, iface clocks */
>         unsigned long clk_rate;
>         struct mmc_host *mmc;
>         bool use_14lpp_dll_reset;
> @@ -164,10 +163,11 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>         struct mmc_ios curr_ios = host->mmc->ios;
> +       struct clk *core_clk = msm_host->bulk_clks[0].clk;
>         int rc;
>
>         clock = msm_get_clock_rate_for_bus_mode(host, clock);
> -       rc = clk_set_rate(msm_host->clk, clock);
> +       rc = clk_set_rate(core_clk, clock);
>         if (rc) {
>                 pr_err("%s: Failed to set clock at rate %u at timing %d\n",
>                        mmc_hostname(host->mmc), clock,
> @@ -176,7 +176,7 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
>         }
>         msm_host->clk_rate = clock;
>         pr_debug("%s: Setting clock at rate %lu at timing %d\n",
> -                mmc_hostname(host->mmc), clk_get_rate(msm_host->clk),
> +                mmc_hostname(host->mmc), clk_get_rate(core_clk),
>                  curr_ios.timing);
>  }
>
> @@ -1032,8 +1032,9 @@ static unsigned int sdhci_msm_get_max_clock(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       struct clk *core_clk = msm_host->bulk_clks[0].clk;
>
> -       return clk_round_rate(msm_host->clk, ULONG_MAX);
> +       return clk_round_rate(core_clk, ULONG_MAX);
>  }
>
>  static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
> @@ -1124,6 +1125,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_msm_host *msm_host;
>         struct resource *core_memres;
> +       struct clk *clk;
>         int ret;
>         u16 host_version, core_minor;
>         u32 core_version, config;
> @@ -1159,24 +1161,32 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         }
>
>         /* Setup main peripheral bus clock */
> -       msm_host->pclk = devm_clk_get(&pdev->dev, "iface");
> -       if (IS_ERR(msm_host->pclk)) {
> -               ret = PTR_ERR(msm_host->pclk);
> +       clk = devm_clk_get(&pdev->dev, "iface");
> +       if (IS_ERR(clk)) {
> +               ret = PTR_ERR(clk);
>                 dev_err(&pdev->dev, "Peripheral clk setup failed (%d)\n", ret);
>                 goto bus_clk_disable;
>         }
> -
> -       ret = clk_prepare_enable(msm_host->pclk);
> -       if (ret)
> -               goto bus_clk_disable;
> +       msm_host->bulk_clks[1].clk = clk;
>
>         /* Setup SDC MMC clock */
> -       msm_host->clk = devm_clk_get(&pdev->dev, "core");
> -       if (IS_ERR(msm_host->clk)) {
> -               ret = PTR_ERR(msm_host->clk);
> +       clk = devm_clk_get(&pdev->dev, "core");
> +       if (IS_ERR(clk)) {
> +               ret = PTR_ERR(clk);
>                 dev_err(&pdev->dev, "SDC MMC clk setup failed (%d)\n", ret);
> -               goto pclk_disable;
> +               goto bus_clk_disable;
>         }
> +       msm_host->bulk_clks[0].clk = clk;
> +
> +       /* Vote for maximum clock rate for maximum performance */
> +       ret = clk_set_rate(clk, INT_MAX);
> +       if (ret)
> +               dev_warn(&pdev->dev, "core clock boost failed\n");
> +
> +       ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
> +                                     msm_host->bulk_clks);
> +       if (ret)
> +               goto bus_clk_disable;
>
>         /*
>          * xo clock is needed for FLL feature of cm_dll.
> @@ -1188,15 +1198,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>                 dev_warn(&pdev->dev, "TCXO clk not present (%d)\n", ret);
>         }
>
> -       /* Vote for maximum clock rate for maximum performance */
> -       ret = clk_set_rate(msm_host->clk, INT_MAX);
> -       if (ret)
> -               dev_warn(&pdev->dev, "core clock boost failed\n");
> -
> -       ret = clk_prepare_enable(msm_host->clk);
> -       if (ret)
> -               goto pclk_disable;
> -
>         core_memres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>         msm_host->core_mem = devm_ioremap_resource(&pdev->dev, core_memres);
>
> @@ -1289,9 +1290,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         pm_runtime_set_suspended(&pdev->dev);
>         pm_runtime_put_noidle(&pdev->dev);
>  clk_disable:
> -       clk_disable_unprepare(msm_host->clk);
> -pclk_disable:
> -       clk_disable_unprepare(msm_host->pclk);
> +       clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
> +                                  msm_host->bulk_clks);
>  bus_clk_disable:
>         if (!IS_ERR(msm_host->bus_clk))
>                 clk_disable_unprepare(msm_host->bus_clk);
> @@ -1314,8 +1314,8 @@ static int sdhci_msm_remove(struct platform_device *pdev)
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_put_noidle(&pdev->dev);
>
> -       clk_disable_unprepare(msm_host->clk);
> -       clk_disable_unprepare(msm_host->pclk);
> +       clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
> +                                  msm_host->bulk_clks);
>         if (!IS_ERR(msm_host->bus_clk))
>                 clk_disable_unprepare(msm_host->bus_clk);
>         sdhci_pltfm_free(pdev);
> @@ -1329,8 +1329,8 @@ static int sdhci_msm_runtime_suspend(struct device *dev)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>
> -       clk_disable_unprepare(msm_host->clk);
> -       clk_disable_unprepare(msm_host->pclk);
> +       clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
> +                                  msm_host->bulk_clks);
>
>         return 0;
>  }
> @@ -1340,21 +1340,9 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> -       int ret;
>
> -       ret = clk_prepare_enable(msm_host->clk);
> -       if (ret) {
> -               dev_err(dev, "clk_enable failed for core_clk: %d\n", ret);
> -               return ret;
> -       }
> -       ret = clk_prepare_enable(msm_host->pclk);
> -       if (ret) {
> -               dev_err(dev, "clk_enable failed for iface_clk: %d\n", ret);
> -               clk_disable_unprepare(msm_host->clk);
> -               return ret;
> -       }
> -
> -       return 0;
> +       return clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
> +                                      msm_host->bulk_clks);
>  }
>  #endif
>
> --
> 2.12.0
>
