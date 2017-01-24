From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Pass node pointer to mmc_of_parse
Date: Tue, 24 Jan 2017 09:56:55 +0100
Message-ID: <CAPDyKFo+q=eT9fWOkBVFtyHD0Nw1YgH7x4MMTNn_9UPK+FDPww@mail.gmail.com>
References: <20170121105956.13020-1-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170121105956.13020-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 21 January 2017 at 11:59, Jan Glauber <jglauber@cavium.com> wrote:
> Extend mmc_of_parse to get the device node pointer as an
> additional argument instead of using the device node of the
> mmc device.
>
> While this has no effect for the current users it allows
> mmc_of_parse to be used by mmc controllers with multiple slots
> per device. These controllers can then pass the child node of the
> slot.
>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  drivers/mmc/core/host.c            | 8 +++-----
>  drivers/mmc/host/davinci_mmc.c     | 2 +-
>  drivers/mmc/host/dw_mmc.c          | 2 +-
>  drivers/mmc/host/meson-gx-mmc.c    | 2 +-
>  drivers/mmc/host/mmci.c            | 2 +-
>  drivers/mmc/host/moxart-mmc.c      | 2 +-
>  drivers/mmc/host/mtk-sd.c          | 2 +-
>  drivers/mmc/host/mvsdio.c          | 2 +-
>  drivers/mmc/host/mxcmmc.c          | 2 +-
>  drivers/mmc/host/mxs-mmc.c         | 2 +-
>  drivers/mmc/host/omap_hsmmc.c      | 2 +-
>  drivers/mmc/host/sdhci-bcm-kona.c  | 2 +-
>  drivers/mmc/host/sdhci-brcmstb.c   | 2 +-
>  drivers/mmc/host/sdhci-cadence.c   | 2 +-
>  drivers/mmc/host/sdhci-dove.c      | 2 +-
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  drivers/mmc/host/sdhci-iproc.c     | 2 +-
>  drivers/mmc/host/sdhci-msm.c       | 2 +-
>  drivers/mmc/host/sdhci-of-arasan.c | 2 +-
>  drivers/mmc/host/sdhci-of-at91.c   | 2 +-
>  drivers/mmc/host/sdhci-of-esdhc.c  | 2 +-
>  drivers/mmc/host/sdhci-pic32.c     | 2 +-
>  drivers/mmc/host/sdhci-pxav3.c     | 2 +-
>  drivers/mmc/host/sdhci-s3c.c       | 2 +-
>  drivers/mmc/host/sdhci-st.c        | 2 +-
>  drivers/mmc/host/sdhci-tegra.c     | 2 +-
>  drivers/mmc/host/sdhci_f_sdh30.c   | 2 +-
>  drivers/mmc/host/sh_mmcif.c        | 2 +-
>  drivers/mmc/host/sunxi-mmc.c       | 2 +-
>  drivers/mmc/host/tmio_mmc_pio.c    | 2 +-
>  drivers/mmc/host/usdhi6rol0.c      | 2 +-
>  include/linux/mmc/host.h           | 2 +-
>  32 files changed, 34 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 98f25ff..444faac 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -171,25 +171,23 @@ static void mmc_retune_timer(unsigned long data)
>  /**
>   *     mmc_of_parse() - parse host's device-tree node
>   *     @host: host whose node should be parsed.
> + *     @np: node that should be parsed.
>   *
>   * To keep the rest of the MMC subsystem unaware of whether DT has been
>   * used to to instantiate and configure this host instance or not, we
>   * parse the properties and set respective generic mmc-host flags and
>   * parameters.
>   */
> -int mmc_of_parse(struct mmc_host *host)
> +int mmc_of_parse(struct mmc_host *host, struct device_node *np)
>  {
> -       struct device_node *np;
>         u32 bus_width;
>         int ret;
>         bool cd_cap_invert, cd_gpio_invert = false;
>         bool ro_cap_invert, ro_gpio_invert = false;
>
> -       if (!host->parent || !host->parent->of_node)
> +       if (!np)
>                 return 0;
>
> -       np = host->parent->of_node;
> -

This doesn't work because of mmc_of_parse() calls the below functions,
which uses the parent device associated with the mmc host.

1) mmc_gpiod_request_cd()
2) mmc_gpiod_request_ro()
3) mmc_pwrseq_alloc()

Please have a look to see how we can change these first.

One way that might help to simplify the implementation could be to
optionally store the of_node in the mmc host, while it's being
allocated. When it's set, it could indicate we have a child/slot-node.
Just an idea...

Kind regards
Uffe

>         /* "bus-width" is translated to MMC_CAP_*_BIT_DATA flags */
>         if (of_property_read_u32(np, "bus-width", &bus_width) < 0) {
>                 dev_dbg(host->parent,
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 36b5af8..1ce9375 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1257,7 +1257,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
>         match = of_match_device(davinci_mmc_dt_ids, &pdev->dev);
>         if (match) {
>                 pdev->id_entry = match->data;
> -               ret = mmc_of_parse(mmc);
> +               ret = mmc_of_parse(mmc, pdev->dev.of_node);
>                 if (ret) {
>                         dev_err(&pdev->dev,
>                                 "could not parse of data: %d\n", ret);
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index b44306b..0f10000 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2673,7 +2673,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>         if (host->pdata->caps2)
>                 mmc->caps2 = host->pdata->caps2;
>
> -       ret = mmc_of_parse(mmc);
> +       ret = mmc_of_parse(mmc, host->dev->of_node);
>         if (ret)
>                 goto err_host_allocated;
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 0973935..2cfb959 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -740,7 +740,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
>         if (ret == -EPROBE_DEFER)
>                 goto free_host;
>
> -       ret = mmc_of_parse(mmc);
> +       ret = mmc_of_parse(mmc, pdev->dev.of_node);
>         if (ret) {
>                 dev_warn(&pdev->dev, "error parsing DT: %d\n", ret);
>                 goto free_host;
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 01a8047..36bb957 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1505,7 +1505,7 @@ static struct mmc_host_ops mmci_ops = {
>  static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
>  {
>         struct mmci_host *host = mmc_priv(mmc);
> -       int ret = mmc_of_parse(mmc);
> +       int ret = mmc_of_parse(mmc, np);
>
>         if (ret)
>                 return ret;
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index bbad309..c710d4f 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -599,7 +599,7 @@ static int moxart_probe(struct platform_device *pdev)
>                 goto out;
>         }
>
> -       ret = mmc_of_parse(mmc);
> +       ret = mmc_of_parse(mmc, node);
>         if (ret)
>                 goto out;
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 10ef2ae..cdbe76c 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1497,7 +1497,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         host = mmc_priv(mmc);
> -       ret = mmc_of_parse(mmc);
> +       ret = mmc_of_parse(mmc, pdev->dev.of_node);
>         if (ret)
>                 goto host_free;
>
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index 42296e5..614372f 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -750,7 +750,7 @@ static int mvsd_probe(struct platform_device *pdev)
>         mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
>
>         host->base_clock = clk_get_rate(host->clk) / 2;
> -       ret = mmc_of_parse(mmc);
> +       ret = mmc_of_parse(mmc, np);
>         if (ret < 0)
>                 goto out;
>         if (maxfreq)
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index fb3ca82..2d180e0 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1031,7 +1031,7 @@ static int mxcmci_probe(struct platform_device *pdev)
>
>         host->phys_base = res->start;
>
> -       ret = mmc_of_parse(mmc);
> +       ret = mmc_of_parse(mmc, pdev->dev.of_node);
>         if (ret)
>                 goto out_free;
>         mmc->ops = &mxcmci_ops;
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index c8b8ac6..f6bf639 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -649,7 +649,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         mmc->f_min = 400000;
>         mmc->f_max = 288000000;
>
> -       ret = mmc_of_parse(mmc);
> +       ret = mmc_of_parse(mmc, np);
>         if (ret)
>                 goto out_clk_disable;
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index ad11c4c..9f883d2 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2028,7 +2028,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>                 goto err;
>         }
>
> -       ret = mmc_of_parse(mmc);
> +       ret = mmc_of_parse(mmc, pdev->dev.of_node);
>         if (ret)
>                 goto err1;
>
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index 51dd2fd..ad4e129 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -235,7 +235,7 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
>         kona_dev = sdhci_pltfm_priv(pltfm_priv);
>         mutex_init(&kona_dev->write_lock);
>
> -       ret = mmc_of_parse(host->mmc);
> +       ret = mmc_of_parse(host->mmc, dev->of_node);
>         if (ret)
>                 goto err_pltfm_free;
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 159f6f6..2dc77cb 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -90,7 +90,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>         host->mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ;
>
>         sdhci_get_of_property(pdev);
> -       mmc_of_parse(host->mmc);
> +       mmc_of_parse(host->mmc, pdev->dev.of_node);
>
>         /*
>          * Supply the existing CAPS, but clear the UHS modes. This
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 4b0ecb9..20c363a 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -242,7 +242,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         host->ioaddr += SDHCI_CDNS_SRS_BASE;
>         host->mmc_host_ops.execute_tuning = sdhci_cdns_execute_tuning;
>
> -       ret = mmc_of_parse(host->mmc);
> +       ret = mmc_of_parse(host->mmc, pdev->dev.of_node);
>         if (ret)
>                 goto free;
>
> diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
> index de9f960..6b117b6 100644
> --- a/drivers/mmc/host/sdhci-dove.c
> +++ b/drivers/mmc/host/sdhci-dove.c
> @@ -92,7 +92,7 @@ static int sdhci_dove_probe(struct platform_device *pdev)
>         if (!IS_ERR(pltfm_host->clk))
>                 clk_prepare_enable(pltfm_host->clk);
>
> -       ret = mmc_of_parse(host->mmc);
> +       ret = mmc_of_parse(host->mmc, pdev->dev.of_node);
>         if (ret)
>                 goto err_sdhci_add;
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 7123ef9..32288ac 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1098,7 +1098,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>         }
>
>         /* call to generic mmc_of_parse to support additional capabilities */
> -       ret = mmc_of_parse(host->mmc);
> +       ret = mmc_of_parse(host->mmc, np);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index d7046d6..244a167 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -253,7 +253,7 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>
>         iproc_host->data = iproc_data;
>
> -       mmc_of_parse(host->mmc);
> +       mmc_of_parse(host->mmc, pdev->dev.of_node);
>         sdhci_get_of_property(pdev);
>
>         host->mmc->caps |= iproc_host->data->mmc_caps;
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 32879b8..0bd5764 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1066,7 +1066,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         msm_host->mmc = host->mmc;
>         msm_host->pdev = pdev;
>
> -       ret = mmc_of_parse(host->mmc);
> +       ret = mmc_of_parse(host->mmc, pdev->dev.of_node);
>         if (ret)
>                 goto pltfm_free;
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 410a55b..205dae9 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -658,7 +658,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         if (ret)
>                 goto clk_disable_all;
>
> -       ret = mmc_of_parse(host->mmc);
> +       ret = mmc_of_parse(host->mmc, pdev->dev.of_node);
>         if (ret) {
>                 dev_err(&pdev->dev, "parsing dt failed (%u)\n", ret);
>                 goto unreg_clk;
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 2f9ad21..4a335b6 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -260,7 +260,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>         clk_prepare_enable(priv->mainck);
>         clk_prepare_enable(priv->gck);
>
> -       ret = mmc_of_parse(host->mmc);
> +       ret = mmc_of_parse(host->mmc, pdev->dev.of_node);
>         if (ret)
>                 goto clocks_disable_unprepare;
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 9a6eb44..c48eaa1 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -659,7 +659,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
>         }
>
>         /* call to generic mmc_of_parse to support additional capabilities */
> -       ret = mmc_of_parse(host->mmc);
> +       ret = mmc_of_parse(host->mmc, np);
>         if (ret)
>                 goto err;
>
> diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
> index 72c13b6..3703cb4 100644
> --- a/drivers/mmc/host/sdhci-pic32.c
> +++ b/drivers/mmc/host/sdhci-pic32.c
> @@ -189,7 +189,7 @@ static int pic32_sdhci_probe(struct platform_device *pdev)
>                 goto err_base_clk;
>         }
>
> -       ret = mmc_of_parse(host->mmc);
> +       ret = mmc_of_parse(host->mmc, pdev->dev.of_node);
>         if (ret)
>                 goto err_base_clk;
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index d0f5c05..6530c68 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -430,7 +430,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>
>         match = of_match_device(of_match_ptr(sdhci_pxav3_of_match), &pdev->dev);
>         if (match) {
> -               ret = mmc_of_parse(host->mmc);
> +               ret = mmc_of_parse(host->mmc, np);
>                 if (ret)
>                         goto err_of_parse;
>                 sdhci_get_of_property(pdev);
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index de219ca..f34c70b3 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -617,7 +617,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>         pm_runtime_use_autosuspend(&pdev->dev);
>         pm_suspend_ignore_children(&pdev->dev, 1);
>
> -       ret = mmc_of_parse(host->mmc);
> +       ret = mmc_of_parse(host->mmc, pdev->dev.of_node);
>         if (ret)
>                 goto err_req_regs;
>
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index ed92ce72..6cb3f8a 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -388,7 +388,7 @@ static int sdhci_st_probe(struct platform_device *pdev)
>         pdata = sdhci_pltfm_priv(pltfm_host);
>         pdata->rstc = rstc;
>
> -       ret = mmc_of_parse(host->mmc);
> +       ret = mmc_of_parse(host->mmc, np);
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed mmc_of_parse\n");
>                 goto err_of;
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 20b6ff5..1748eb9 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -466,7 +466,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>         tegra_host->pad_calib_required = false;
>         tegra_host->soc_data = soc_data;
>
> -       rc = mmc_of_parse(host->mmc);
> +       rc = mmc_of_parse(host->mmc, pdev->dev.of_node);
>         if (rc)
>                 goto err_parse_dt;
>
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index 111b66f..afb054f 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -126,7 +126,7 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>         host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
>                         SDHCI_QUIRK2_TUNING_WORK_AROUND;
>
> -       ret = mmc_of_parse(host->mmc);
> +       ret = mmc_of_parse(host->mmc, dev->of_node);
>         if (ret)
>                 goto err;
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 9007784..925dc47 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1435,7 +1435,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
>         if (!mmc)
>                 return -ENOMEM;
>
> -       ret = mmc_of_parse(mmc);
> +       ret = mmc_of_parse(mmc, dev->of_node);
>         if (ret < 0)
>                 goto err_host;
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index b1d1303..95772e0 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1253,7 +1253,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>         if (host->cfg->clk_delays)
>                 mmc->caps      |= MMC_CAP_1_8V_DDR;
>
> -       ret = mmc_of_parse(mmc);
> +       ret = mmc_of_parse(mmc, pdev->dev.of_node);
>         if (ret)
>                 goto error_free_dma;
>
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 2064fa1..9db27e7 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1143,7 +1143,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>         if (!res_ctl)
>                 return -EINVAL;
>
> -       ret = mmc_of_parse(mmc);
> +       ret = mmc_of_parse(mmc, pdev->dev.of_node);
>         if (ret < 0)
>                 goto host_free;
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 1bd5f1a..cd728be 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1760,7 +1760,7 @@ static int usdhi6_probe(struct platform_device *pdev)
>         if (ret == -EPROBE_DEFER)
>                 goto e_free_mmc;
>
> -       ret = mmc_of_parse(mmc);
> +       ret = mmc_of_parse(mmc, dev->of_node);
>         if (ret < 0)
>                 goto e_free_mmc;
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 8bc8841..cc6f909 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -401,7 +401,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *);
>  int mmc_add_host(struct mmc_host *);
>  void mmc_remove_host(struct mmc_host *);
>  void mmc_free_host(struct mmc_host *);
> -int mmc_of_parse(struct mmc_host *host);
> +int mmc_of_parse(struct mmc_host *host, struct device_node *);
>
>  static inline void *mmc_priv(struct mmc_host *host)
>  {
> --
> 2.9.0.rc0.21.g7777322
>
