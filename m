From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 6/6] mmc: host: sdhci-sprd: added Spreadtrum's host
 controller R11
Date: Mon, 11 Jun 2018 09:15:03 +0200
Message-ID: <CAPDyKFq5WpLTySEPKjNxXSjz5hpiDGStNQo1pPzNmxy0Y9bpnQ@mail.gmail.com>
References: <1528445893-14530-1-git-send-email-zhang.chunyan@linaro.org> <1528445893-14530-7-git-send-email-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528445893-14530-7-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Billows Wu <billows.wu@spreadtrum.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 8 June 2018 at 10:18, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>
> This patch adds the initial support of Secure Digital Host Controller
> Interface compliant controller - R11 found in some latest Spreadtrum
> chipsets.
>
> R11 is a variant based on SD v4.0 specification.
>
> With this driver, mmc can be initialized, can be mounted, read and
> written.
>
> Original-by: Billows Wu <billows.wu@spreadtrum.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  drivers/mmc/host/Kconfig          |  13 ++
>  drivers/mmc/host/Makefile         |   1 +
>  drivers/mmc/host/sdhci-sprd-r11.c | 472 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 486 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-sprd-r11.c

This is a DT based driver. Please add a separate patch describing the
corresponding bindings and compatibles.

[...]

> +static int sdhci_sprd_get_dt_resource(struct platform_device *pdev,
> +               struct sdhci_sprd_host *sprd_host)
> +{
> +       int ret = 0;
> +       struct clk *clk;
> +
> +       clk = devm_clk_get(&pdev->dev, "sdio");
> +       if (IS_ERR(clk)) {
> +               ret = PTR_ERR(clk);
> +               dev_warn(&pdev->dev, "Failed to get sdio clock (%d)\n", ret);
> +               goto out;
> +       }
> +       sprd_host->clk_sdio = clk;
> +
> +       clk = devm_clk_get(&pdev->dev, "source");
> +       if (IS_ERR(clk)) {
> +               ret = PTR_ERR(clk);
> +               dev_warn(&pdev->dev, "Failed to get source clock (%d)\n", ret);
> +               goto out;
> +       }
> +       sprd_host->clk_source = clk;
> +
> +       clk_set_parent(sprd_host->clk_sdio, sprd_host->clk_source);
> +       sprd_host->base_rate = clk_get_rate(sprd_host->clk_source);
> +       if (!sprd_host->base_rate) {
> +               sprd_host->base_rate = 26000000;
> +               dev_warn(&pdev->dev, "The source clock rate is 0\n");
> +       }
> +

The above can be managed by the assigned-clock* DT bindings. Please
have a look at:

Documentation/devicetree/bindings/clock/clock-bindings.txt
drivers/clk/clk-conf.c

> +       clk = devm_clk_get(&pdev->dev, "enable");
> +       if (IS_ERR(clk)) {
> +               ret = PTR_ERR(clk);
> +               dev_warn(&pdev->dev, "Failed to get gate clock (%d)\n", ret);

The printed name of the clock doesn't match the name used in
devm_clk_get() call.

BTW, I think devm_clk_get() already prints some information when it
fails to lookup a clock. Isn't that sufficient?

> +               goto out;
> +       }
> +       sprd_host->clk_enable = clk;
> +
> +out:
> +       return ret;
> +}
> +
> +static void sdhci_sprd_set_mmc_struct(struct platform_device *pdev,
> +                               struct mmc_host *mmc)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct sdhci_host *host = mmc_priv(mmc);
> +
> +       mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
> +               MMC_CAP_ERASE | MMC_CAP_CMD23;
> +
> +       mmc_of_parse(mmc);
> +       mmc_of_parse_voltage(np, &host->ocr_mask);

mmc_of_parse_voltage() is intended to be used for controllers that
internally manages the powered to the card. Is that really the case?

I assume you have external regulator(s) to manage that, no?

> +
> +       mmc->ocr_avail = 0x40000;
> +       mmc->ocr_avail_sdio = mmc->ocr_avail;
> +       mmc->ocr_avail_sd = mmc->ocr_avail;
> +       mmc->ocr_avail_mmc = mmc->ocr_avail;

If there is external regulators used, all the above can go away. In
either case, at least the *_sdio, *_sd, *_mmc can go away.

> +
> +       mmc->max_current_330 = SDHCI_SPRD_MAX_CUR;
> +       mmc->max_current_300 = SDHCI_SPRD_MAX_CUR;
> +       mmc->max_current_180 = SDHCI_SPRD_MAX_CUR;

This should probably also be fetched used an external regulator and
sdhci already manages that.

> +
> +       host->dma_mask = DMA_BIT_MASK(64);
> +       mmc_dev(host->mmc)->dma_mask = &host->dma_mask;
> +}

[...]

> +
> +static unsigned int sdhci_sprd_get_min_clock(struct sdhci_host *host)
> +{
> +       return 400000;
> +}

Isn't there a more straightforward way to assign the minimum clock
rate? Do you really need to use a callback?

> +
> +static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
> +{
> +       sdhci_reset(host, mask);
> +}

Looks like an unnecessary wrapper function.

[...]

> +static int sdhci_sprd_probe(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host;
> +       struct sdhci_sprd_host *sprd_host;
> +       int ret = 0;
> +
> +       host = sdhci_pltfm_init(pdev, &sdhci_sprd_pdata, sizeof(*sprd_host));
> +       if (IS_ERR(host))
> +               return PTR_ERR(host);
> +
> +       sprd_host = TO_SPRD_HOST(host);
> +
> +       ret = sdhci_sprd_get_dt_resource(pdev, sprd_host);
> +       if (ret)
> +               goto pltfm_free;
> +
> +       clk_prepare_enable(sprd_host->clk_sdio);
> +       clk_prepare_enable(sprd_host->clk_enable);
> +
> +       sdhci_sprd_init_config(host);
> +
> +       sdhci_sprd_set_mmc_struct(pdev, host->mmc);
> +
> +       host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
> +       sprd_host->version = ((host->version & SDHCI_VENDOR_VER_MASK) >>
> +                              SDHCI_VENDOR_VER_SHIFT);
> +
> +       pm_runtime_get_noresume(&pdev->dev);
> +       pm_runtime_set_active(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +       pm_runtime_use_autosuspend(&pdev->dev);
> +       pm_suspend_ignore_children(&pdev->dev, 1);
> +
> +       ret = sdhci_add_host(host);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to add mmc host: %d\n", ret);
> +               goto pm_runtime_disable;
> +       }
> +

Looks like there is a missing call to pm_runtime_put() here, no?

Unless it's intentional to prevent runtime suspend, for whatever reasons!?

> +       return 0;
> +
> +pm_runtime_disable:
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_set_suspended(&pdev->dev);
> +
> +       clk_disable_unprepare(sprd_host->clk_sdio);
> +       clk_disable_unprepare(sprd_host->clk_enable);
> +
> +pltfm_free:
> +       sdhci_pltfm_free(pdev);
> +       return ret;
> +}
> +
> +static int sdhci_sprd_remove(struct platform_device *pdev)
> +{
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
> +       struct mmc_host *mmc = host->mmc;
> +
> +       mmc_remove_host(mmc);
> +       clk_disable_unprepare(sprd_host->clk_sdio);
> +       clk_disable_unprepare(sprd_host->clk_enable);
> +
> +       mmc_free_host(mmc);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id sdhci_sprd_of_match[] = {
> +       { .compatible = "sprd,sdhc-r11", },

As stated, don't forget to document this.

[...]

Kind regards
Uffe
