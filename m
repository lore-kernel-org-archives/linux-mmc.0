Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CB4C433DB
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Feb 2021 10:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A135B64E56
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Feb 2021 10:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhBAKzH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Feb 2021 05:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbhBAKxw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2021 05:53:52 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FBCC061573
        for <linux-mmc@vger.kernel.org>; Mon,  1 Feb 2021 02:53:12 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id p20so8839388vsq.7
        for <linux-mmc@vger.kernel.org>; Mon, 01 Feb 2021 02:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tj9+wUASKdA988AwjUcir+sNKYOXGh+DtOltXAPwD5c=;
        b=aXdwaxpjRxNrPrq30arSHWwsOaUD+Gs3g10PPEAi7s+Eb/z0CjrS+H+I0zBpQMZau5
         iGMUT+ZOqWpkL8i9sGNcW/OmKqlXCOLe6yh7xd8QalAUcrl3CcIFTS/ZnT+iw3OXe7RI
         ix4wzus4ntv43NkKn85xPWFKM9snBKAzmUk5QBcPHmMXWo8yb2inBXncd5tEuUp5m0DS
         rePAqucaLrPgs1LTR2NFwH04HsvbVeYlEQCNWWq76Z/t9kfhwZYkLE83N8TftQgEGPeG
         Wxmbk49pR1fNPuN/KxiB3utA1v+p0dCwMnTNyTXf/aAKUHpqetSi/ZaG5dl6ybvRTT/d
         mhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tj9+wUASKdA988AwjUcir+sNKYOXGh+DtOltXAPwD5c=;
        b=cN/Oalrpi5ZbGJnE6d8nz2UmcYdQr63SyM0qs45DfFAW9TZ2zrmgvsbJ+Q/+Jsp9f2
         7J7HH4JfkEv0yaHAuWKiPyt2COlNS9Yj7q8D1jhzAaIqWnmttciT6cK5+1z+ZDl9JiKO
         yStmRphACFUo3RSVRVlwW0VmX3LG3vpRMXg5P+CSBCAlaBo8kwag6Yjmgc8QIfidu+Eh
         p5CgBlkJcUSFm1VJKa/hdt7iGxyErzmLATLTMGhIfuQTc2QyR9Vup23FvRWoe0ZrgJP3
         NavBgRXiVJyPYhKNJQpBLabyEaQARFR7b5sLtXf1dqH9EhOKI6AVyWaIywVNeUtK3o6/
         RJ5A==
X-Gm-Message-State: AOAM5319a4bbK0MCwpQ/pSHu1xDg8moTxaN4gpQehAoeghnecBubxvZO
        TDBvvuuqlAQhkoMlTtdcRxD8pbTQKRa4YucKMaZ3Zg==
X-Google-Smtp-Source: ABdhPJzfgAWfe9KDdADgCat7+QVp73bUlUd8wAj/QDujNIzNOe+wtUW4jFYZRog/xQ1FUMxdv82lvrygS9pwlwIzfdQ=
X-Received: by 2002:a67:ec4a:: with SMTP id z10mr4286650vso.19.1612176791680;
 Mon, 01 Feb 2021 02:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk> <20201208061839.21163-7-chris.ruehl@gtsys.com.hk>
In-Reply-To: <20201208061839.21163-7-chris.ruehl@gtsys.com.hk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Feb 2021 11:52:35 +0100
Message-ID: <CAPDyKFoVGiB0VMv2y-YHEE8F72Y7vO6561e0vQXH5hc7yayOKg@mail.gmail.com>
Subject: Re: [PATCH 6/6] mmc: core: with mmc-hs400-1_8(2)v not add
 MMC_CAP2_HS200* to host->caps2
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jack <jack.lo@gtsys.com.hk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Dec 2020 at 07:19, Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:
>
> When set mmc-hs400-1_8(2)v in dts, hs200 capabilities are not checked
> in the mmc logic. Thus cleanup and remove MMC_CAP2_HS200_1_8V_SDR /
> MMC_CAP2_HS200_1_2V_SDR from host->caps2.

I had another look at this - and I am struggling to get a grip of the
problem you are trying to solve, sorry. Please try to clarify things
through more descriptive commit messages.

*Plain* HS400 mode does seem to require HS200 mode, because tuning
needs to happen in HS200 mode. HS400 mode with enhanced strobe being
supported, doesn't need HS200 to be supported as tuning isn't done in
HS200 mode.

In your case, the controller supports HS400 mode in (1.8V or 1.2V)
with enhanced strobe, but not HS200 mode, correct?

Then because of the code that runs the initialization for the eMMC
card, we end up switching to HS200 mode prior enabling HS400 ES mode,
which causes problems in the driver/controller for your case, correct?

>
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  drivers/mmc/core/host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 96b2ca1f1b06..46fde60a2372 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -295,9 +295,9 @@ int mmc_of_parse(struct mmc_host *host)
>         if (device_property_read_bool(dev, "mmc-hs200-1_2v"))
>                 host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
>         if (device_property_read_bool(dev, "mmc-hs400-1_8v"))
> -               host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
> +               host->caps2 |= MMC_CAP2_HS400_1_8V;
>         if (device_property_read_bool(dev, "mmc-hs400-1_2v"))
> -               host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
> +               host->caps2 |= MMC_CAP2_HS400_1_2V;
>         if (device_property_read_bool(dev, "mmc-hs400-enhanced-strobe"))
>                 host->caps2 |= MMC_CAP2_HS400_ES;
>         if (device_property_read_bool(dev, "no-sdio"))
> --
> 2.20.1
>

Kind regards
Uffe
