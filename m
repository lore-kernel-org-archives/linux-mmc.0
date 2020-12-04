Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DFBC433FE
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56F522B39
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgLDOj5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 09:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgLDOj4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2020 09:39:56 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79CEC061A55
        for <linux-mmc@vger.kernel.org>; Fri,  4 Dec 2020 06:38:46 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id 128so3330928vsw.10
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2020 06:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ld4dnKet0Aan3wmVGmDEhQALDjT+lE0nQJqWzbzD/MU=;
        b=WGi2/QVB6Oc9twB4+3YrCN1dvhzPGACKxJQDwiWbWnuxVZS/YBx0Xu9ZGpa1aROHis
         ACv1JU6LKXb4c1ioBtMatYMuZVUAMqwGdq2kvLf2lQOtp15G0ofgcTLCMusmUFs38U5S
         PO2yuL3Uk5rZjzjhi19dZfhV6CPA9Pgxy5RnvN80UUK5815AFbrEMRyAQAiU+AM8BWre
         GHIyzIMZLbf7TwE+jU2MX5ZSIIz+NpCe5/HqUyWcIyV/pEMOoI5E66tR8QTC2ISnSSlz
         fxsC54LSXJTOMli8IOh38i88xhyQ5vyBXDdcLhpji4OGJLHGt6cM7jgudLPftdlqY+8r
         6UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ld4dnKet0Aan3wmVGmDEhQALDjT+lE0nQJqWzbzD/MU=;
        b=onPAeNiNv3Wvsbo+ysZMftoQtsk+L9kxvr4EjJZc0w1xC+GeukI6g7azHgE/HGJ86c
         BIT70lfC5Q+sngpcZtMRzlimS93TvYsHPDj/54Zh93YMTxqmiiExQzTRnGaBzD6LCjyV
         BH21V8cB2HcsVgKg2MInI03VJgh6XlzWC9LgqhCfs+7aim0Bb8+PSZl0iySozhCRS3sw
         y84xwF3VXoLKCxSaQuZPzAHyTMArghBYnJckjNF6+IHzhN0XwH1mU79NLjEfIGt8/XYA
         ckSLZu+TWFWSq3+hjnRdPFTUeQhxwcTN+uq/fUdkgJuEIB59qlEa6QwqJbdMSoy1A7Fm
         GQ7Q==
X-Gm-Message-State: AOAM5318+84jbMNoh288iwLzzHKuPTbkBZe0+F/S0YSKFo4ldBQ/mmCE
        IIPLe4qpyJdvxvWI1RNU5NhjR9gh3HuV7bq7b+HDfA==
X-Google-Smtp-Source: ABdhPJwnvZhvZ0ukN6hOxsx1tx/Kh8k9pUNeBGVL+JSvwrWUS+Wh6nHS35cqQnwEo0d/eQvVWwcIyBZNIcuskbt/+C8=
X-Received: by 2002:a67:e286:: with SMTP id g6mr3935119vsf.42.1607092726109;
 Fri, 04 Dec 2020 06:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20201125204953.3344-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20201125204953.3344-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 15:38:08 +0100
Message-ID: <CAPDyKFrEAVNukL=EUN=QO3h-RC-wAY=b+vQooEqQ54EXhGwtjQ@mail.gmail.com>
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

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
> I was also evaluating if tmio_mmc_reset() would be better than
> host->reset. I finally decided against it. This is the minimal change
> that we need and which fixes an actual issue. I can't see why we would
> want to terminate DMA because either everything went smooth and DMA
> completed or the DMA error has already been handled. I think. Please
> speak up if you disagree.
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
