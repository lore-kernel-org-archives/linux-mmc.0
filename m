Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB1BC77B70
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Apr 2023 14:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDQOzf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Apr 2023 10:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjDQOzR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Apr 2023 10:55:17 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C9AA240
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 07:55:04 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-54fb615ac3dso207336137b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681743303; x=1684335303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fur1vsPRYGb4bHxVHQwC4yeXMQ8BUZiX8URDo13Jh5Y=;
        b=ca8I5OXFRjYtVdJWR6zaa7SLc3Z539o4eA0Di+IdBEAIVQ4xOXztVzyAH4LVv0DxjM
         wGc5KKb+cA8eVcpSZ9j4njPgrIhaUiSdoBKNB5dcEK2E/zZED6IopD6QtB1b2Jo8kqS+
         8jUU6h44FLRSNsUISU5cp2136sZKefYaglt4nkEE21tz/ELQZ3YdvXZqITWaXdLXbYsg
         XAojCHxjZko9EZseS9DNgvDvQ18Y4nDejlC21UorzTaJrOoua5XMxgytfjzpXjlXwDqx
         tBpbxi86nTrfu6InrIT7OmffVNTgaEGtZDDgeiJrA2zpbdhz05SwImYyRaebjUbed3RG
         ecbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743303; x=1684335303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fur1vsPRYGb4bHxVHQwC4yeXMQ8BUZiX8URDo13Jh5Y=;
        b=e+6mQ08Fbs3RKt/oEkm4k/rEQHKr83DQWIqllccyGTxD/hYI4TDb+ObJBdQK23UhPD
         dceyadZdcQlBPkaYBmRXKQ2poc7mgbf2bQvA6E9HTDsXFyLr4Jn4KeFU+8afOh0+WD6C
         cfrJL8dcPIx7vgE7girx9xcpE1UFf3Nl4Yv2QYTSQvchCA3ldD+SqxEkr7eaT04Eu9dD
         tuK9u1L3i1QOWWbmkBDAEIIXrSnpdTo8wBhPxoib8Zzr3OLyGCfd8zHhIzAhs+tSB9i/
         9i29AqegR4B2VqFYz5nc55P19SzyZbuS/vlX7+Odjq6sqrnorSSbt7PTBuXsK/cpBO6J
         74cw==
X-Gm-Message-State: AAQBX9eilzUPurN7om3kC4fSqieeyEIIjqDnB5Nnc3n/EhvtYR5G+fnX
        ZC5CwT1vkX+oBKOD6qwey7TIByjBHuGbC/EvrjCPsg==
X-Google-Smtp-Source: AKy350a/ZGQMRyt4s8YkzjxrQpaJdxmrR2L1AJJHpIMfsU2yGCHbxIgTQY1VbhWTD8ze1dcmY23ZOAPuN9GaR90A+/8=
X-Received: by 2002:a81:af1e:0:b0:52e:e095:d840 with SMTP id
 n30-20020a81af1e000000b0052ee095d840mr9538749ywh.0.1681743303598; Mon, 17 Apr
 2023 07:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230410184526.15990-1-blarson@amd.com> <20230410184526.15990-15-blarson@amd.com>
In-Reply-To: <20230410184526.15990-15-blarson@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 16:54:27 +0200
Message-ID: <CAPDyKFqCv5Y7UzV2vi-500Nq2t4wze4xnXq8=S=DKNTH3HCh0A@mail.gmail.com>
Subject: Re: [PATCH v13 14/15] mmc: sdhci-cadence: Support mmc hardware reset
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        vaishnav.a@ti.com, will@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 10 Apr 2023 at 20:48, Brad Larson <blarson@amd.com> wrote:
>
> Add support for mmc hardware reset using a reset-controller
> that would need to be enabled in the device tree with
> a supporting driver.  The default is disabled for all
> existing designs.
>
> Signed-off-by: Brad Larson <blarson@amd.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v9 changes:
> - Previously patch 17/17
> - Changed delay after reset_control_assert() from 9 to 3 usec
> - Renamed sdhci_mmc_hw_reset() to sdhci_cdns_mmc_hw_reset()
>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 5d1e9cef74f5..b24aa27da50c 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -12,6 +12,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/reset.h>
>
>  #include "sdhci-pltfm.h"
>
> @@ -70,6 +71,7 @@ struct sdhci_cdns_priv {
>         spinlock_t wrlock;      /* write lock */
>         bool enhanced_strobe;
>         void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
> +       struct reset_control *rst_hw;
>         unsigned int nr_phy_params;
>         struct sdhci_cdns_phy_param phy_params[];
>  };
> @@ -457,6 +459,22 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>                                          SDHCI_CDNS_HRS06_MODE_MMC_HS400);
>  }
>
> +static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +
> +       dev_dbg(mmc_dev(host->mmc), "emmc hardware reset\n");
> +
> +       reset_control_assert(priv->rst_hw);
> +       /* For eMMC, minimum is 1us but give it 3us for good measure */
> +       udelay(3);
> +
> +       reset_control_deassert(priv->rst_hw);
> +       /* For eMMC, minimum is 200us but give it 300us for good measure */
> +       usleep_range(300, 1000);
> +}
> +
>  static int sdhci_cdns_probe(struct platform_device *pdev)
>  {
>         struct sdhci_host *host;
> @@ -520,6 +538,15 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         if (ret)
>                 goto free;
>
> +       if (host->mmc->caps & MMC_CAP_HW_RESET) {
> +               priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, NULL);
> +               if (IS_ERR(priv->rst_hw))
> +                       return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
> +                                            "reset controller error\n");
> +               if (priv->rst_hw)
> +                       host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
> +       }
> +
>         ret = sdhci_add_host(host);
>         if (ret)
>                 goto free;
> --
> 2.17.1
>
