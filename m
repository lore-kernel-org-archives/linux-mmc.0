Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4742FEB64DD
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Jul 2023 11:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbjGMLGy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbjGMLGv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2023 07:06:51 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2BB2691
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:06:46 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a04e5baffcso537133b6e.3
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246406; x=1691838406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zbUK0+KNfrljZMGdgezGa1VL09M/PuMCUQ4epk9qz0M=;
        b=HRrK+UjkOE9au7uixJmgJoJJwdJJw80q2zzyGjawwloFE9dAYM7WQ8ry/KwjoAIPGn
         y0xHA1iL/6AosK+IUCmOr+ttHAEMZSDeaHPpLW7BokW3BKOR7vewcX5eFnXYmGtOFYXn
         qWuiiINC5LresbHCXNrVqryHTfHVyI1WG5gsGcfArUiSxRa9n3xmg03wpVZqndWT0frb
         L97zBjgIc6z1RoaxMXS1UDmdEcoE65iSJdFgo3/Uxt5rfRaeXPLhHGfALG0c+HCJjzl/
         0dCyysqqrWp/3Ck62qZPhpYygAJX1sZGfBPmK2H/SRoD4rS/cBsnok2+/D2ITNNqI2GV
         MOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246406; x=1691838406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbUK0+KNfrljZMGdgezGa1VL09M/PuMCUQ4epk9qz0M=;
        b=YCoTsy7/brIM5cpmPc0jAWxi87dozOiCvm7vLFhpNcO572RC6cdW45e+nAm+UMaSQi
         4BLuNMFoINlnfps0n6a3zCFE5/01BohES80MjpEtN9IWd5pbtVWAKtrl19gzTLze2GJz
         fL/zmt+Dr4n7RervZMrv1RAupaKozEQ1SW4wZS67dWZI5i+7w61ix213wxCt08OY46Dp
         5YwYTS6Cy/wWfeH917wMfQ+CEUPXULsq0BtdqCkjZEO6LGkCUkZXHxJe9crSowmCNcAc
         9XNLnv09JGe5gMJFVyO8XkJCT1Q4sRF4Zi0BlO4myRcDFBIgMBbeR71KYTqxetYVM84F
         svXg==
X-Gm-Message-State: ABy/qLbEN4u1BtColKEmiCgAm6jqDtLm+CHBpUCw9pp5DPXFOPVwjgiW
        oN1iaGay2/oJSAFMTWnDYqacPGUTKz84mRI4eDzIOqS2dWhAxVPe
X-Google-Smtp-Source: APBJJlH87jC6lHbK8IaI52Wr3SdxRDpbsQG0LS30do7Cik4nP1JSk/l2B0BiEbVR5NI/+S1TDJt37YbwSqC5TFuaRSs=
X-Received: by 2002:aca:6c1:0:b0:3a1:f237:ec62 with SMTP id
 184-20020aca06c1000000b003a1f237ec62mr1189805oig.48.1689246405987; Thu, 13
 Jul 2023 04:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230630004533.26644-1-hayashi.kunihiko@socionext.com>
In-Reply-To: <20230630004533.26644-1-hayashi.kunihiko@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 13:06:10 +0200
Message-ID: <CAPDyKFqJU3VwXJJDQPWvNBDz1+gSjYxFJBST3s8mpJoh7-c9-Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-f-sdh30: Replace with sdhci_pltfm
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 30 Jun 2023 at 02:45, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Even if sdhci_pltfm_pmops is specified for PM, this driver doesn't apply
> sdhci_pltfm, so the structure is not correctly referenced in PM functions.
> This applies sdhci_pltfm to this driver to fix this issue.
>
> - Call sdhci_pltfm_init() instead of sdhci_alloc_host() and
>   other functions that covered by sdhci_pltfm.
> - Move ops and quirks to sdhci_pltfm_data
> - Replace sdhci_priv() with own private function sdhci_f_sdh30_priv().
>
> Fixes: 87a507459f49 ("mmc: sdhci: host: add new f_sdh30")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Or maybe this should go for fixes and have a stable tag too?

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_f_sdh30.c | 60 ++++++++++++++------------------
>  1 file changed, 27 insertions(+), 33 deletions(-)
>
> Changes since v1:
> - Add Fixes and Acked-by tags
>
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index a202a69a4b08..b01ffb4d0973 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -29,9 +29,16 @@ struct f_sdhost_priv {
>         bool enable_cmd_dat_delay;
>  };
>
> +static void *sdhci_f_sdhost_priv(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +       return sdhci_pltfm_priv(pltfm_host);
> +}
> +
>  static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
>  {
> -       struct f_sdhost_priv *priv = sdhci_priv(host);
> +       struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
>         u32 ctrl = 0;
>
>         usleep_range(2500, 3000);
> @@ -64,7 +71,7 @@ static unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
>
>  static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
>  {
> -       struct f_sdhost_priv *priv = sdhci_priv(host);
> +       struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
>         u32 ctl;
>
>         if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0)
> @@ -95,30 +102,32 @@ static const struct sdhci_ops sdhci_f_sdh30_ops = {
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>
> +static const struct sdhci_pltfm_data sdhci_f_sdh30_pltfm_data = {
> +       .ops = &sdhci_f_sdh30_ops,
> +       .quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
> +               | SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
> +       .quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE
> +               |  SDHCI_QUIRK2_TUNING_WORK_AROUND,
> +};
> +
>  static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>  {
>         struct sdhci_host *host;
>         struct device *dev = &pdev->dev;
> -       int irq, ctrl = 0, ret = 0;
> +       int ctrl = 0, ret = 0;
>         struct f_sdhost_priv *priv;
> +       struct sdhci_pltfm_host *pltfm_host;
>         u32 reg = 0;
>
> -       irq = platform_get_irq(pdev, 0);
> -       if (irq < 0)
> -               return irq;
> -
> -       host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
> +       host = sdhci_pltfm_init(pdev, &sdhci_f_sdh30_pltfm_data,
> +                               sizeof(struct f_sdhost_priv));
>         if (IS_ERR(host))
>                 return PTR_ERR(host);
>
> -       priv = sdhci_priv(host);
> +       pltfm_host = sdhci_priv(host);
> +       priv = sdhci_pltfm_priv(pltfm_host);
>         priv->dev = dev;
>
> -       host->quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
> -                      SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
> -       host->quirks2 = SDHCI_QUIRK2_SUPPORT_SINGLE |
> -                       SDHCI_QUIRK2_TUNING_WORK_AROUND;
> -
>         priv->enable_cmd_dat_delay = device_property_read_bool(dev,
>                                                 "fujitsu,cmd-dat-delay-select");
>
> @@ -126,18 +135,6 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err;
>
> -       platform_set_drvdata(pdev, host);
> -
> -       host->hw_name = "f_sdh30";
> -       host->ops = &sdhci_f_sdh30_ops;
> -       host->irq = irq;
> -
> -       host->ioaddr = devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(host->ioaddr)) {
> -               ret = PTR_ERR(host->ioaddr);
> -               goto err;
> -       }
> -
>         if (dev_of_node(dev)) {
>                 sdhci_get_of_property(pdev);
>
> @@ -204,24 +201,21 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>  err_clk:
>         clk_disable_unprepare(priv->clk_iface);
>  err:
> -       sdhci_free_host(host);
> +       sdhci_pltfm_free(pdev);
> +
>         return ret;
>  }
>
>  static int sdhci_f_sdh30_remove(struct platform_device *pdev)
>  {
>         struct sdhci_host *host = platform_get_drvdata(pdev);
> -       struct f_sdhost_priv *priv = sdhci_priv(host);
> -
> -       sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
> -                         0xffffffff);
> +       struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
>
>         reset_control_assert(priv->rst);
>         clk_disable_unprepare(priv->clk);
>         clk_disable_unprepare(priv->clk_iface);
>
> -       sdhci_free_host(host);
> -       platform_set_drvdata(pdev, NULL);
> +       sdhci_pltfm_unregister(pdev);
>
>         return 0;
>  }
> --
> 2.25.1
>
