Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C21C433E6
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 10:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7841D619BB
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 10:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCXKVz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Mar 2021 06:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbhCXKVh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Mar 2021 06:21:37 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15E9C061763
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 03:21:36 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id c2so7688853uaj.3
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7apWozlOt2FqRFycW0Hur3TIoMg6mDhSrYsqHBdsqD4=;
        b=hGdgJIzrda8kSnAFgL4/2AUpL5DTF8JT9DcD9XJSSpJprxaISt3xgyXRR3jSTS8hG5
         uL4YqQ/0t1Wc4rlLCIuHzW2N0vlvtZQcUqKEXndQDVU8y9ab7HORaN2ubRe0VbcnfiF7
         SWAF2+YXtocGRkfGZPFjC88QArPPOgUXpu5lNHGECtxP/9a6i8uiLSTQh/ldr9aO6OU6
         Z8x+8pP+FbqFtXh2Lr1o9Z2lpL8IjqMDs/Dyk351DYp+IgUrv9G6/kEQV6+BsfmBMqYm
         NhKE8+zdjIas5GNlgwbqdTrMbWauhdm9//jvwQXb4FC9hqIXfrtUfXnrSw4lqBzQUiRW
         ySYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7apWozlOt2FqRFycW0Hur3TIoMg6mDhSrYsqHBdsqD4=;
        b=sPkBswwsdO8un7nf8EqSsmUOIpBmZoOjKGHHT3mTmAkOkunJEfS+3XuEjXUI4JaGXJ
         658CiOMy1lH0/KLX9Wb8arHv7erjNwfYNwbnewbeEva0JmhNLz/KF9j4NdFE/MCV2A6B
         5oV791p+q7jlXc8u6I0fGfdnucwNUTQDcrWC8OmJMRucRKNR+XdsTR7t6yBWavXLIfNR
         NuUbaxKY6IUoc0RxVTd5SYMWT3+1rgPDGqXicxpKRd0qDdQMmL7bAmehsp+vnTXFrlVq
         frz4e8puKXwprAYOUtf8alC8FCyw9mFj4YKNEFp0mCdmIgn8mS8jiduOJCyf+Ct5VZzu
         kz2g==
X-Gm-Message-State: AOAM531RDv4p1wmf+bTA5BMrqrdgKTrXA3xxLS3OszMTbSNDSOyz/Uwc
        FfOki++EUqgFJ74O+mf2/ZV0ghVAbiVzjoXNuyFtIg==
X-Google-Smtp-Source: ABdhPJx11OsxN0jvvUTrVF43kL0pyJRkssrUH5DhNuWjNKYwMbxeLZCTPogRmz6xHOov1pAOQN7zV2LeS3TnJLPKDIA=
X-Received: by 2002:a9f:2843:: with SMTP id c61mr952901uac.129.1616581295909;
 Wed, 24 Mar 2021 03:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210324155013.1e5faa3c@xhacker.debian>
In-Reply-To: <20210324155013.1e5faa3c@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Mar 2021 11:20:59 +0100
Message-ID: <CAPDyKFpau=FRCupREsgZiwFv-XRhH04si1wKiEPwM4K2+fct1w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: replace mmc->parent with mmc_dev() for consistency
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Angelo Dureghello <angelo.dureghello@timesys.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 24 Mar 2021 at 08:50, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> As pointed out by Ulf, "both "mmc->parent" and mmc_dev(mmc) are being
> used in the entire c-file". Convert all the mmc->parent usage in all
> sdhci host driver to mmc_dev() for consistency.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-mcf.c |  8 +++----
>  drivers/mmc/host/sdhci-of-aspeed.c |  2 +-
>  drivers/mmc/host/sdhci-tegra.c     | 34 +++++++++++++++---------------
>  drivers/mmc/host/sdhci.c           | 24 ++++++++++-----------
>  drivers/mmc/host/sdhci_am654.c     |  2 +-
>  5 files changed, 35 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
> index ca7a1690b2a8..05926bf5ecf9 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -367,14 +367,14 @@ static int esdhc_mcf_plat_init(struct sdhci_host *host,
>                                struct pltfm_mcf_data *mcf_data)
>  {
>         struct mcf_esdhc_platform_data *plat_data;
> +       struct device *dev = mmc_dev(host->mmc);
>
> -       if (!host->mmc->parent->platform_data) {
> -               dev_err(mmc_dev(host->mmc), "no platform data!\n");
> +       if (!dev->platform_data) {
> +               dev_err(dev, "no platform data!\n");
>                 return -EINVAL;
>         }
>
> -       plat_data = (struct mcf_esdhc_platform_data *)
> -                       host->mmc->parent->platform_data;
> +       plat_data = (struct mcf_esdhc_platform_data *)dev->platform_data;
>
>         /* Card_detect */
>         switch (plat_data->cd_type) {
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 7d8692e90996..d001c51074a0 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -181,7 +181,7 @@ aspeed_sdhci_configure_phase(struct sdhci_host *host, unsigned long rate)
>         struct aspeed_sdhci *sdhci;
>         struct device *dev;
>
> -       dev = host->mmc->parent;
> +       dev = mmc_dev(host->mmc);
>         sdhci = sdhci_pltfm_priv(sdhci_priv(host));
>
>         if (!sdhci->phase_desc)
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 41d193fa77bb..c61f797a853f 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -596,49 +596,49 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>                         &tegra_host->autocal_offsets;
>         int err;
>
> -       err = device_property_read_u32(host->mmc->parent,
> +       err = device_property_read_u32(mmc_dev(host->mmc),
>                         "nvidia,pad-autocal-pull-up-offset-3v3",
>                         &autocal->pull_up_3v3);
>         if (err)
>                 autocal->pull_up_3v3 = 0;
>
> -       err = device_property_read_u32(host->mmc->parent,
> +       err = device_property_read_u32(mmc_dev(host->mmc),
>                         "nvidia,pad-autocal-pull-down-offset-3v3",
>                         &autocal->pull_down_3v3);
>         if (err)
>                 autocal->pull_down_3v3 = 0;
>
> -       err = device_property_read_u32(host->mmc->parent,
> +       err = device_property_read_u32(mmc_dev(host->mmc),
>                         "nvidia,pad-autocal-pull-up-offset-1v8",
>                         &autocal->pull_up_1v8);
>         if (err)
>                 autocal->pull_up_1v8 = 0;
>
> -       err = device_property_read_u32(host->mmc->parent,
> +       err = device_property_read_u32(mmc_dev(host->mmc),
>                         "nvidia,pad-autocal-pull-down-offset-1v8",
>                         &autocal->pull_down_1v8);
>         if (err)
>                 autocal->pull_down_1v8 = 0;
>
> -       err = device_property_read_u32(host->mmc->parent,
> +       err = device_property_read_u32(mmc_dev(host->mmc),
>                         "nvidia,pad-autocal-pull-up-offset-sdr104",
>                         &autocal->pull_up_sdr104);
>         if (err)
>                 autocal->pull_up_sdr104 = autocal->pull_up_1v8;
>
> -       err = device_property_read_u32(host->mmc->parent,
> +       err = device_property_read_u32(mmc_dev(host->mmc),
>                         "nvidia,pad-autocal-pull-down-offset-sdr104",
>                         &autocal->pull_down_sdr104);
>         if (err)
>                 autocal->pull_down_sdr104 = autocal->pull_down_1v8;
>
> -       err = device_property_read_u32(host->mmc->parent,
> +       err = device_property_read_u32(mmc_dev(host->mmc),
>                         "nvidia,pad-autocal-pull-up-offset-hs400",
>                         &autocal->pull_up_hs400);
>         if (err)
>                 autocal->pull_up_hs400 = autocal->pull_up_1v8;
>
> -       err = device_property_read_u32(host->mmc->parent,
> +       err = device_property_read_u32(mmc_dev(host->mmc),
>                         "nvidia,pad-autocal-pull-down-offset-hs400",
>                         &autocal->pull_down_hs400);
>         if (err)
> @@ -653,7 +653,7 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>         if (!(tegra_host->soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL))
>                 return;
>
> -       err = device_property_read_u32(host->mmc->parent,
> +       err = device_property_read_u32(mmc_dev(host->mmc),
>                         "nvidia,pad-autocal-pull-up-offset-3v3-timeout",
>                         &autocal->pull_up_3v3_timeout);
>         if (err) {
> @@ -664,7 +664,7 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>                 autocal->pull_up_3v3_timeout = 0;
>         }
>
> -       err = device_property_read_u32(host->mmc->parent,
> +       err = device_property_read_u32(mmc_dev(host->mmc),
>                         "nvidia,pad-autocal-pull-down-offset-3v3-timeout",
>                         &autocal->pull_down_3v3_timeout);
>         if (err) {
> @@ -675,7 +675,7 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>                 autocal->pull_down_3v3_timeout = 0;
>         }
>
> -       err = device_property_read_u32(host->mmc->parent,
> +       err = device_property_read_u32(mmc_dev(host->mmc),
>                         "nvidia,pad-autocal-pull-up-offset-1v8-timeout",
>                         &autocal->pull_up_1v8_timeout);
>         if (err) {
> @@ -686,7 +686,7 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>                 autocal->pull_up_1v8_timeout = 0;
>         }
>
> -       err = device_property_read_u32(host->mmc->parent,
> +       err = device_property_read_u32(mmc_dev(host->mmc),
>                         "nvidia,pad-autocal-pull-down-offset-1v8-timeout",
>                         &autocal->pull_down_1v8_timeout);
>         if (err) {
> @@ -720,17 +720,17 @@ static void tegra_sdhci_parse_tap_and_trim(struct sdhci_host *host)
>         struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
>         int err;
>
> -       err = device_property_read_u32(host->mmc->parent, "nvidia,default-tap",
> +       err = device_property_read_u32(mmc_dev(host->mmc), "nvidia,default-tap",
>                                        &tegra_host->default_tap);
>         if (err)
>                 tegra_host->default_tap = 0;
>
> -       err = device_property_read_u32(host->mmc->parent, "nvidia,default-trim",
> +       err = device_property_read_u32(mmc_dev(host->mmc), "nvidia,default-trim",
>                                        &tegra_host->default_trim);
>         if (err)
>                 tegra_host->default_trim = 0;
>
> -       err = device_property_read_u32(host->mmc->parent, "nvidia,dqs-trim",
> +       err = device_property_read_u32(mmc_dev(host->mmc), "nvidia,dqs-trim",
>                                        &tegra_host->dqs_trim);
>         if (err)
>                 tegra_host->dqs_trim = 0x11;
> @@ -741,7 +741,7 @@ static void tegra_sdhci_parse_dt(struct sdhci_host *host)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
>
> -       if (device_property_read_bool(host->mmc->parent, "supports-cqe"))
> +       if (device_property_read_bool(mmc_dev(host->mmc), "supports-cqe"))
>                 tegra_host->enable_hwcq = true;
>         else
>                 tegra_host->enable_hwcq = false;
> @@ -1529,7 +1529,7 @@ static int sdhci_tegra_add_host(struct sdhci_host *host)
>
>         host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
>
> -       cq_host = devm_kzalloc(host->mmc->parent,
> +       cq_host = devm_kzalloc(mmc_dev(host->mmc),
>                                 sizeof(*cq_host), GFP_KERNEL);
>         if (!cq_host) {
>                 ret = -ENOMEM;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index aefd0441658c..bf238ade1602 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -188,7 +188,7 @@ static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
>         if (host->bus_on)
>                 return;
>         host->bus_on = true;
> -       pm_runtime_get_noresume(host->mmc->parent);
> +       pm_runtime_get_noresume(mmc_dev(host->mmc));
>  }
>
>  static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
> @@ -196,7 +196,7 @@ static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
>         if (!host->bus_on)
>                 return;
>         host->bus_on = false;
> -       pm_runtime_put_noidle(host->mmc->parent);
> +       pm_runtime_put_noidle(mmc_dev(host->mmc));
>  }
>
>  void sdhci_reset(struct sdhci_host *host, u8 mask)
> @@ -648,7 +648,7 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
>                         }
>                 }
>                 /* Switch ownership to the DMA */
> -               dma_sync_single_for_device(host->mmc->parent,
> +               dma_sync_single_for_device(mmc_dev(host->mmc),
>                                            host->bounce_addr,
>                                            host->bounce_buffer_size,
>                                            mmc_get_dma_dir(data));
> @@ -1176,7 +1176,7 @@ static int sdhci_external_dma_init(struct sdhci_host *host)
>         int ret = 0;
>         struct mmc_host *mmc = host->mmc;
>
> -       host->tx_chan = dma_request_chan(mmc->parent, "tx");
> +       host->tx_chan = dma_request_chan(mmc_dev(mmc), "tx");
>         if (IS_ERR(host->tx_chan)) {
>                 ret = PTR_ERR(host->tx_chan);
>                 if (ret != -EPROBE_DEFER)
> @@ -1185,7 +1185,7 @@ static int sdhci_external_dma_init(struct sdhci_host *host)
>                 return ret;
>         }
>
> -       host->rx_chan = dma_request_chan(mmc->parent, "rx");
> +       host->rx_chan = dma_request_chan(mmc_dev(mmc), "rx");
>         if (IS_ERR(host->rx_chan)) {
>                 if (host->tx_chan) {
>                         dma_release_channel(host->tx_chan);
> @@ -2489,14 +2489,14 @@ void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>         unsigned long flags;
>
>         if (enable)
> -               pm_runtime_get_noresume(mmc->parent);
> +               pm_runtime_get_noresume(mmc_dev(mmc));
>
>         spin_lock_irqsave(&host->lock, flags);
>         sdhci_enable_sdio_irq_nolock(host, enable);
>         spin_unlock_irqrestore(&host->lock, flags);
>
>         if (!enable)
> -               pm_runtime_put_noidle(mmc->parent);
> +               pm_runtime_put_noidle(mmc_dev(mmc));
>  }
>  EXPORT_SYMBOL_GPL(sdhci_enable_sdio_irq);
>
> @@ -3063,7 +3063,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
>                                                 length = host->bounce_buffer_size;
>                                         }
>                                         dma_sync_single_for_cpu(
> -                                               host->mmc->parent,
> +                                               mmc_dev(host->mmc),
>                                                 host->bounce_addr,
>                                                 host->bounce_buffer_size,
>                                                 DMA_FROM_DEVICE);
> @@ -3074,7 +3074,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
>                                 } else {
>                                         /* No copying, just switch ownership */
>                                         dma_sync_single_for_cpu(
> -                                               host->mmc->parent,
> +                                               mmc_dev(host->mmc),
>                                                 host->bounce_addr,
>                                                 host->bounce_buffer_size,
>                                                 mmc_get_dma_dir(data));
> @@ -4053,7 +4053,7 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
>          * speedups by the help of a bounce buffer to group scattered
>          * reads/writes together.
>          */
> -       host->bounce_buffer = devm_kmalloc(mmc->parent,
> +       host->bounce_buffer = devm_kmalloc(mmc_dev(mmc),
>                                            bounce_size,
>                                            GFP_KERNEL);
>         if (!host->bounce_buffer) {
> @@ -4067,11 +4067,11 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
>                 return;
>         }
>
> -       host->bounce_addr = dma_map_single(mmc->parent,
> +       host->bounce_addr = dma_map_single(mmc_dev(mmc),
>                                            host->bounce_buffer,
>                                            bounce_size,
>                                            DMA_BIDIRECTIONAL);
> -       ret = dma_mapping_error(mmc->parent, host->bounce_addr);
> +       ret = dma_mapping_error(mmc_dev(mmc), host->bounce_addr);
>         if (ret)
>                 /* Again fall back to max_segs == 1 */
>                 return;
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 7a34649b0754..1fad6e442688 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -558,7 +558,7 @@ static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
>         struct cqhci_host *cq_host;
>         int ret;
>
> -       cq_host = devm_kzalloc(host->mmc->parent, sizeof(struct cqhci_host),
> +       cq_host = devm_kzalloc(mmc_dev(host->mmc), sizeof(struct cqhci_host),
>                                GFP_KERNEL);
>         if (!cq_host)
>                 return -ENOMEM;
> --
> 2.31.0
>
