Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6019CC43219
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 12:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiKIMPu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 07:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiKIMPt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 07:15:49 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33FF13F7B
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 04:15:48 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y4so16930418plb.2
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2022 04:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yybp5GQkINWOGNJfWdB4Wuog9A6gcJ2pt653sLMEWvA=;
        b=SCqUdVWMgRBRF5if0NYhIo9YJLY3EzcceIYuHAdGuVfdc0dt8tITUguFKB8l42msOp
         9zi49zCHJKTs3USdfW+NnzKaM3uSsRxg2OzJSr4ycwGVJ1PdBEBfJMuUQ98fNMpOAITF
         8ZvuqHcNVjiRNbfmBx961B949M6vm/achhz33E8tVNXNlR1yPpkJBNchEOpxter52lRq
         nPjEpsfZi7fe4ox/ubHDkI862st4zHYtI/5qPTWGwR9x4GpdY2sbq79mgudcQZCAz9po
         jaOdyoJBPv2ZJy83KhgkxJ6ambSn2wtRdbUdz5smTpjrmrvG9BELgXwLjNBOJ6zoemEI
         mzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yybp5GQkINWOGNJfWdB4Wuog9A6gcJ2pt653sLMEWvA=;
        b=08Yeb/rz4JAHz9f3MWFCYaPMCAHKQw2ifKOCr+3ddhHuNK1MRTMXOKZUbSm3HTSF5l
         x0M3+bDyg1xzuB4yK9x+9Vky1h13yel0xVsZKq1K5ywg6nlSCnd732rHCZKGdrcdh55Q
         8zhQ0G2yFnycomzLWxlHJYRc2IZlCecuzEJpD2cXbyrTjakzKwlxS2QDS/QIU3vecdL2
         W9Iv/Cl07AM6EL28aNHEHkGFZr02rXSoqVaFBdukIHhzpnbjr6WUBVHBUL7YxfLbI5vf
         oDLPibx/lnL2S1LKfyZ33Ufxxh3g60QwUw1SQfjyebYeKODXRONAjiHVDgxn2N3Ck2m6
         1FZA==
X-Gm-Message-State: ACrzQf2n4GEZbyGnR29gLJrbDUy/bp/r7UABRDE3GyEO6cq2H7odDhhW
        Y7rtAJ732rXMX5h/i3ZZd34P2QJs76i3DoCnWe7C9g==
X-Google-Smtp-Source: AMsMyM7VP/8HEW9l66u8NEL4a3twNyQ9cwzwT7IBL2QiPspRTi3I6iqZgP4JV5H5B8A2lmw8lMHoYf0PS2sXG2vpfOA=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr80652557pjb.164.1667996148432; Wed, 09
 Nov 2022 04:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20221108082533.21384-1-hayashi.kunihiko@socionext.com> <20221108082533.21384-2-hayashi.kunihiko@socionext.com>
In-Reply-To: <20221108082533.21384-2-hayashi.kunihiko@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Nov 2022 13:15:11 +0100
Message-ID: <CAPDyKFoiowaut9EhDeBH0ci50WJ7y8UFivxqExxS0EfV_KAhpw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: f-sdh30: Add reset control support
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Nov 2022 at 09:25, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Add reset control support for F_SDH30 controller. This is optional.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

This needs an update to the DT doc too, which is also the case for patch4.

That said, please convert the DT doc into the yaml based format as the
first step.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci_f_sdh30.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index 3f5977979cf2..7f4553b28180 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/property.h>
>  #include <linux/clk.h>
> +#include <linux/reset.h>
>
>  #include "sdhci-pltfm.h"
>  #include "sdhci_f_sdh30.h"
> @@ -21,6 +22,7 @@
>  struct f_sdhost_priv {
>         struct clk *clk_iface;
>         struct clk *clk;
> +       struct reset_control *rst;
>         u32 vendor_hs200;
>         struct device *dev;
>         bool enable_cmd_dat_delay;
> @@ -150,6 +152,16 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>                 ret = clk_prepare_enable(priv->clk);
>                 if (ret)
>                         goto err_clk;
> +
> +               priv->rst = devm_reset_control_get_optional_shared(dev, NULL);
> +               if (IS_ERR(priv->rst)) {
> +                       ret = PTR_ERR(priv->rst);
> +                       goto err_rst;
> +               }
> +
> +               ret = reset_control_deassert(priv->rst);
> +               if (ret)
> +                       goto err_rst;
>         }
>
>         /* init vendor specific regs */
> @@ -175,6 +187,8 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>         return 0;
>
>  err_add_host:
> +       reset_control_assert(priv->rst);
> +err_rst:
>         clk_disable_unprepare(priv->clk);
>  err_clk:
>         clk_disable_unprepare(priv->clk_iface);
> @@ -191,8 +205,9 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
>         sdhci_remove_host(host, readl(host->ioaddr + SDHCI_INT_STATUS) ==
>                           0xffffffff);
>
> -       clk_disable_unprepare(priv->clk_iface);
> +       reset_control_assert(priv->rst);
>         clk_disable_unprepare(priv->clk);
> +       clk_disable_unprepare(priv->clk_iface);
>
>         sdhci_free_host(host);
>         platform_set_drvdata(pdev, NULL);
> --
> 2.25.1
>
