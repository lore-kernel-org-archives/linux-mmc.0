Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D225C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 17 May 2022 12:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbiEQMuL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 May 2022 08:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiEQMuJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 May 2022 08:50:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60E13F333
        for <linux-mmc@vger.kernel.org>; Tue, 17 May 2022 05:50:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u23so31139548lfc.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 May 2022 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EVRm/vj51NpTG8N0d1uWKEnf2m4vOccLKJEatvY4CvY=;
        b=HPqEVl6mHTXD2CGwVVCFvAIHQuXAirbeik8OpaDcjV7aTd8rBAS5ENZHyOaTcSq1b1
         JVu1JQye6GTJ3uSDFhIsSMVd4bxuiRSE3LJeQba66X6hrjDQhQ5ugqbork16MT+F8V7a
         FPIMh49zuKzHK+9E9L7HhucX86DR9vyZQ2jnc9A8uUjQv7i86GLnQJD3I/6uEHoNyCVt
         Agcxu0GXqY+2gJMgUWMAjv1OEGOmZABu39GTeotD+jpiMFh5/GkIsPNq2kL/jnTZtVMg
         yrWwte7TOXLpObV5iUMKWdAZEoqfvCSAstBPqVJXVvTWSyT5NTFVxuccWARUXDLgHOVj
         MF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVRm/vj51NpTG8N0d1uWKEnf2m4vOccLKJEatvY4CvY=;
        b=wL0BXclATzzQcQASLNgJiqtiNJrDAMpX9UwSgWRlux70YgqvGLgaaBP6HeJU+c5uvE
         NMpVq1185afmnXdDeAWiBWco3iZHxi0f3jJecXwK46yERL+zkNbsiI9S93wZBEpFZNOg
         2F2gJHDkgn9/1Z9L/NIoSaVjLHgGEmRsH0t9gemfF6IHt+6bYj8MwFNSBM2gyMoAqmAs
         aCg8YLXIvFHmQNT51zg9JQvVdWtUCWBh9QQ9UCoJOxQiVvZuK98hsRRZwQgw5+saN3Kj
         XX3ULqNigVanhZyqJy+ze1jgDfQ5jbnxnDyseejfo5hXgqqZFB+N5rmqut49zYm9KgOv
         qOcw==
X-Gm-Message-State: AOAM533mxUvC+VtQegDXLiKBOsyBJF/IL8d490qEAGUuvwp+YLJJpnJ4
        KIbCAP5nZG0231haFfY37qAxzIXZ/JTf9WaDcD0JuI3vzseZKg==
X-Google-Smtp-Source: ABdhPJw5fUw6HQjtaSuIUx2SwtHVlpaXEW+vWZr2pQ3JA/lwEdA3UCJLTIgVcBbEkT2p9Yq54tNuqnoLluCWCl54W98=
X-Received: by 2002:a05:6512:5cb:b0:472:f7e:a5f5 with SMTP id
 o11-20020a05651205cb00b004720f7ea5f5mr16308134lfo.358.1652791807090; Tue, 17
 May 2022 05:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220513201907.36470-1-kdasu.kdev@gmail.com> <20220513201907.36470-3-kdasu.kdev@gmail.com>
In-Reply-To: <20220513201907.36470-3-kdasu.kdev@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 May 2022 14:49:30 +0200
Message-ID: <CAPDyKFpF_Swon5ZBRSq7M5Zq=8wUMa1q=68XfaD+RQqKYgNJVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-brcmstb: Add ability to increase max clock
 rate for 72116b0
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 13 May 2022 at 22:19, Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> From: Al Cooper <alcooperx@gmail.com>
>
> The 72116B0 has improved SDIO controllers that allow the max clock
> rate to be increased from a max of 100MHz to a max of 150MHz. The
> driver will need to get the clock and increase it's default rate
> and override the caps register, that still indicates a max of 100MHz.
> The new clock will be named "sdio_freq" in the DT node's "clock-names"
> list. The driver will use a DT property, "clock-frequency", to

/s/clock-frequency/max-frequency


> enable this functionality and will get the actual rate in MHz
> from the property to allow various speeds to be requested.
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 8eb57de48e0c..a1ffdd3f1640 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -250,6 +250,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>         struct sdhci_pltfm_host *pltfm_host;
>         const struct of_device_id *match;
>         struct sdhci_brcmstb_priv *priv;
> +       struct clk *master_clk;
> +       u32 base_clock_hz = 0;
> +       u32 actual_clock_mhz;
>         struct sdhci_host *host;
>         struct resource *iomem;
>         struct clk *clk;
> @@ -330,6 +333,33 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>         if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
>                 host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>
> +       /* Change the base clock frequency if the DT property exists */
> +       if (device_property_read_u32(&pdev->dev, "max-frequency",
> +                                    &base_clock_hz) != 0)
> +               goto add_host;

The max-frequency DT property is already being parsed by
mmc_of_parse() and the value is put in host->mmc->f_max. You could
probably use that instead, right?

> +
> +       master_clk = devm_clk_get(&pdev->dev, "sdio_freq");
> +       if (IS_ERR(master_clk)) {
> +               dev_warn(&pdev->dev, "Clock for \"sdio_freq\" not found\n");
> +               goto add_host;
> +       } else {
> +               res = clk_prepare_enable(master_clk);
> +               if (res)
> +                       goto err;
> +       }
> +
> +       /* set improved clock rate */
> +       clk_set_rate(master_clk, base_clock_hz);
> +       actual_clock_mhz = clk_get_rate(master_clk) / 1000000;
> +
> +       host->caps &= ~SDHCI_CLOCK_V3_BASE_MASK;
> +       host->caps |= (actual_clock_mhz << SDHCI_CLOCK_BASE_SHIFT);
> +       /* Disable presets because they are now incorrect */
> +       host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> +       dev_dbg(&pdev->dev, "Base Clock Frequency changed to %dMHz\n",
> +               actual_clock_mhz);
> +
> +add_host:
>         res = sdhci_brcmstb_add_host(host, priv);
>         if (res)
>                 goto err;
> --
> 2.17.1
>

Kind regards
Uffe
