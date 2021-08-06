Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EC1C4338F
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 13:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF7F60EEA
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 13:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbhHFNGx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Aug 2021 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbhHFNGx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Aug 2021 09:06:53 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D03C061799
        for <linux-mmc@vger.kernel.org>; Fri,  6 Aug 2021 06:06:37 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id bg4so5177437vsb.6
        for <linux-mmc@vger.kernel.org>; Fri, 06 Aug 2021 06:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNHkxBimwZ6Jh8WXRWXbNnhP/dPnhpFJMNiTGn9qTtg=;
        b=LYI5PnJT3RUxp9wDoBeVQkNxLzQXFX/cosiPt6l+YdPQlcdBwlQP3ZxmoX0KLHLESH
         rcHbLlv2mHbUf/5uV9Ir1MD3sXlk3KXNjK49vVrD/pE6xbscxSZ22pWYNQFHV88elTB1
         4iCjPw6nLaUE8oVVkltpF8WL6Pt3MUEV0+TI8b8qNd6T5EMgnK3kDgY17lnu9MLFs1DA
         skzELY6JzdOsXJy2/KbXinHkzhWWU70N0TUqeOq/lbEykjvDCZkYzfjOAmaa5RGMKJeq
         ItFX60cAhggdeFBKMf6k73IKJzPYKLOtdntTBxIinYtVxsNLm4et087M1pKosP/J7hKl
         preQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNHkxBimwZ6Jh8WXRWXbNnhP/dPnhpFJMNiTGn9qTtg=;
        b=eXhhxrkZxNpja01M2D53a9GQg2WPIh0ZtFoKjruAaN0fNNZd0kPo7xOSRGPFISRPCu
         1wdnnDz1FMMCt2nQRk5/DZAPjG8eYYS+Z6UYHzDlJ9GvLha947pOvoB/Xt9dY/d7XgvS
         5vncI7MMMXKCRnD1tE38fV7JewIGdMYh2MKuz9RiePEZ7Wlc0JeRDakVH32GHlCqUcTN
         tmS7f8g/LHavF+XPyANuug1Z3vYg1cF98lhRpuPDWInA5TCXq5Ze34QKyl6wRq2FLffR
         9RN2OnXqEe9ME0UViZ/eTXaoQCPGMnNSljp3nlEHdJymNnxVnPitnxJ7FBykyEOMiDbT
         RL3w==
X-Gm-Message-State: AOAM531OslJ7/C/PVXL7D3QEoo/y+JIkQnC6bcWqNjv48PMperjEidUV
        IUt/c1yBwrqKsZiBEYR5gzMh7Gh/p+ISBXWXithCCg==
X-Google-Smtp-Source: ABdhPJx7LQQ+qPQvXevHz49FTYEayCd9sFB68rW6zgcqcR0ElsNX5LPKVGqHH+cM85lbgA/GVPwxHYheJZhzMzDbZyw=
X-Received: by 2002:a67:7c14:: with SMTP id x20mr9059463vsc.42.1628255196328;
 Fri, 06 Aug 2021 06:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210730063309.8194-1-rashmi.a@intel.com> <20210730063309.8194-3-rashmi.a@intel.com>
In-Reply-To: <20210730063309.8194-3-rashmi.a@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Aug 2021 15:06:00 +0200
Message-ID: <CAPDyKFqZ-H3+OnYyyY7y611YrRAAMFq+W65DMfM4wSNvY_fzjA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-of-arasan: Add intel Thunder Bay SOC
 support to the arasan eMMC driver
To:     rashmi.a@intel.com
Cc:     linux-drivers-review-request@eclists.intel.com,
        Michal Simek <michal.simek@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon <kishon@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-phy@lists.infradead.org, Mark Gross <mgross@linux.intel.com>,
        kris.pan@linux.intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com,
        Adrian Hunter <adrian.hunter@intel.com>,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        kenchappa.demakkanavar@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 30 Jul 2021 at 08:33, <rashmi.a@intel.com> wrote:
>
> From: Rashmi A <rashmi.a@intel.com>
>
> Intel Thunder Bay SoC eMMC controller is based on Arasan
> eMMC 5.1 host controller IP
>
> Signed-off-by: Rashmi A <rashmi.a@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Rashmi, is it safe to apply this separately from the phy driver/dt
changes? Then I can queue this via my mmc tree, if you like.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 839965f7c717..6f202fb7a546 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -185,6 +185,13 @@ static const struct sdhci_arasan_soc_ctl_map intel_lgm_sdxc_soc_ctl_map = {
>         .hiword_update = false,
>  };
>
> +static const struct sdhci_arasan_soc_ctl_map thunderbay_soc_ctl_map = {
> +       .baseclkfreq = { .reg = 0x0, .width = 8, .shift = 14 },
> +       .clockmultiplier = { .reg = 0x4, .width = 8, .shift = 14 },
> +       .support64b = { .reg = 0x4, .width = 1, .shift = 24 },
> +       .hiword_update = false,
> +};
> +
>  static const struct sdhci_arasan_soc_ctl_map intel_keembay_soc_ctl_map = {
>         .baseclkfreq = { .reg = 0x0, .width = 8, .shift = 14 },
>         .clockmultiplier = { .reg = 0x4, .width = 8, .shift = 14 },
> @@ -430,6 +437,15 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>                         SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  };
>
> +static const struct sdhci_pltfm_data sdhci_arasan_thunderbay_pdata = {
> +       .ops = &sdhci_arasan_cqe_ops,
> +       .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN | SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +               SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> +               SDHCI_QUIRK2_STOP_WITH_TC |
> +               SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
> +};
> +
>  #ifdef CONFIG_PM_SLEEP
>  /**
>   * sdhci_arasan_suspend - Suspend method for the driver
> @@ -1098,6 +1114,12 @@ static struct sdhci_arasan_of_data sdhci_arasan_generic_data = {
>         .clk_ops = &arasan_clk_ops,
>  };
>
> +static const struct sdhci_arasan_of_data sdhci_arasan_thunderbay_data = {
> +       .soc_ctl_map = &thunderbay_soc_ctl_map,
> +       .pdata = &sdhci_arasan_thunderbay_pdata,
> +       .clk_ops = &arasan_clk_ops,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_keembay_emmc_pdata = {
>         .ops = &sdhci_arasan_cqe_ops,
>         .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> @@ -1231,6 +1253,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>                 .compatible = "intel,keembay-sdhci-5.1-sdio",
>                 .data = &intel_keembay_sdio_data,
>         },
> +       {
> +               .compatible = "intel,thunderbay-sdhci-5.1",
> +               .data = &sdhci_arasan_thunderbay_data,
> +       },
>         /* Generic compatible below here */
>         {
>                 .compatible = "arasan,sdhci-8.9a",
> @@ -1582,7 +1608,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>
>         if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-emmc") ||
>             of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd") ||
> -           of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio")) {
> +           of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sdio") ||
> +           of_device_is_compatible(np, "intel,thunderbay-sdhci-5.1")) {
>                 sdhci_arasan_update_clockmultiplier(host, 0x0);
>                 sdhci_arasan_update_support64b(host, 0x0);
>
> --
> 2.17.1
>
