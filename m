Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B08C32789
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Aug 2022 10:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiHVKyE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Aug 2022 06:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiHVKyC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2022 06:54:02 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC2E1057F
        for <linux-mmc@vger.kernel.org>; Mon, 22 Aug 2022 03:54:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l19so7055621ljg.8
        for <linux-mmc@vger.kernel.org>; Mon, 22 Aug 2022 03:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qUJzeAA0zGAS1ziTyPpIwPEe4uv+VPYIR9XMGD7ii3Q=;
        b=zS3GUMwVqjObBA9yF5EBFw5i8T4tvqI0WJm3QKWgwuNQskUJA1nQZRNYN7mXVH6eKp
         BXXJgVnO7b3OxwwmzlUoxkxxprQiYtoLk+sWv1BU/B50dwHNuZ2UkXWKcivTJWATWOuf
         tPcFq7G74B3Y4yLQOgu4O0FTV8b1WUkxEcIGfN5AXBz8owhYy8BM6cFA9RBJVhjVtm05
         BKNxqx0ASZVpEObqTtBm1GsfLmd83YyXYpGusTPRs1Ace2isVx1jfkzK4fVOGr3hdE1A
         w91cHt3yl/roRhk6IgHsrNwexe+NYBOOBqb6dZfsW2dUZeq0iFyaMLQ7OdYnEUfEQD8Z
         n5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qUJzeAA0zGAS1ziTyPpIwPEe4uv+VPYIR9XMGD7ii3Q=;
        b=p6wb8d/6DEbAAbM/UBkulGrtus3ad8Xxxz873QyuYp/BOOPW0KRJDR7RRY7IfoC/UG
         YWlskZkdKQV6AXXR4cVTXLYwnvf1Ycoa2ggE0hQxf4yI0qItFA6WTISJ0Je9bGECt2hs
         h2xQ+GIRvqfA2vNj3m9bXzHlBsmHh4WXiHV1cRtgqfxd/ZfNbjI3DOZnGeZjRyjCMfb1
         S5/OCstfECZqtNNCibiDIaolwgneSL+uB2jGsUUu212r7GY4st7JMIzwZlKvFItv20lp
         HPHT7dYRKfaaUMwEaTUquAYuGybF9c1v62QIj96UQMV9yi08G/dq+PzzkS95BqM7Kfjz
         9ucg==
X-Gm-Message-State: ACgBeo3uxHlkWPAzSDZP2+CWPVgnZgStZObrKubU30KcXSL4gWCKB2aK
        N+Y+jB/tr9yNOtjiOA41yiesSDoUvEVl9rnB34/Pkg==
X-Google-Smtp-Source: AA6agR5TbBnQzeewFLNJT2B20rIJ4J1PMANfqfPlA8kVn7/qRNYu/IMOKiDXsiM+z3emf7Y2A2IYdLt6WrjEEvVIqsQ=
X-Received: by 2002:a2e:b746:0:b0:261:cc50:35cf with SMTP id
 k6-20020a2eb746000000b00261cc5035cfmr1612272ljo.4.1661165639489; Mon, 22 Aug
 2022 03:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220820195750.70861-1-brad@pensando.io> <20220820195750.70861-18-brad@pensando.io>
In-Reply-To: <20220820195750.70861-18-brad@pensando.io>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Aug 2022 12:53:22 +0200
Message-ID: <CAPDyKFoYdQirftoEQAMBwXKXqSo-tu9EUvL6B6vHCj6cDd14ug@mail.gmail.com>
Subject: Re: [PATCH v6 17/17] mmc: sdhci-cadence: Support mmc hardware reset
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        will@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 20 Aug 2022 at 21:58, Brad Larson <brad@pensando.io> wrote:
>
> From: Brad Larson <blarson@amd.com>
>
> Add support for mmc hardware reset with a reset-controller
> which would need to be enabled in the device tree with
> a supporting driver.  The default is disabled for all
> existing designs.
>
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index c662c63d49fa..35d37b9aba63 100644
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
> @@ -458,6 +460,22 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>                                          SDHCI_CDNS_HRS06_MODE_MMC_HS400);
>  }
>
> +static void sdhci_mmc_hw_reset(struct mmc_host *mmc)

Nitpick: Probably better to be consistent with the prefixes for
function names. So, I suggest changing this to
"sdhci_cdns_mmc_hw_reset".

> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +
> +       dev_info(mmc_dev(host->mmc), "emmc hardware reset\n");

Maybe it's sufficient with dev_dbg?

> +
> +       reset_control_assert(priv->rst_hw);
> +       /* For eMMC, minimum is 1us but give it 9us for good measure */
> +       udelay(9);
> +
> +       reset_control_deassert(priv->rst_hw);
> +       /* For eMMC, minimum is 200us but give it 300us for good measure */
> +       usleep_range(300, 1000);
> +}
> +
>  static int sdhci_cdns_probe(struct platform_device *pdev)
>  {
>         struct sdhci_host *host;
> @@ -520,6 +538,17 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         if (ret)
>                 goto free;
>
> +       if (host->mmc->caps & MMC_CAP_HW_RESET) {
> +               priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, "hw");
> +               if (IS_ERR(priv->rst_hw)) {
> +                       ret = PTR_ERR(priv->rst_hw);
> +                       if (ret == -ENOENT)
> +                               priv->rst_hw = NULL;
> +               } else {
> +                       host->mmc_host_ops.card_hw_reset = sdhci_mmc_hw_reset;
> +               }
> +       }
> +
>         ret = sdhci_add_host(host);
>         if (ret)
>                 goto free;
> --

Other than the comments above, I wonder about what merging strategy we
should use for the series. I believe it looks fine for me to pick up
the mmc related patches, thus we can apply patches on a per subsystem
basis, right?

Kind regards
Uffe
