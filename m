Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE24C433E5
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 10:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEC6619F7
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 10:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhCXKVw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Mar 2021 06:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhCXKV0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Mar 2021 06:21:26 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF64C0613DE
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 03:21:25 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id 124so11038928vsg.12
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oclPmDUoiD7lVtqYFaeAKVJ4MgENgI/TTup1xZ2DUh0=;
        b=foH1MXFg/S6iNbrzbS/RPr3xu+uWLYvPLzwyBtolaqVdFNiKnS9Olbao5Kw3seqEnk
         x1/tPI6XP/J9b1J3DIOhJwbmQKU7wXz9ESGENNw737F9G/OhhMtVU21tyw2LJzl8W45d
         5dTuTJ4E/X60GlkTV0Znu/pxINQjh6lCDwgbmH40EgV/CGlqOzRdJ+Q/w4nzbDSLarY4
         u4xism6XcJw0aOPLqEZ796RsXTHejm/+JysCCEFSA9+aze6b8TtoCayVpq6BQ/4tJcON
         HOrG5yvUtXsTZKTn2Oox0ElykA11xXBMzgADJkhqec0Hw/cGP71Pqb9FzAFWXZgr5DFU
         kUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oclPmDUoiD7lVtqYFaeAKVJ4MgENgI/TTup1xZ2DUh0=;
        b=qRuh1iczQOo5x2obV5TreGem44/xDrTzaiOfLTpBK2xwY7oqFDYi/I1ym7ENDIPiKc
         XKiIPalzSAZUOe8k0jtTawMoIZgvn7IoHt5u44B8C45717L2h7kxuICdBkwLrOLmXbMj
         mpoJ0Lq8dBwsrX22a/BlYrdyGViGaof4/3rXAv6rSE0j93mJXsIW0y4nDK3JzK0fAsPg
         ltjJcrYXwhEuKgDZfUlQwVAEF6w55yU00eQbMPAZUbNnGLZOUzEX4J3o2BBSEIcrld0z
         GHPfuy3YV2Ji6kf5gkAFnGZvmlXUWTLDWHQNQwl1LDSP3FG4flHbXQS7VISagkxgpCvb
         e19g==
X-Gm-Message-State: AOAM531QQBlZwJGr3HMRLqLQMG5zgMox5zC//lrN71xN6Mv8UZTMQDB7
        YnPUUBGWsgctipNWY9H34VB45Q1MnJPDKyx/6FY97w==
X-Google-Smtp-Source: ABdhPJzf627vcZrgVxPa3vsOwxYzgZwf4l4cR51TZvbQ8vIlb+sLfccF/lA4W8DLrnB3/JPdhuf4m+37yqFN56JNEwg=
X-Received: by 2002:a05:6102:7b0:: with SMTP id x16mr1027973vsg.34.1616581284604;
 Wed, 24 Mar 2021 03:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <b62a68d1f8488e7f95befc6723ba5c20d6781628.1615487235.git.limings@nvidia.com>
 <1616453211-275165-1-git-send-email-limings@nvidia.com>
In-Reply-To: <1616453211-275165-1-git-send-email-limings@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Mar 2021 11:20:48 +0100
Message-ID: <CAPDyKFp1kiH-MtRdeDv4bTgV1t_habswCBGR8shw0xMUQJ65-g@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-of-dwcmshc: add ACPI support for
 BlueField-3 SoC
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 Mar 2021 at 23:47, Liming Sun <limings@nvidia.com> wrote:
>
> This commit adds ACPI support in the sdhci-of-dwcmshc driver for
> BlueField-3 SoC. It has changes to only use the clock hierarchy
> for Deviec Tree since the clk is not supported by ACPI. Instead,
> ACPI can define 'clock-frequency' which is parsed by existing
> sdhci_get_property(). This clock value will be returned in function
> dwcmshc_get_max_clock().
>
> Signed-off-by: Liming Sun <limings@nvidia.com>
> Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2->v3:
>    Rebase to mmc next.
> v1->v2:
>    Changes for comments from Adrian Hunter <adrian.hunter@intel.com>:
>    - Make changes in sdhci-of-dwcmshc instead.
> v1: Initial version which was done in sdhci-acpi.c
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 50 ++++++++++++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 0687368..1113a56 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -7,6 +7,7 @@
>   * Author: Jisheng Zhang <jszhang@kernel.org>
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/iopoll.h>
> @@ -94,6 +95,16 @@ static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
>         sdhci_adma_write_desc(host, desc, addr, len, cmd);
>  }
>
> +static unsigned int dwcmshc_get_max_clock(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +       if (pltfm_host->clk)
> +               return sdhci_pltfm_clk_get_max_clock(host);
> +       else
> +               return pltfm_host->clock;
> +}
> +
>  static void dwcmshc_check_auto_cmd23(struct mmc_host *mmc,
>                                      struct mmc_request *mrq)
>  {
> @@ -248,7 +259,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>         .set_clock              = sdhci_set_clock,
>         .set_bus_width          = sdhci_set_bus_width,
>         .set_uhs_signaling      = dwcmshc_set_uhs_signaling,
> -       .get_max_clock          = sdhci_pltfm_clk_get_max_clock,
> +       .get_max_clock          = dwcmshc_get_max_clock,
>         .reset                  = sdhci_reset,
>         .adma_write_desc        = dwcmshc_adma_write_desc,
>  };
> @@ -323,8 +334,16 @@ static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
>
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id sdhci_dwcmshc_acpi_ids[] = {
> +       { .id = "MLNXBF30" },
> +       {}
> +};
> +#endif
> +
>  static int dwcmshc_probe(struct platform_device *pdev)
>  {
> +       struct device *dev = &pdev->dev;
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_host *host;
>         struct dwcmshc_priv *priv;
> @@ -347,7 +366,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         /*
>          * extra adma table cnt for cross 128M boundary handling.
>          */
> -       extra = DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_128M);
> +       extra = DIV_ROUND_UP_ULL(dma_get_required_mask(dev), SZ_128M);
>         if (extra > SDHCI_MAX_SEGS)
>                 extra = SDHCI_MAX_SEGS;
>         host->adma_table_cnt += extra;
> @@ -355,19 +374,21 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         pltfm_host = sdhci_priv(host);
>         priv = sdhci_pltfm_priv(pltfm_host);
>
> -       pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
> -       if (IS_ERR(pltfm_host->clk)) {
> -               err = PTR_ERR(pltfm_host->clk);
> -               dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
> -               goto free_pltfm;
> -       }
> -       err = clk_prepare_enable(pltfm_host->clk);
> -       if (err)
> -               goto free_pltfm;
> +       if (dev->of_node) {
> +               pltfm_host->clk = devm_clk_get(dev, "core");
> +               if (IS_ERR(pltfm_host->clk)) {
> +                       err = PTR_ERR(pltfm_host->clk);
> +                       dev_err(dev, "failed to get core clk: %d\n", err);
> +                       goto free_pltfm;
> +               }
> +               err = clk_prepare_enable(pltfm_host->clk);
> +               if (err)
> +                       goto free_pltfm;
>
> -       priv->bus_clk = devm_clk_get(&pdev->dev, "bus");
> -       if (!IS_ERR(priv->bus_clk))
> -               clk_prepare_enable(priv->bus_clk);
> +               priv->bus_clk = devm_clk_get(dev, "bus");
> +               if (!IS_ERR(priv->bus_clk))
> +                       clk_prepare_enable(priv->bus_clk);
> +       }
>
>         err = mmc_of_parse(host->mmc);
>         if (err)
> @@ -489,6 +510,7 @@ static int dwcmshc_resume(struct device *dev)
>                 .name   = "sdhci-dwcmshc",
>                 .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>                 .of_match_table = sdhci_dwcmshc_dt_ids,
> +               .acpi_match_table = ACPI_PTR(sdhci_dwcmshc_acpi_ids),
>                 .pm = &dwcmshc_pmops,
>         },
>         .probe  = dwcmshc_probe,
> --
> 1.8.3.1
>
