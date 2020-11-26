Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0FDC63777
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 12:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAA920DD4
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 12:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ebegGbRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbgKZMZ0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 07:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732157AbgKZMZZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Nov 2020 07:25:25 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D2EC0617A7
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2020 04:25:25 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id p12so486242uam.1
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2020 04:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z0R8R2jRUBjx4Bl2gydbnlUNsAXVgTr3tONaL7KpOr8=;
        b=ebegGbRzwXfxBzAhS27GYQiIki+X7TrcC4MeZIV/HhnMZVCREiAZah+qAmYGJQZQbT
         lNKR8hPz8RXUEo8KYu4eFtqktC4XRnrU1Pkgk6Ix/KxaQV0Io3wZxPT5XAMFnbgcNev0
         L7xxOR50D3B4XwCQFhxbQ7Oy1Uc8MszwOJSewu6djUbCe1ECrF/Vb1untmKrUKiRIZJK
         aqw5esy0TH4WRd7ac5uUWjods47LU8rkfOEC/SZ+Q3Oef4+mZYAz00ln6VaB4a6g4hva
         BVd1SGA5iC8G1ep2sXM70bs2SLSDFMmPViLltJtOQ/8vXUo1Vi9kXmimpF4AP0hmN4Ff
         xmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0R8R2jRUBjx4Bl2gydbnlUNsAXVgTr3tONaL7KpOr8=;
        b=oPwGTWezRiao1nxPRn7L/BZIXhJZ8XYKEt2vHhMFOor8oM30BWiwnsPuMRLHPlYl3Z
         fo/HAUbIHWDEa0qgaYmj2n59emI1I1tmZ+ApMO9wD9Qu3LDs0p/Q15f83yB8XGpTAJPT
         zLXZrxz6gpjTTjV2ookIO8VVICBNL0uKQdHYfA54+DwYvrNJ+6YGSU3KPkpRlSOFYf8n
         k4U7pTbPwd2N0KIlYF2B+lhVbOsi5KikKrTToBX/ulr91m7tF6ipGqdFTUqMMYo+z8sU
         zxCtrXN69EflcwxqPK/dSZA9Fz6iqlpQ9ctOpY15TbIWxoNXyI4B3eOMmdnW3vB8e95N
         6/8Q==
X-Gm-Message-State: AOAM53377Tj9bJV7t+qncOkxs9bIuyAfu4Ff3Bqe//CtzAMBAHrddm7R
        z9Y9zq+M53iSKjU1wfUnfulGnnm85L8Y1pWmBTBNjtqWAaITRt3v
X-Google-Smtp-Source: ABdhPJyIbGHUduONNAJYMEVtVww2ipJCdnEnn7o/ur8X9U+TIiWucwa3nmNUuTCbSkCIeITZgm7L8y5esOktO29kySA=
X-Received: by 2002:ab0:c12:: with SMTP id a18mr1325949uak.19.1606393524171;
 Thu, 26 Nov 2020 04:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20201125204953.3344-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20201125204953.3344-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 26 Nov 2020 13:24:47 +0100
Message-ID: <CAPDyKFrA1av8NV8r1ARtv70_uxvvW0jaUp+=+APp=bp03=Ph9g@mail.gmail.com>
Subject: Re: [PATCH] mmc: tmio: improve bringing HW to a sane state with MMC_POWER_OFF
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 25 Nov 2020 at 21:51, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Further testing of error cases revealed that downgrade is not enough, so
> we need to reset the SCC which is done by calling the custom reset
> function. This reset function can distinguish between the various SDHI
> variants, so protecting the call with MIN_RCAR2 is enough here.
>
> Fixes: 24ce2d7b8bea ("mmc: tmio: bring tuning HW to a sane state with MMC_POWER_OFF")
> Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> I was also evaluating if tmio_mmc_reset() would be better than
> host->reset. I finally decided against it. This is the minimal change
> that we need and which fixes an actual issue. I can't see why we would
> want to terminate DMA because either everything went smooth and DMA
> completed or the DMA error has already been handled. I think. Please
> speak up if you disagree.

I have no strong opinion, but just wanted to highlight that I observed
that tmio_mmc_host_runtime_resume() calls tmio_mmc_reset(). No idea
what that means for R-Car Gen2+.

>
>  drivers/mmc/host/tmio_mmc_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 7f4a28125010..a89547f5d733 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -929,9 +929,9 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         switch (ios->power_mode) {
>         case MMC_POWER_OFF:
>                 tmio_mmc_power_off(host);
> -               /* Downgrade ensures a sane state for tuning HW (e.g. SCC) */
> -               if (host->mmc->ops->hs400_downgrade)
> -                       host->mmc->ops->hs400_downgrade(host->mmc);
> +               /* For R-Car Gen2+, we need to reset SDHI specific SCC */
> +               if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
> +                       host->reset(host);
>                 host->set_clock(host, 0);
>                 break;
>         case MMC_POWER_UP:
> --
> 2.28.0
>

Kind regards
Uffe
