Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E50C433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  4 May 2022 10:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348210AbiEDKlp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 May 2022 06:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348230AbiEDKln (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2022 06:41:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20375289AA
        for <linux-mmc@vger.kernel.org>; Wed,  4 May 2022 03:38:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i10so1561970lfg.13
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2022 03:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCUql32Z85QbAjdNmeSKhkBGKRfaobQ3esSmZFQlaVI=;
        b=b82EipzYR66946BQCzgBeRhvSgKu/f2J3JluNKl9n+3IUQadplyKmCw26q1dIxolya
         x5gS9sVwWF4BIz0IH6BdEtwozMOvtd0bVCOzmcYEvXDAy19OchE6V4A1UMquDYbu6b2/
         Bjm7n4KYuv3f9135ewVBXIZc+32tiEPiWqNV32VWIACGs08AKXlOUazWTlSWdQpojbd0
         pcWFSRfIWGiLbFMu6ynQf5myzWUXiSDpnAgssgDHvv91gjqf6AM6xTE3R7nsPdtz8jU0
         sqQXrSx4iF8WishJUYWSDZgrMsSlkjtS2ctlsQR2vwFQO8Yzh9yj9b5WAoBCrk5IxxbN
         TyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCUql32Z85QbAjdNmeSKhkBGKRfaobQ3esSmZFQlaVI=;
        b=prUBJrDsY7wZtXZYTrjzsQT5KRn9j4sXL/yCs3DnObzbgJKnLSXCuZfi8c5TQPxsvH
         6kpBTnk8CW9rlwB65M+s6nZ0nzg7p9DwMQRhHRIEQYqsvIa2WOKtS4J6mXpdVWU9X/R6
         f3TsYTgUdcit28kR7bAcalSNn8z6oAM5JUDqEe9xsE86FnN/pwFe1nO9U5oLkqYndqHV
         rlH3OTT9PPKw9jN5d5+6X54DaEZqMxVvCulNAqmHe+XK3HQENqy+QHAexeVWzDfbfbWe
         /7ADa/ktlxxsp16w1T+x98mis4YOaM6RVeM/KnawhUBcLlBwS/PK0TBHsV0B4+wj6u/B
         cqmg==
X-Gm-Message-State: AOAM533oeCFrlQkTIWM+INPrdDqE/Is9bvSBak905UM1tBHIn2x4hEky
        vBRvDYGyBzHanPgET0Scj4h9domdTPh748BESJSG2w==
X-Google-Smtp-Source: ABdhPJzeIr+314o93x/VndF33IEPYJloviF3mb+cI0vf98H5qVUTu9MMWp10VwrLIsRUESZqHQXxQ/X3V8VHRYraC/U=
X-Received: by 2002:a19:e007:0:b0:44a:a22d:2d49 with SMTP id
 x7-20020a19e007000000b0044aa22d2d49mr13560859lfg.254.1651660685372; Wed, 04
 May 2022 03:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220427180853.35970-1-kdasu.kdev@gmail.com> <20220427180853.35970-2-kdasu.kdev@gmail.com>
In-Reply-To: <20220427180853.35970-2-kdasu.kdev@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:29 +0200
Message-ID: <CAPDyKFpeN4Ax7E+MSr1XBr4mh=fX-eze4d8ECjVAH4zhJ6cqEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mmc: sdhci-brcmstb: Re-organize flags
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
> Re-organize the flags by basing the bit names on the flag that they
> apply to. Also change the "flags" member in the "brcmstb_match_priv"
> struct to const.
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index f24623aac2db..244780481193 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -18,20 +18,22 @@
>  #define SDHCI_VENDOR 0x78
>  #define  SDHCI_VENDOR_ENHANCED_STRB 0x1
>
> -#define BRCMSTB_PRIV_FLAGS_NO_64BIT            BIT(0)
> -#define BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT      BIT(1)
> +#define BRCMSTB_MATCH_FLAGS_NO_64BIT           BIT(0)
> +#define BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT     BIT(1)
> +
> +#define BRCMSTB_PRIV_FLAGS_HAS_CQE             BIT(0)
>
>  #define SDHCI_ARASAN_CQE_BASE_ADDR             0x200
>
>  struct sdhci_brcmstb_priv {
>         void __iomem *cfg_regs;
> -       bool has_cqe;
> +       unsigned int flags;
>  };
>
>  struct brcmstb_match_priv {
>         void (*hs400es)(struct mmc_host *mmc, struct mmc_ios *ios);
>         struct sdhci_ops *ops;
> -       unsigned int flags;
> +       const unsigned int flags;
>  };
>
>  static void sdhci_brcmstb_hs400es(struct mmc_host *mmc, struct mmc_ios *ios)
> @@ -134,13 +136,13 @@ static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
>  };
>
>  static struct brcmstb_match_priv match_priv_7425 = {
> -       .flags = BRCMSTB_PRIV_FLAGS_NO_64BIT |
> -       BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT,
> +       .flags = BRCMSTB_MATCH_FLAGS_NO_64BIT |
> +       BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
>         .ops = &sdhci_brcmstb_ops,
>  };
>
>  static struct brcmstb_match_priv match_priv_7445 = {
> -       .flags = BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT,
> +       .flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
>         .ops = &sdhci_brcmstb_ops,
>  };
>
> @@ -176,7 +178,7 @@ static int sdhci_brcmstb_add_host(struct sdhci_host *host,
>         bool dma64;
>         int ret;
>
> -       if (!priv->has_cqe)
> +       if ((priv->flags & BRCMSTB_PRIV_FLAGS_HAS_CQE) == 0)
>                 return sdhci_add_host(host);
>
>         dev_dbg(mmc_dev(host->mmc), "CQE is enabled\n");
> @@ -225,7 +227,6 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>         struct sdhci_brcmstb_priv *priv;
>         struct sdhci_host *host;
>         struct resource *iomem;
> -       bool has_cqe = false;
>         struct clk *clk;
>         int res;
>
> @@ -244,10 +245,6 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>                 return res;
>
>         memset(&brcmstb_pdata, 0, sizeof(brcmstb_pdata));
> -       if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
> -               has_cqe = true;
> -               match_priv->ops->irq = sdhci_brcmstb_cqhci_irq;
> -       }
>         brcmstb_pdata.ops = match_priv->ops;
>         host = sdhci_pltfm_init(pdev, &brcmstb_pdata,
>                                 sizeof(struct sdhci_brcmstb_priv));
> @@ -258,7 +255,10 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>
>         pltfm_host = sdhci_priv(host);
>         priv = sdhci_pltfm_priv(pltfm_host);
> -       priv->has_cqe = has_cqe;
> +       if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
> +               priv->flags |= BRCMSTB_PRIV_FLAGS_HAS_CQE;
> +               match_priv->ops->irq = sdhci_brcmstb_cqhci_irq;
> +       }
>
>         /* Map in the non-standard CFG registers */
>         iomem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> @@ -287,14 +287,14 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>          * properties through mmc_of_parse().
>          */
>         host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> -       if (match_priv->flags & BRCMSTB_PRIV_FLAGS_NO_64BIT)
> +       if (match_priv->flags & BRCMSTB_MATCH_FLAGS_NO_64BIT)
>                 host->caps &= ~SDHCI_CAN_64BIT;
>         host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>         host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
>                          SDHCI_SUPPORT_DDR50);
>         host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
>
> -       if (match_priv->flags & BRCMSTB_PRIV_FLAGS_BROKEN_TIMEOUT)
> +       if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
>                 host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>
>         res = sdhci_brcmstb_add_host(host, priv);
> --
> 2.17.1
>
