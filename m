Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C6DC001DB
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 18:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjHHSnX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjHHSnB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 14:43:01 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0579135C4D
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 09:36:01 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bc9254a1baso4811122a34.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2023 09:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691512528; x=1692117328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mRLcdBtw9nwQOUfKRavX3wZrUe68VBy1FGiQoaTHfg0=;
        b=Ko3aVAZHElO3g4wZqaBoy3TGfLt74qtWP122zIcNBNlNVNkVmUO0aHYd8JOORIG+rQ
         n7Ev6Uu+5uRtDZViXM+hIFFRhA6SNbjdQKm2YAsGYsmHpd8yTGuBoTjbYdUAYJEYMQPW
         /Pvnhg2FcUyjnwwrxyNSuIv0InE4mIAg+WWcafG0k04HFjWZsc26ubtwMjSyVea50Pxg
         nDelfRQIiTroW+D6KX+URoSZJNCGllJPiVhrvCylg5uTJEyXD2SYpAL/bE8bQjcexpw+
         ZzdHlJHAtjD8yK+h5TcnEih6cugoFC8shV5cDnVTnXycj/iP++9SPzc+xKSxManibj/d
         rqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512528; x=1692117328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRLcdBtw9nwQOUfKRavX3wZrUe68VBy1FGiQoaTHfg0=;
        b=EYAmIEYnE9uHo8KTJ+uwqPWhMVl3kDB/Plc4Q4OOZk9dPRI/bwoqwZ670bxc9RS8K1
         FkyE3HlunTEQ22TgvyHgkslu3w+Scv+5mNV3lBftn9zIdpstrLlRwHDcjDFRGK+StujT
         L4eVz105ycwivmPyl+ZXenS/eQ1uOcy1z/8FdmBC76UU2pJplOvsK9Amz9hWUBcXPfml
         yMb8mJQnfxDrs9Mf0U081jskRReBcnkgoHsFggNyQqk9b7q0891UXLVDKhkyTyVHMcVz
         hTlPctb8C1oznWMQLWKsRLo7YC5kcP6REy/TLjb8U8OxFYWklQldJDp+XgsVJOd0ZCYw
         xokQ==
X-Gm-Message-State: AOJu0YwI/jSyfqk7MvefG8UBRr0Jgj/tcw9rfB7OiofSD5WKjWZUB2s5
        Up0YGRKoE533TQX+lAR7BvvbmWS/627AKVMDBhRWDKQBnG1RgLB8e+c=
X-Google-Smtp-Source: AGHT+IFrsfzZvvS9Y2tPd1opRtAE2Y8xhZ8ahi0a7jdb/3eExJtyrsIJsefl4ij3MUC3ojS26P+vxE02fIVGontyL1w=
X-Received: by 2002:a25:8d12:0:b0:d1e:be4:e7b5 with SMTP id
 n18-20020a258d12000000b00d1e0be4e7b5mr12737679ybl.4.1691487625704; Tue, 08
 Aug 2023 02:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230804233015.173957-1-limings@nvidia.com>
In-Reply-To: <20230804233015.173957-1-limings@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 11:39:49 +0200
Message-ID: <CAPDyKFprnX=37FDdBxiNyyr5X_6zpp87Kt7o1hxdRePZhMJO4A@mail.gmail.com>
Subject: Re: [PATCH v6] mmc: sdhci-of-dwcmshc: Add runtime PM operations
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 5 Aug 2023 at 01:30, Liming Sun <limings@nvidia.com> wrote:
>
> This commit implements the runtime PM operations to disable eMMC
> card clock when idle.
>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>
> ---
> v5->v6:
>     - Address Adrian's more comments and add coordination between
>       runtime PM and system PM;
> v4->v5:
>     - Address Adrian's comment to move the pm_enable to the end to
>       avoid race;
> v3->v4:
>     - Fix compiling reported by 'kernel test robot';
> v2->v3:
>     - Revise the commit message;
> v1->v2:
>     Updates for comments from Ulf:
>     - Make the runtime PM logic generic for sdhci-of-dwcmshc;
> v1: Initial version.
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 72 ++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index e68cd87998c8..aaf66358f626 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>
> @@ -548,9 +549,13 @@ static int dwcmshc_probe(struct platform_device *pdev)
>
>         host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>
> +       pm_runtime_get_noresume(dev);
> +       pm_runtime_set_active(dev);
> +       pm_runtime_enable(dev);
> +
>         err = sdhci_setup_host(host);
>         if (err)
> -               goto err_clk;
> +               goto err_rpm;
>
>         if (rk_priv)
>                 dwcmshc_rk35xx_postinit(host, priv);
> @@ -559,10 +564,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         if (err)
>                 goto err_setup_host;
>
> +       pm_runtime_put_sync(dev);
> +

The async pm_runtime_put() is probably sufficient - and it would allow
the probe to complete a bit "sooner".

>         return 0;
>
>  err_setup_host:
>         sdhci_cleanup_host(host);
> +err_rpm:
> +       pm_runtime_disable(dev);
> +       pm_runtime_put_noidle(dev);
>  err_clk:
>         clk_disable_unprepare(pltfm_host->clk);
>         clk_disable_unprepare(priv->bus_clk);
> @@ -606,6 +616,12 @@ static int dwcmshc_suspend(struct device *dev)
>         if (ret)
>                 return ret;
>
> +       ret = pm_runtime_force_suspend(dev);

Can dwcmshc_suspend() be called for a device that may be attached to
the ACPI PM domain?

> +       if (ret) {
> +               sdhci_resume_host(host);
> +               return ret;
> +       }
> +
>         clk_disable_unprepare(pltfm_host->clk);
>         if (!IS_ERR(priv->bus_clk))
>                 clk_disable_unprepare(priv->bus_clk);
> @@ -625,6 +641,10 @@ static int dwcmshc_resume(struct device *dev)
>         struct rk35xx_priv *rk_priv = priv->priv;
>         int ret;
>
> +       ret = pm_runtime_force_resume(dev);
> +       if (ret)
> +               return ret;
> +
>         ret = clk_prepare_enable(pltfm_host->clk);
>         if (ret)
>                 return ret;
> @@ -646,7 +666,55 @@ static int dwcmshc_resume(struct device *dev)
>  }
>  #endif
>
> -static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
> +#ifdef CONFIG_PM
> +
> +static void dwcmshc_enable_card_clk(struct sdhci_host *host)
> +{
> +       u16 ctrl;
> +
> +       ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
> +               ctrl |= SDHCI_CLOCK_CARD_EN;
> +               sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +       }
> +}
> +
> +static void dwcmshc_disable_card_clk(struct sdhci_host *host)
> +{
> +       u16 ctrl;
> +
> +       ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       if (ctrl & SDHCI_CLOCK_CARD_EN) {
> +               ctrl &= ~SDHCI_CLOCK_CARD_EN;
> +               sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +       }
> +}
> +
> +static int dwcmshc_runtime_suspend(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +
> +       dwcmshc_disable_card_clk(host);
> +
> +       return 0;
> +}
> +
> +static int dwcmshc_runtime_resume(struct device *dev)
> +{
> +       struct sdhci_host *host = dev_get_drvdata(dev);
> +
> +       dwcmshc_enable_card_clk(host);
> +
> +       return 0;
> +}
> +
> +#endif
> +
> +static const struct dev_pm_ops dwcmshc_pmops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(dwcmshc_suspend, dwcmshc_resume)
> +       SET_RUNTIME_PM_OPS(dwcmshc_runtime_suspend,
> +                          dwcmshc_runtime_resume, NULL)
> +};
>
>  static struct platform_driver sdhci_dwcmshc_driver = {
>         .driver = {
> --

Kind regards
Uffe
