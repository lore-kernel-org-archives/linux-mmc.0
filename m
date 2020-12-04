Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A49C4361B
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 13:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E92722AAF
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 13:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgLDNwT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 08:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbgLDNwS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2020 08:52:18 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782D2C061A53
        for <linux-mmc@vger.kernel.org>; Fri,  4 Dec 2020 05:51:38 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id z16so3269430vsp.5
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2020 05:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mz+QBXryBtw02WKwvqtBofezUJT1ockyk/QIMMgUvZw=;
        b=PCDIH1vya67kDh+iw8rL1ska13PYiK592n/u69GgSzRS+DGxeAhYxWftIjoDQ6jXsR
         OG8Cs6BifeNdcNkTOKlFDB6bcWCQld+JMxaHLwbFOAk/P0l+4qS5a+uTh4BuX3TrcTJc
         LLw0M/1ogLIHNzL+GbAtacLK1eWdla2RcWvh9n9fwLY0V2s2fUp4gPOVLWuSaAG66NTL
         liTfwrDW2fUgLQ5PCxJ8ATygZYURPaeVhcjNAuWvH/7PK3I2i5rYA5ZHdkGfbW2hYvrT
         JmIeINqgzp8nJAEqZDI5XusQ6zlUYolKjZ6SMS/cNxkyLAskX4yLDsJGVgetns3SjnVZ
         PFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mz+QBXryBtw02WKwvqtBofezUJT1ockyk/QIMMgUvZw=;
        b=noEyTUVILFGkjzQOMAZNIRd3da8wYbBZekxpPwl1etGyQWd6S2Ftj8CWYy9/KgZFPk
         xtTqF3p30VWP2I6MxAwsgmArUbt30gqJMfkfiCgZjYbJd3DFIznOHPjDVztn8xyV/rSz
         UJ6tExfU5pQ2BoEUARPP2HmyVNZKPe4WDn/sr8t75em/T2vsGYp1yF9S6fxqOZ+pyyqJ
         67iAqPxpFNCUsPuLwg6MJ6pIg/AMZBZ6gk9c34fHRkVPsbLJhSrXSI1WTrAAmP3vGuMb
         /drIjD/6K96lSgj9xVsvy4vBrVBDIHANfKESqdrJoPpIh+6+FigdqAy/RSGMaEDt6Y0h
         nIyw==
X-Gm-Message-State: AOAM531o7+sJVDYGmvXhKGEDw13djYam30UYNg5yGhHh9EOZargh7rdK
        XCkmW57MdfBU6jo4Fs76g6cRKZzZyEX9bukGwC504Q==
X-Google-Smtp-Source: ABdhPJzGk/t/tL7qP3yXjvmv1gwXx2PLLjyUM+GAGZfIX8dHIabpfg7nwlt7x+ZeP38Bi0Enj1TxsA65ZcY09Di2JGc=
X-Received: by 2002:a05:6102:2127:: with SMTP id f7mr3685273vsg.48.1607089897636;
 Fri, 04 Dec 2020 05:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20201202185118.29076-1-mw@semihalf.com> <20201202185118.29076-4-mw@semihalf.com>
In-Reply-To: <20201202185118.29076-4-mw@semihalf.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 14:51:01 +0100
Message-ID: <CAPDyKFp_+5G2Bg0rWcW+ZKeee--3znZJhRuXUi1U70ksy+qcjw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mmc: sdhci-xenon: use clk only with DT
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ziji Hu <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>, jaz@semihalf.com,
        tn@semihalf.com, ard.biesheuvel@arm.com,
        Kostya Porotchkin <kostap@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Dec 2020 at 19:51, Marcin Wojtas <mw@semihalf.com> wrote:
>
> As a preparation for supporting ACPI, modify the driver
> to use the clk framework only when booting with DT -
> otherwise rely on the configuration done by firmware.
> For that purpose introduce also a custom SDHCI get_max_clock
> callback.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-xenon.c | 61 ++++++++++++--------
>  1 file changed, 38 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c

[...]

> @@ -637,10 +650,12 @@ static int xenon_runtime_resume(struct device *dev)
>         struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>         int ret;
>
> -       ret = clk_prepare_enable(pltfm_host->clk);
> -       if (ret) {
> -               dev_err(dev, "can't enable mainck\n");
> -               return ret;
> +       if (dev->of_node) {

I didn't notice this in the earlier version, my apologies, but there
is no need for this check.

clk_prepare_enable() should cope fine with a NULL argument - and you
only reach this path, if the clock was successfully fetched during the
probe or that it was left to stay NULL for non-DT case.

> +               ret = clk_prepare_enable(pltfm_host->clk);
> +               if (ret) {
> +                       dev_err(dev, "can't enable mainck\n");
> +                       return ret;
> +               }
>         }
>
>         if (priv->restore_needed) {
> --
> 2.29.0
>

Kind regards
Uffe
