Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AF4C28CFB
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AAC464E66
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242983AbhCCBsA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241871AbhCBN5P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2021 08:57:15 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A23C0617AB
        for <linux-mmc@vger.kernel.org>; Tue,  2 Mar 2021 04:55:24 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id c44so6714389uad.12
        for <linux-mmc@vger.kernel.org>; Tue, 02 Mar 2021 04:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3zrRjA7YBWfjokl2Xgay7jI8fNwkayDcVMdDOQenPBE=;
        b=eB0H/6iRKCdIF+Oa3bn+ZIr4IQ+0wFbU1qS3HfP8pz0hVjFqxgyqUHE6GXT+S0dQYQ
         KUC7VJFhqJGzsuMn3pz7EF4xYVXHnwv0zXIeYjyNGVLvzcm2PYGHQO2253NFdI2+/jMg
         cwypZX8eAqKyas19vj9iRHtHue/nFY+WYPnJJx9dVYRWmhYWtHGUANcYOqCmUrYFi08j
         f3uUh+3JRQvg6Ye1+9uyWO0+chtxFdvgDGaItIe7rju/hS+MO+8jb8kFsJw653BU4VIO
         pnT359+ocyREYCvtJhdXNSfeY7dSedDZJkZIOHd1RsWjr+ald6dj6FNBxg4iOQv6aPGj
         9ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zrRjA7YBWfjokl2Xgay7jI8fNwkayDcVMdDOQenPBE=;
        b=bF7wT+GMmWgGQErEihXqx1sA/QE8E0n1G/OW0GymetPnHliNS9lN4ZfqgUZ7z/YFYY
         6pTflPkY7fIMYAhlBBv9qeE9Mp6YIyewUeqLPvMCoyyyGXqTsh8xGJnWj2YBbA02kfmm
         XakacwIa+z2SCVTqfqSMJ5MMwbu5uNCbiI8ygYQYlDpJLR/r7qBBer5waTejhi678YNP
         0zdq9wpQejSHqahFtXSGncYsQqhwgxr/PbEJUD+AWdV5L4mWjzfQskbKeZNE6ezFyEK6
         sqHe5dz5FFldnL2Yx1FiCcHJvf56vmb7a3bR+Ed0/9Q4POtjtF9YdOy1Sza7zH2qEdFF
         E2wg==
X-Gm-Message-State: AOAM533vRxIBbqtqh6M+S/oj9ZrA8zqEklmOp/xVEFfIimPUNg4jBYnz
        kymcC+AcK18X0i9YZAo/yD4HgGyMP4bBVufFv22x3Q==
X-Google-Smtp-Source: ABdhPJxJWRqugaT2ktEGhfcjiMKDkDS0ihuhhne8GvhRwqY4O++ZmWQcUhqiqQ5Acd/8YKjOeH1rxim4P3Yrb7ekaM8=
X-Received: by 2002:ab0:6045:: with SMTP id o5mr10321516ual.100.1614689724060;
 Tue, 02 Mar 2021 04:55:24 -0800 (PST)
MIME-Version: 1.0
References: <1614671217-133008-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1614671217-133008-1-git-send-email-shawn.lin@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 13:54:47 +0100
Message-ID: <CAPDyKFo4NkL5jqpRja6Ekmn1Hqww2fB8fehMBcan8OAPg4UVWw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: add rockchip platform support
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 2 Mar 2021 at 08:48, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> sdhci based synopsys MMC IP is also used on some rockchip platforms,
> so add a basic support here.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 220 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 213 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 59d8d96..959084c 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c

[...]

> +static int rockchip_pltf_init(struct sdhci_host *host, struct dwcmshc_priv *priv)
> +{
> +       int err;
> +
> +       priv->rockchip_clks[0].id = "axi";
> +       priv->rockchip_clks[1].id = "block";
> +       priv->rockchip_clks[2].id = "timer";
> +       err = devm_clk_bulk_get_optional(mmc_dev(host->mmc), ROCKCHIP_MAX_CLKS,
> +                                        priv->rockchip_clks);

These clocks need to be properly described in the DT docs.

> +       if (err) {
> +               dev_err(mmc_dev(host->mmc), "failed to get clocks %d\n", err);
> +               return err;
> +       }
> +
> +       err = clk_bulk_prepare_enable(ROCKCHIP_MAX_CLKS, priv->rockchip_clks);
> +       if (err) {
> +               dev_err(mmc_dev(host->mmc), "failed to enable clocks %d\n", err);
> +               return err;
> +       }
> +
> +       if (of_property_read_u32(mmc_dev(host->mmc)->of_node, "rockchip,txclk-tapnum",
> +                                &priv->txclk_tapnum))
> +               priv->txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
> +
> +       /* Disable cmd conflict check */
> +       sdhci_writel(host, 0x0, DWCMSHC_HOST_CTRL3);
> +       /* Reset previous settings */
> +       sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
> +       sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
> +       {
> +               .compatible = "snps,dwcmshc-sdhci",
> +               .data = &sdhci_dwcmshc_pdata,
> +       },
> +       {
> +               .compatible = "rockchip,dwcmshc-sdhci",
> +               .data = &sdhci_dwcmshc_rk_pdata,
> +       },
> +       {},
> +};

Speaking about DT docs. I have recently started to reject changes to
existing txt based DT docs.

Can you plese convert the existing DT bindings into the yaml formal -
and then add the new compatible for the new Rockchip variant on top?

[...]

Kind regards
Uffe
