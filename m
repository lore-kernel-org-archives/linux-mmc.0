Return-Path: <SRS0=M0Y2=63=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1F9CA90AF
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 12:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7792078C
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 12:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBj6EQHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbgEMMP6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 May 2020 08:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732088AbgEMMP6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 May 2020 08:15:58 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3183EC061A0C
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2020 05:15:58 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id i5so5973872uaq.1
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2020 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09R37UyziPgwn1Nn28wDcEoLu5IKO4m4ALNMAgJM4kI=;
        b=MBj6EQHGwmC6elIl1U1sbpt1fWckfg85iHR6ZdIifhf6e12FTw9exoct51b1gKWGvy
         pa/flvp339RQZFJpAuAWpvE1V6scAVMezDKv34SricUB6UXEpNScxrA3A5UA+v4Nobl9
         9KPou1t4i2WQVRkH+Etbtq246m5vkI0uVO+iN/CaTqi4bUc6cl8EVNeFpIzrlCVc4VJe
         OHGAnFOhe0WSTJ0TlXbcqJPJJA0pSyoHUb98pxSI4ADcUViI9wrAT47Y5KdWD/Y63HTg
         HtBqTIDdL8EGwFpU/8E9BESM+zYj82+86mKQPAoqHZB6XvrQJxJ09RN2UUrFAbzdIbBm
         4Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09R37UyziPgwn1Nn28wDcEoLu5IKO4m4ALNMAgJM4kI=;
        b=une7S3zaXwrrZAAWmXXMV7YVhZVuSwjR9OLUMoar0ZHEXwT2U22wz3oMUt95LDJPDI
         N3+rhMXBkvo9tGkU5BD8loxRNEBgMxNT/5j6fVOJXRYkwXwgvwUcmZfpB9MS2HdpwC+V
         hLn+NiU2W9do4J3yivevRlkb1ZrjHLWyDhlAPEBmrJq4enAllWNGKLllkEboATLOPw8W
         r0idPcIliJMpq9f9olatXK6jqHlAq7uUjZkxzOmKnMs/I1EOaY0vtY6JytcYJV5EzsmY
         dJfr7jC5eVTs5PX4B8rqI99ohOPOe0bDqgoCzzDPfyLbSMYK01vCqAMAdPwMmKlfPRMG
         F6Jg==
X-Gm-Message-State: AGi0PuZG3tBx8ay4GOoIMKa1+sB4Nf1nnaT9e4Pl/1yw4ZBE9pepv7p6
        Yywq3Sc9+cayTtJ2n2cVlCZavO+Xl3wdCIg/NQ64cg==
X-Google-Smtp-Source: APiQypI6K6WkbV2b5JG0GNaUTBKncfOz5kVnvft3b29ggsHnVFU9hKVoaYdJppHK25X49jpwum4gQEdswg9o5OXokwQ=
X-Received: by 2002:ab0:6588:: with SMTP id v8mr20880328uam.100.1589372157298;
 Wed, 13 May 2020 05:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200513174706.3eeddb2b@xhacker.debian>
In-Reply-To: <20200513174706.3eeddb2b@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 May 2020 14:15:21 +0200
Message-ID: <CAPDyKFpE_uqiNQ22Fq9hDfb5pzMBdgmwgUbasEsEdXFkEOmq6A@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: sdhci-xenon: add runtime pm support and
 reimplement standby"
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 May 2020 at 11:47, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> This reverts commit a027b2c5fed78851e69fab395b02d127a7759fc7.
>
> The HW supports auto clock gating, so it's useless to do runtime pm
> in software.

Runtime PM isn't soley about clock gating. Moreover it manages the
"pltfm_host->clk", which means even if the controller supports auto
clock gating, gating/ungating the externally provided clock still
makes sense.

Kind regards
Uffe

>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/mmc/host/sdhci-xenon.c | 87 +++++++---------------------------
>  drivers/mmc/host/sdhci-xenon.h |  1 -
>  2 files changed, 16 insertions(+), 72 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 4703cd540c7f..85414e13e7ea 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -15,8 +15,6 @@
>  #include <linux/ktime.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/pm.h>
> -#include <linux/pm_runtime.h>
>
>  #include "sdhci-pltfm.h"
>  #include "sdhci-xenon.h"
> @@ -539,24 +537,13 @@ static int xenon_probe(struct platform_device *pdev)
>         if (err)
>                 goto err_clk_axi;
>
> -       pm_runtime_get_noresume(&pdev->dev);
> -       pm_runtime_set_active(&pdev->dev);
> -       pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> -       pm_runtime_use_autosuspend(&pdev->dev);
> -       pm_runtime_enable(&pdev->dev);
> -       pm_suspend_ignore_children(&pdev->dev, 1);
> -
>         err = sdhci_add_host(host);
>         if (err)
>                 goto remove_sdhc;
>
> -       pm_runtime_put_autosuspend(&pdev->dev);
> -
>         return 0;
>
>  remove_sdhc:
> -       pm_runtime_disable(&pdev->dev);
> -       pm_runtime_put_noidle(&pdev->dev);
>         xenon_sdhc_unprepare(host);
>  err_clk_axi:
>         clk_disable_unprepare(priv->axi_clk);
> @@ -573,10 +560,6 @@ static int xenon_remove(struct platform_device *pdev)
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>
> -       pm_runtime_get_sync(&pdev->dev);
> -       pm_runtime_disable(&pdev->dev);
> -       pm_runtime_put_noidle(&pdev->dev);
> -
>         sdhci_remove_host(host, 0);
>
>         xenon_sdhc_unprepare(host);
> @@ -593,78 +576,40 @@ static int xenon_suspend(struct device *dev)
>  {
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>         int ret;
>
> -       ret = pm_runtime_force_suspend(dev);
> +       ret = sdhci_suspend_host(host);
> +       if (ret)
> +               return ret;
>
> -       priv->restore_needed = true;
> +       clk_disable_unprepare(pltfm_host->clk);
>         return ret;
>  }
> -#endif
>
> -#ifdef CONFIG_PM
> -static int xenon_runtime_suspend(struct device *dev)
> +static int xenon_resume(struct device *dev)
>  {
>         struct sdhci_host *host = dev_get_drvdata(dev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>         int ret;
>
> -       ret = sdhci_runtime_suspend_host(host);
> +       ret = clk_prepare_enable(pltfm_host->clk);
>         if (ret)
>                 return ret;
>
> -       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> -               mmc_retune_needed(host->mmc);
> -
> -       clk_disable_unprepare(pltfm_host->clk);
>         /*
> -        * Need to update the priv->clock here, or when runtime resume
> -        * back, phy don't aware the clock change and won't adjust phy
> -        * which will cause cmd err
> +        * If SoCs power off the entire Xenon, registers setting will
> +        * be lost.
> +        * Re-configure Xenon specific register to enable current SDHC
>          */
> -       priv->clock = 0;
> -       return 0;
> -}
> -
> -static int xenon_runtime_resume(struct device *dev)
> -{
> -       struct sdhci_host *host = dev_get_drvdata(dev);
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -       int ret;
> -
> -       ret = clk_prepare_enable(pltfm_host->clk);
> -       if (ret) {
> -               dev_err(dev, "can't enable mainck\n");
> +       ret = xenon_sdhc_prepare(host);
> +       if (ret)
>                 return ret;
> -       }
> -
> -       if (priv->restore_needed) {
> -               ret = xenon_sdhc_prepare(host);
> -               if (ret)
> -                       goto out;
> -               priv->restore_needed = false;
> -       }
>
> -       ret = sdhci_runtime_resume_host(host, 0);
> -       if (ret)
> -               goto out;
> -       return 0;
> -out:
> -       clk_disable_unprepare(pltfm_host->clk);
> -       return ret;
> +       return sdhci_resume_host(host);
>  }
> -#endif /* CONFIG_PM */
> -
> -static const struct dev_pm_ops sdhci_xenon_dev_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(xenon_suspend,
> -                               pm_runtime_force_resume)
> -       SET_RUNTIME_PM_OPS(xenon_runtime_suspend,
> -                          xenon_runtime_resume,
> -                          NULL)
> -};
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(xenon_pmops, xenon_suspend, xenon_resume);
>
>  static const struct of_device_id sdhci_xenon_dt_ids[] = {
>         { .compatible = "marvell,armada-ap806-sdhci",},
> @@ -678,7 +623,7 @@ static struct platform_driver sdhci_xenon_driver = {
>         .driver = {
>                 .name   = "xenon-sdhci",
>                 .of_match_table = sdhci_xenon_dt_ids,
> -               .pm = &sdhci_xenon_dev_pm_ops,
> +               .pm = &xenon_pmops,
>         },
>         .probe  = xenon_probe,
>         .remove = xenon_remove,
> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> index 593b82d7b68a..2b9b96e51261 100644
> --- a/drivers/mmc/host/sdhci-xenon.h
> +++ b/drivers/mmc/host/sdhci-xenon.h
> @@ -89,7 +89,6 @@ struct xenon_priv {
>          */
>         void            *phy_params;
>         struct xenon_emmc_phy_regs *emmc_phy_regs;
> -       bool restore_needed;
>  };
>
>  int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
> --
> 2.26.2
>
