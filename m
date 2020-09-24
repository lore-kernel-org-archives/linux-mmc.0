Return-Path: <SRS0=/Wn+=DB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEB3C2D0E2
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 12:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5739D235FD
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 12:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zF3/JgWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgIXMuh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgIXMu2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Sep 2020 08:50:28 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C395C0613CE
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 05:50:28 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e23so2060867vsk.2
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 05:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8O9S18BmdJFglyzpqWfTJgy5KWbRC61OD9TxaLl45wM=;
        b=zF3/JgWhr3T7u9qVnY5zJf9q7dvZyGHki7ZDpaPfQsWzAGDgOcWd6eOXPczYyBShXX
         syeAR8/NHp0YmgC7QSAr72vXkcrb7Vqk7jTbuKtSqHXA+OMqn6kJWK8caQdfMiAaWdiV
         7pYnOO498NzJWbBkjiqwvaizTUrdCuUkbzS+slucU36Z1dVA2q6kRWOpkH5pXBdu9HIS
         WnI1NIyD/R5fDQnzF1S1fbbxL+5OBYP9cNwHYIeatbQpOeKh4prKHWY8PiVwDsnoXXmS
         F6n6z2QLzHwCqLb/YWUMVrqG7vRzwUzZ4yRJOy+N/ctU5ieNSWRml3cT8aby92qgttbB
         jiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8O9S18BmdJFglyzpqWfTJgy5KWbRC61OD9TxaLl45wM=;
        b=inNj0PBAo1XO/yfDZ5XWCjLseXHBWI5brFTvrh9At9J6tRwpaTFdZ9uWyUH2JEewwr
         GJXSG2PC4DRuGHdho6EU52qxpRE4andcyPGaok9QmRqemOEve/zGI0zvnzkr188AIFO3
         FAVdreY/L0WxZSEmprlZZmnIfy6Q3iOOHoGngnQFHUnL2y5RTQopOutdWtA69J+nDgL3
         xYfI8EMYh4PvjCU80CoxjqefuTQqsVxdLbGn/qTg5y9lbJlB+fT60aDX5gIbwpxbd9DA
         U+8v5cGiVgW/ow8mDZFeQO3ZmQlyMHbz6KzltoJ0SZklQdTKF3xCUZUqbvpH5YhM3VzK
         xaFg==
X-Gm-Message-State: AOAM532mhlo6eqq7sgf0t5t221fWewssrBfrqT8IvG2MZvPLDv4VxBwT
        6V3MhuchwxWgpy6GITEGOwLmAAGXKH78uXEphNbQ6w==
X-Google-Smtp-Source: ABdhPJy4aKAQQ51I36KuK7OvwPpTbyx587Cdf+GXkXYtjvaCei8zPTcqIpsMGepkbhmGGRnR4igGjkdH0tYtOOzbu2Y=
X-Received: by 2002:a05:6102:910:: with SMTP id x16mr3398197vsh.42.1600951827698;
 Thu, 24 Sep 2020 05:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200923153739.30327-1-krzk@kernel.org>
In-Reply-To: <20200923153739.30327-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Sep 2020 14:49:48 +0200
Message-ID: <CAPDyKFpWhMqXKbOMXCmR-SmQgfCEN=5bqWXGTJxcMfeMrs60Kw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: moxart: remove unneeded check for drvdata
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 23 Sep 2020 at 17:37, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The 'struct mmc_host *mmc' comes from drvdata set at the end of probe,
> so it cannot be NULL.  The code already dereferences it few lines before
> the check with mmc_priv().  This also fixes smatch warning:
>
>   drivers/mmc/host/moxart-mmc.c:692 moxart_remove() warn: variable dereferenced before check 'mmc' (see line 688)
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 2bfb376fddc4..f25079ba3bca 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -689,19 +689,18 @@ static int moxart_remove(struct platform_device *pdev)
>
>         dev_set_drvdata(&pdev->dev, NULL);
>
> -       if (mmc) {
> -               if (!IS_ERR(host->dma_chan_tx))
> -                       dma_release_channel(host->dma_chan_tx);
> -               if (!IS_ERR(host->dma_chan_rx))
> -                       dma_release_channel(host->dma_chan_rx);
> -               mmc_remove_host(mmc);
> -               mmc_free_host(mmc);
> +       if (!IS_ERR(host->dma_chan_tx))
> +               dma_release_channel(host->dma_chan_tx);
> +       if (!IS_ERR(host->dma_chan_rx))
> +               dma_release_channel(host->dma_chan_rx);
> +       mmc_remove_host(mmc);
> +       mmc_free_host(mmc);
> +
> +       writel(0, host->base + REG_INTERRUPT_MASK);
> +       writel(0, host->base + REG_POWER_CONTROL);
> +       writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
> +              host->base + REG_CLOCK_CONTROL);
>
> -               writel(0, host->base + REG_INTERRUPT_MASK);
> -               writel(0, host->base + REG_POWER_CONTROL);
> -               writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
> -                      host->base + REG_CLOCK_CONTROL);
> -       }
>         return 0;
>  }
>
> --
> 2.17.1
>
