Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E4FC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 09:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BC42087D
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 09:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wBmCFjpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgHUJEZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHUJEX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Aug 2020 05:04:23 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F19C061385
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 02:04:22 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id z12so334447uam.12
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 02:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2Wycv6dlh4JHdEGRJm+oTyIIhKKDR8J4RT5cAMpHCE=;
        b=wBmCFjpNyW1NbttW/zQ9pNhl0OzqNZ9Ji4r4seZgFcoABo5/ZIkG0bQ+Kd5Ca+shdl
         6m6xxUzKKImbAO2I9tVMvDH4nZvXiXQ+3jTr/YoVtfwNM+IdcgMKJzWKYG2ZZHEbaUYn
         o93Vt53clrRp5Z65+IP4ymq09QSzU1hFXeSH6Z2j4fiK11j9oIT75G17G85aljI73H/A
         oQBOQjfhyssB+OSvltNSFiA9SqQs8l7RqKG6Pf6Drgad6+aT0nU0csY0hW4mb45CtMpp
         388qu1+ayPiD35WFPmDB0WgB4man17dRk00brvM1WAFVL2WVh+Ap8lLmu2hg/d1LiEoZ
         fp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2Wycv6dlh4JHdEGRJm+oTyIIhKKDR8J4RT5cAMpHCE=;
        b=Ts/buz5OUxv9zOmTVNSFEuEUL4TQNGDhtvhLH4ERpoNKxF8p/BnZI82u7XBNYCu69J
         ktVzYEKRZfrHHzdKIw3eKggdhGJHBQ2PIDACI2ljR/AaE4+AQNvsdpo5CFSyFlB65bxX
         vY8jt6yCz4LVK8h2BiJtIu6MDMdK232CCTM5yjPC1kQ4emm8CsmritYBuI4hN1FF0sto
         u3CJCsfltUIujoIjcxbM95ICNt66bk/sbzhq/5tJp26/ocOI/3QnFoU6gxTZO92xN4Pa
         88WnPaMvgeii2/D1vlhneu9mb9cOwW/G1BjswhZcJVkzq2M9R7KyfMV2AdwkRQw+OTUr
         W3Uw==
X-Gm-Message-State: AOAM532fwKKHP3p+tBldw/NLQRi/p+tR6yFp3JyWIN7Afj4rBaWwZ0pM
        MLCy0dLMHqlf63dNsXz1hYoj8jZZK9PvPb91T8tw3ICX7etnBA==
X-Google-Smtp-Source: ABdhPJwt0HzwG8DvvttKDpTdVFqLQyH7D0Ky0GBxrM3d4XgN+IrW8bcFWQqmW4mcjJOtv4U0XObr9M6cDyhwwxI9Zos=
X-Received: by 2002:ab0:65c3:: with SMTP id n3mr885863uaq.100.1598000662170;
 Fri, 21 Aug 2020 02:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200819121848.16967-1-adrian.hunter@intel.com>
In-Reply-To: <20200819121848.16967-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 11:03:46 +0200
Message-ID: <CAPDyKFpJmsi72FyxCZcP=WcJ3spprWrq08pF1t4rhPf8TwD8mQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Fix SDHCI_RESET_ALL for CQHCI for Intel
 GLK-based controllers
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Ramuthevar Vadivel Muruganx 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Ritesh Harjani <riteshh@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 19 Aug 2020 at 14:19, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> For Intel controllers, SDHCI_RESET_ALL resets also CQHCI registers.
> Normally, SDHCI_RESET_ALL is not used while CQHCI is enabled, but that can
> happen on the error path. e.g. if mmc_cqe_recovery() fails, mmc_blk_reset()
> is called which, for a eMMC that does not support HW Reset, will cycle the
> bus power and the driver will perform SDHCI_RESET_ALL.
>
> So whenever performing SDHCI_RESET_ALL ensure CQHCI is deactivated.
> That will force the driver to reinitialize CQHCI when it is next used.
>
> A similar change was done already for sdhci-msm, and other drivers using
> CQHCI might benefit from a similar change, if they also have CQHCI reset
> by SDHCI_RESET_ALL.
>
> Fixes: 8ee82bda230fc9 ("mmc: sdhci-pci: Add CQHCI support for Intel GLK")
> Cc: stable@vger.kernel.org # 5.4.x: 0ffa6cfbd949: mmc: cqhci: Add cqhci_deactivate()
> Cc: stable@vger.kernel.org # 5.4+
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index c0e081e48d3f..d0c8d39d5dbd 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -234,6 +234,14 @@ static void sdhci_pci_dumpregs(struct mmc_host *mmc)
>         sdhci_dumpregs(mmc_priv(mmc));
>  }
>
> +static void sdhci_cqhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +       if ((host->mmc->caps2 & MMC_CAP2_CQE) && (mask & SDHCI_RESET_ALL) &&
> +           host->mmc->cqe_private)
> +               cqhci_deactivate(host->mmc);
> +       sdhci_reset(host, mask);
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Hardware specific quirk handling                                          *
> @@ -722,7 +730,7 @@ static const struct sdhci_ops sdhci_intel_glk_ops = {
>         .set_power              = sdhci_intel_set_power,
>         .enable_dma             = sdhci_pci_enable_dma,
>         .set_bus_width          = sdhci_set_bus_width,
> -       .reset                  = sdhci_reset,
> +       .reset                  = sdhci_cqhci_reset,
>         .set_uhs_signaling      = sdhci_set_uhs_signaling,
>         .hw_reset               = sdhci_pci_hw_reset,
>         .irq                    = sdhci_cqhci_irq,
> --
> 2.17.1
>
