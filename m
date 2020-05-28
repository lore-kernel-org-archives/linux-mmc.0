Return-Path: <SRS0=dyeO=7K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843D0C433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D6D20DD4
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 10:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J14crb2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbgE1KPB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 May 2020 06:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387769AbgE1KOz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 May 2020 06:14:55 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004E4C08C5C6
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:14:54 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id r11so6594279vkf.11
        for <linux-mmc@vger.kernel.org>; Thu, 28 May 2020 03:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nAUj/kEpfoZ0ia6NxEX2fFXuOIBIRYCGa6eSme4RY3s=;
        b=J14crb2jF9tUh4DBD+9prVqZRXyqwpMPCCoiq3C3clPk+7pQSKNtaR/dtNcGVhrm1Z
         wftbzhxx4VuNfR7Mj0qLKISYCIIasNLr2ZQsftLNmlDjOoP8vd9joIw9yMvacBmtXXPd
         OL/pO/Xvy1+3hSIR+kmwzL4wqUa1geIwnkH3/rNO8Ioh9RhU0VwOkYEvaEAFBz0sqTMo
         EuPdF7vQtph678iNA6gvkTv8eeOmT65lGS12wyibdgNvUqsa1hGh4cqd7+PWCpfvz0r/
         A4zIleIdI2x90N3u2yZF5fe2gE/Osg8/AWGrmNx+JniMxHitmIWAiimEp/94GiqtDN2w
         IXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nAUj/kEpfoZ0ia6NxEX2fFXuOIBIRYCGa6eSme4RY3s=;
        b=YGU5Rv4azd4W7P7GxX34LMWYzfH+zxY/6lDJ8sghVu9B+YYLWrR3/N5h0yfkAmVAIZ
         xYqqniJ4CO5uScJ3EQU8U0HAu4ur9z127Oj+aetqmRRgzziytOBlOubm8j6tXZRGhRyV
         NvU521gwX3yi2ByBhMQtyeCAkuEi1LUQIEcOfJvFaySpQ8cJBOTnwfHaQ/CyJmbrvaqB
         EQ709crR01GEFp1SBXJcDuFTU5kyhLenJMAv9oDddiz4mGFtlR7YOnWQ/nsZsM05IEB6
         0FSdD1VP43iTFaEXGxIF3fE/W/6mSKf212BoVpBGZNXvGmEHHnEC5Z6jXXhoU8Yy/dL5
         4+8g==
X-Gm-Message-State: AOAM5331b4p2h29UD3eKjVZJilahF8gSh4RncCzkvZTs5piBwKe/hKr6
        JJERrsJFiG3MJPvY1yEl255k2z8DKM3ftPreXc2vAQ==
X-Google-Smtp-Source: ABdhPJxH0XoMIdAuMN9qtVZvUJ9sj6A/MlzwZDxbfNcwdSU12eGT1pIEGZkSv3XqTj/sGL9tbJEEdxMOaMo/Gu1xFtw=
X-Received: by 2002:a1f:1188:: with SMTP id 130mr1448071vkr.25.1590660894032;
 Thu, 28 May 2020 03:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200526062758.17642-1-wan.ahmad.zainie.wan.mohamad@intel.com> <20200526062758.17642-3-wan.ahmad.zainie.wan.mohamad@intel.com>
In-Reply-To: <20200526062758.17642-3-wan.ahmad.zainie.wan.mohamad@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:14:16 +0200
Message-ID: <CAPDyKFr+u5vzTJAdKR6RzKOxPMiMzpVX9Zs4hms_CYnG2S6fVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: sdhci-of-arasan: Add support for Intel Keem Bay
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 May 2020 at 08:29, Wan Ahmad Zainie
<wan.ahmad.zainie.wan.mohamad@intel.com> wrote:
>
> Intel Keem Bay SoC eMMC/SD/SDIO controller is based on
> Arasan SD 3.0 / eMMC 5.1 host controller IP.
>
> However, it does not support 64-bit access as its AXI interface
> has 32-bit address ports.
>
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 123 +++++++++++++++++++++++++++++
>  1 file changed, 123 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 2fe2c4dcc280..db9b544465cd 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -75,6 +75,7 @@ struct sdhci_arasan_soc_ctl_field {
>   *
>   * @baseclkfreq:       Where to find corecfg_baseclkfreq
>   * @clockmultiplier:   Where to find corecfg_clockmultiplier
> + * @support64b:                Where to find SUPPORT64B bit
>   * @hiword_update:     If true, use HIWORD_UPDATE to access the syscon
>   *
>   * It's up to the licensee of the Arsan IP block to make these available
> @@ -84,6 +85,7 @@ struct sdhci_arasan_soc_ctl_field {
>  struct sdhci_arasan_soc_ctl_map {
>         struct sdhci_arasan_soc_ctl_field       baseclkfreq;
>         struct sdhci_arasan_soc_ctl_field       clockmultiplier;
> +       struct sdhci_arasan_soc_ctl_field       support64b;
>         bool                                    hiword_update;
>  };
>
> @@ -180,6 +182,13 @@ static const struct sdhci_arasan_soc_ctl_map intel_lgm_sdxc_soc_ctl_map = {
>         .hiword_update = false,
>  };
>
> +static const struct sdhci_arasan_soc_ctl_map intel_keembay_soc_ctl_map = {
> +       .baseclkfreq = { .reg = 0x0, .width = 8, .shift = 14 },
> +       .clockmultiplier = { .reg = 0x4, .width = 8, .shift = 14 },
> +       .support64b = { .reg = 0x4, .width = 1, .shift = 24 },
> +       .hiword_update = false,
> +};
> +
>  /**
>   * sdhci_arasan_syscon_write - Write to a field in soc_ctl registers
>   *
> @@ -1095,6 +1104,50 @@ static struct sdhci_arasan_of_data sdhci_arasan_generic_data = {
>         .clk_ops = &arasan_clk_ops,
>  };
>
> +static const struct sdhci_pltfm_data sdhci_keembay_emmc_pdata = {
> +       .ops = &sdhci_arasan_cqe_ops,
> +       .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +               SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> +               SDHCI_QUIRK_NO_LED |
> +               SDHCI_QUIRK_32BIT_DMA_ADDR |
> +               SDHCI_QUIRK_32BIT_DMA_SIZE |
> +               SDHCI_QUIRK_32BIT_ADMA_SIZE,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +               SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> +               SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 |
> +               SDHCI_QUIRK2_STOP_WITH_TC |
> +               SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_keembay_sd_pdata = {
> +       .ops = &sdhci_arasan_ops,
> +       .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +               SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> +               SDHCI_QUIRK_NO_LED |
> +               SDHCI_QUIRK_32BIT_DMA_ADDR |
> +               SDHCI_QUIRK_32BIT_DMA_SIZE |
> +               SDHCI_QUIRK_32BIT_ADMA_SIZE,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +               SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> +               SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
> +               SDHCI_QUIRK2_STOP_WITH_TC |
> +               SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_keembay_sdio_pdata = {
> +       .ops = &sdhci_arasan_ops,
> +       .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +               SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> +               SDHCI_QUIRK_NO_LED |
> +               SDHCI_QUIRK_32BIT_DMA_ADDR |
> +               SDHCI_QUIRK_32BIT_DMA_SIZE |
> +               SDHCI_QUIRK_32BIT_ADMA_SIZE,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +               SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> +               SDHCI_QUIRK2_HOST_OFF_CARD_ON |
> +               SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
> +};
> +
>  static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
>         .soc_ctl_map = &rk3399_soc_ctl_map,
>         .pdata = &sdhci_arasan_cqe_pdata,
> @@ -1140,6 +1193,21 @@ static struct sdhci_arasan_of_data sdhci_arasan_versal_data = {
>         .clk_ops = &versal_clk_ops,
>  };
>
> +static struct sdhci_arasan_of_data intel_keembay_emmc_data = {
> +       .soc_ctl_map = &intel_keembay_soc_ctl_map,
> +       .pdata = &sdhci_keembay_emmc_pdata,
> +};
> +
> +static struct sdhci_arasan_of_data intel_keembay_sd_data = {
> +       .soc_ctl_map = &intel_keembay_soc_ctl_map,
> +       .pdata = &sdhci_keembay_sd_pdata,
> +};
> +
> +static struct sdhci_arasan_of_data intel_keembay_sdio_data = {
> +       .soc_ctl_map = &intel_keembay_soc_ctl_map,
> +       .pdata = &sdhci_keembay_sdio_pdata,
> +};
> +
>  static const struct of_device_id sdhci_arasan_of_match[] = {
>         /* SoC-specific compatible strings w/ soc_ctl_map */
>         {
> @@ -1154,6 +1222,18 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>                 .compatible = "intel,lgm-sdhci-5.1-sdxc",
>                 .data = &intel_lgm_sdxc_data,
>         },
> +       {
> +               .compatible = "intel,keembay-sdhci-5.1-emmc",
> +               .data = &intel_keembay_emmc_data,
> +       },
> +       {
> +               .compatible = "intel,keembay-sdhci-5.1-sd",
> +               .data = &intel_keembay_sd_data,
> +       },
> +       {
> +               .compatible = "intel,keembay-sdhci-5.1-sdio",
> +               .data = &intel_keembay_sdio_data,
> +       },
>         /* Generic compatible below here */
>         {
>                 .compatible = "arasan,sdhci-8.9a",
> @@ -1297,6 +1377,40 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
>         of_clk_del_provider(dev->of_node);
>  }
>
> +/**
> + * sdhci_arasan_update_support64b - Set SUPPORT_64B (64-bit System Bus Support)
> + *
> + * This should be set based on the System Address Bus.
> + * 0: the Core supports only 32-bit System Address Bus.
> + * 1: the Core supports 64-bit System Address Bus.
> + *
> + * NOTES:
> + * - For Keem Bay, it is required to clear this bit. Its default value is 1'b1.
> + *   Keem Bay does not support 64-bit access.
> + *
> + * @host               The sdhci_host
> + */
> +static void sdhci_arasan_update_support64b(struct sdhci_host *host, u32 value)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +       const struct sdhci_arasan_soc_ctl_map *soc_ctl_map =
> +               sdhci_arasan->soc_ctl_map;
> +
> +       /* Having a map is optional */
> +       if (!soc_ctl_map)
> +               return;
> +
> +       /* If we have a map, we expect to have a syscon */
> +       if (!sdhci_arasan->soc_ctl_base) {
> +               pr_warn("%s: Have regmap, but no soc-ctl-syscon\n",
> +                       mmc_hostname(host->mmc));
> +               return;
> +       }
> +
> +       sdhci_arasan_syscon_write(host, &soc_ctl_map->support64b, value);
> +}
> +
>  /**
>   * sdhci_arasan_register_sdclk - Register the sdcardclk for a PHY to use
>   *
> @@ -1469,6 +1583,15 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                                     "rockchip,rk3399-sdhci-5.1"))
>                 sdhci_arasan_update_clockmultiplier(host, 0x0);
>
> +       if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-emmc") ||
> +           of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd") ||
> +           of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio")) {
> +               sdhci_arasan_update_clockmultiplier(host, 0x0);
> +               sdhci_arasan_update_support64b(host, 0x0);
> +
> +               host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> +       }
> +
>         sdhci_arasan_update_baseclkfreq(host);
>
>         ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, &pdev->dev);
> --
> 2.17.1
>
