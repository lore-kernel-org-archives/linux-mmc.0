Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D779C433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  4 May 2022 10:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348253AbiEDKly (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 May 2022 06:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348246AbiEDKlq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2022 06:41:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FB62981B
        for <linux-mmc@vger.kernel.org>; Wed,  4 May 2022 03:38:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x17so1572972lfa.10
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2022 03:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XBJL7r+MhOc1BUfYTC5dYyhYGOwhJC3R47akkKaHBhc=;
        b=Fo5AXmN/C9QxzJ3Br7JOpUqk0j/RXcupl0BTw4Wjrni6hP5OsoaOjEZPE5GLHab9Nj
         NVL03NB2wkxvM/WPcfG7U4JTYW33wRpdC71XSCVTbIZBaUGXfLhoYP4IdiIJ3vsHy0sI
         xABLKlbnXknC9hrKxk1mmM79O50UC10y6NvSF2mYBU/AThLosW9RlODxmsmGA5UmSeZb
         8XRBd1U4zy5omXK4KkyMk9gh0Zu2Mu3XTs2mGbDBxJRvde2WYdYdLpbEYvJAiI0KV5wo
         +k/yWICRuu3r7o3ug/a00HmOOQOvFy07WZfE6L+EzmcgCQwtEHza4wH5mpbVcCu5kX6Y
         oVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XBJL7r+MhOc1BUfYTC5dYyhYGOwhJC3R47akkKaHBhc=;
        b=6+jlEVntlWSiBro05FnXedwqRyhJ+0RoddqMHB5WVxoH8ejOGzx1XoTnMzZ1uMlAY2
         AMdTj8QScyIHS8SchKm/cUapctbbZ4q2uqJwcwYqkwVdFsb2QN1uvt6z3bGz2Qb8UELm
         hHFvAVIqKH/cjZf44SeYhOQ0b1cJsCpj9Jraac/ibpzvZIXh817WIpm2oM8Q+O9m/1h9
         BUxCqtemXuaudHpQ/TAlJL8j/JXGVkYNAbFb8zLq/43rDORI+N0KHrLjxi3ePlu1fB/f
         w3ZNdqGxTxYKR8/BZ/SiFt3QTj9zKOwJ4LVwcynLWkj8ym9RGxAj2RVK80o+QZM6EHIR
         72tw==
X-Gm-Message-State: AOAM533EYy4J1xXh6wbfcIAVRcl0EKvNobMpjcsImduxSJW2xwrGLiC+
        3z4wYC3unDuR1jVikigAwBGhq1gnn9mzntQjD4bkqQ==
X-Google-Smtp-Source: ABdhPJxu7Qr1Izlnvgua2MSHSApJlcpDAyH2jMtBfmDOQ8muty6GPyrHmpy94VO5tD5GxcemtgfjQihNmYTK28kcVIc=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr14619429lfr.233.1651660689847; Wed, 04
 May 2022 03:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220427180853.35970-1-kdasu.kdev@gmail.com> <20220427180853.35970-3-kdasu.kdev@gmail.com>
In-Reply-To: <20220427180853.35970-3-kdasu.kdev@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:33 +0200
Message-ID: <CAPDyKFrnZoy4ifWzDt3A6DJP_LHU2mohtFVN3n7rhhK6bjDOFA@mail.gmail.com>
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
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


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
