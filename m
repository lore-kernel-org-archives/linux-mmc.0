Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4A9C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Apr 2022 21:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiD0Vtn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiD0Vtl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2022 17:49:41 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0778F1AE
        for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2022 14:46:28 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 17so4402410lji.1
        for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2022 14:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRHuTXzQ+1NgPTdxEopZECMQlox4N1mLnfz6FSwXE2s=;
        b=ValsQrjZlwAJVkQ/B7AjYoNl5G8MjY1dxVIhU8GcOchvqVG5nKXU9Dz6Lf7iLxurI1
         YZgF1Erm6Lj/i0AAaQ9wfj1S2MD+hbxO6HiIdeRN8QS4qdlZZ6ckR+j/KnYGbwl04qxC
         ETvrmT7xBBs2GK50dR+7aQkXnImgGhkjFcq5AT1aj28ldjMsilzv8wQq9I9Qpr0jrblQ
         DXfYsA24zYmuoDkUHvSh6czS/amSxktjeu4UEIN3I+izksKzhD4cOGh9p0bDsCYhussU
         sQZkg43ir8epitYexje3eqSs7A9ir5+Lm8h7x0+5Ga4OK19kLJJ/JervSTUVpIKfTAr+
         khTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRHuTXzQ+1NgPTdxEopZECMQlox4N1mLnfz6FSwXE2s=;
        b=d88j1TLEPnuZPRb7b1xJHa32VAwqvTKvWZcOc48mkhamiG6XoyLgdJ5cUVcCNPvP+C
         JChRzO7Y5e2BsJndbd2xH3vZE9ZvuHkkVZf4/TGnwi2JRQKHtLVWhu6hrt0fs7BD83FL
         6sTdBNkQCuKd+eSizFCCLAsu/b9cEPf70k7jS79gv0AbPoMSMPZbgipiGnVLtAr2AmW+
         K8sOCnTr1A2FN9ZCFAEf8GxVf9Nu2QbB5pQWJ9j/HuE6nWw/JtZOMfEnoIppwmy3PVke
         uAsqjIdlHtdYl5Rk2zVLEQi6umb5QjZFD0cSjL9ORhqg+wVJJ+IkMr0mxn6dQTY0pntk
         7qXA==
X-Gm-Message-State: AOAM532ya0Q+TBWXCZg8stkahNkMh/9lFKvcc5dRxOW1vkDc1jgcbjJv
        BjdxPHDBUb2GT9+5UDM8llmDZVuTxkLtvuRv8mZa/uiX2gQ=
X-Google-Smtp-Source: ABdhPJwei2VlHjpnN+qm7rBYLYKYpsjm747RprjDeYPf53d18B4XDYws47JPSLqDjUEqsjh3Ty40h+O/yzVCUbgYXSI=
X-Received: by 2002:a05:6512:2627:b0:44a:f55c:ded9 with SMTP id
 bt39-20020a056512262700b0044af55cded9mr22157634lfb.373.1651095624849; Wed, 27
 Apr 2022 14:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220427180853.35970-1-kdasu.kdev@gmail.com> <20220427180853.35970-3-kdasu.kdev@gmail.com>
In-Reply-To: <20220427180853.35970-3-kdasu.kdev@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Apr 2022 23:39:47 +0200
Message-ID: <CAPDyKFrW7DHzc32BYE5ZiPdOdMWqGo1ch4CZZHaM1jVNjpvpWw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mmc: sdhci-brcmstb: Enable Clock Gating to save power
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 27 Apr 2022 at 20:09, Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> From: Al Cooper <alcooperx@gmail.com>
>
> Enabling this feature will allow the controller to stop the bus
> clock when the bus is idle. The feature is not part of the standard
> and is unique to newer Arasan cores and is enabled with a bit in a
> vendor specific register. This feature will only be enabled for
> non-removable devices because they don't switch the voltage and
> clock gating breaks SD Card volatge switching.

Rather than using a HW specific thing for this, it may be better to
use runtime PM. There are plenty of examples to get inspired from, so
it should be rather easy to implement, I think. More importantly, it
should work for both (e)MMC and SD cards, unless there are some
specific things to manage for this controller.

When it comes to SDIO, some driver simply bumps the runtime PM usage
count (pm_runtime_get_noresume()) to prevent the device from being
runtime suspended. There are ways to work around this, let me know if
you need some guidance around how to fix that too.

That said, I am not entirely opposed to $subject patch, but I wanted
to point out that there are better alternatives.

Kind regards
Uffe

>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 35 +++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 244780481193..683d0c685748 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -17,11 +17,14 @@
>
>  #define SDHCI_VENDOR 0x78
>  #define  SDHCI_VENDOR_ENHANCED_STRB 0x1
> +#define  SDHCI_VENDOR_GATE_SDCLK_EN 0x2
>
>  #define BRCMSTB_MATCH_FLAGS_NO_64BIT           BIT(0)
>  #define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT     BIT(1)
> +#define BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE     BIT(2)
>
>  #define BRCMSTB_PRIV_FLAGS_HAS_CQE             BIT(0)
> +#define BRCMSTB_PRIV_FLAGS_GATE_CLOCK          BIT(1)
>
>  #define SDHCI_ARASAN_CQE_BASE_ADDR             0x200
>
> @@ -36,6 +39,27 @@ struct brcmstb_match_priv {
>         const unsigned int flags;
>  };
>
> +static inline void enable_clock_gating(struct sdhci_host *host)
> +{
> +       u32 reg;
> +
> +       reg = sdhci_readl(host, SDHCI_VENDOR);
> +       reg |= SDHCI_VENDOR_GATE_SDCLK_EN;
> +       sdhci_writel(host, reg, SDHCI_VENDOR);
> +}
> +
> +void brcmstb_reset(struct sdhci_host *host, u8 mask)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +       sdhci_reset(host, mask);
> +
> +       /* Reset will clear this, so re-enable it */
> +       if (priv->flags & BRCMSTB_PRIV_FLAGS_GATE_CLOCK)
> +               enable_clock_gating(host);
> +}
> +
>  static void sdhci_brcmstb_hs400es(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         struct sdhci_host *host = mmc_priv(mmc);
> @@ -131,7 +155,7 @@ static struct sdhci_ops sdhci_brcmstb_ops = {
>  static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
>         .set_clock = sdhci_brcmstb_set_clock,
>         .set_bus_width = sdhci_set_bus_width,
> -       .reset = sdhci_reset,
> +       .reset = brcmstb_reset,
>         .set_uhs_signaling = sdhci_brcmstb_set_uhs_signaling,
>  };
>
> @@ -147,6 +171,7 @@ static struct brcmstb_match_priv match_priv_7445 = {
>  };
>
>  static const struct brcmstb_match_priv match_priv_7216 = {
> +       .flags = BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE,
>         .hs400es = sdhci_brcmstb_hs400es,
>         .ops = &sdhci_brcmstb_ops_7216,
>  };
> @@ -273,6 +298,14 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>         if (res)
>                 goto err;
>
> +       /*
> +        * Automatic clock gating does not work for SD cards that may
> +        * voltage switch so only enable it for non-removable devices.
> +        */
> +       if ((match_priv->flags & BRCMSTB_MATCH_FLAGS_HAS_CLOCK_GATE) &&
> +           (host->mmc->caps & MMC_CAP_NONREMOVABLE))
> +               priv->flags |= BRCMSTB_PRIV_FLAGS_GATE_CLOCK;
> +
>         /*
>          * If the chip has enhanced strobe and it's enabled, add
>          * callback
> --
> 2.17.1
>
