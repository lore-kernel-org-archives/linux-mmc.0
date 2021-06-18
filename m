Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6935BC48BDF
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Jun 2021 10:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54602613EC
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Jun 2021 10:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhFRKpH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Jun 2021 06:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhFRKpH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Jun 2021 06:45:07 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDF1C061574
        for <linux-mmc@vger.kernel.org>; Fri, 18 Jun 2021 03:42:57 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id x8so4703939vso.5
        for <linux-mmc@vger.kernel.org>; Fri, 18 Jun 2021 03:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PltpfVsWYSYb83wtwKTYBy+0tqaIthqE9CaZ4SiNDcw=;
        b=LzCYx9sJtWYCnQe39W4ypYY1HaZpTzOaNGgSjKgAbZbKHpoUjAYm1D6skpzrjnJ14d
         OzHwTNNllYpvbE4ompxKWXqhPphY9pd8RxoizDyXN2AQPNa09x4Xp/b0dK6sYbycSO1/
         3VfUf4oufQn6Ket+5XWDXKxMDStZDouBv1OA/T63b3e+8ZDQyZKd/lYwIcvvZWAOLGbn
         NIGdgXfVGt2Z07ztLjzmSPAMEAWCBAQatBfPKE5j7szbfLnJYBZvlEkeyWoxQ54Yl6c4
         DjTPo63DhC/6Avh291MgqF5QC0BC773trKQx+3hWdPje4D65v7GDu+N3U3hEGrKfHGqc
         nutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PltpfVsWYSYb83wtwKTYBy+0tqaIthqE9CaZ4SiNDcw=;
        b=bRnQA4zQDZx9ikDne0W5N84jNN0qTJn5eVvgqFJIuRuRmnx7jySe9c5J+9+EL+3GqQ
         VyzwHdhv2cO8iUxm6uIw/CaavI/Q2Lp8JBKCOGzRXFyPzABQd5dEWQNblslO3L3LwQem
         HJBzcVtF6GjZ50bwCQEWN9TZ1m9q8M4xnxX//+JKT/npjHyPGSHtb+gp/6zvJUX/XqbL
         hE+ZpNabdSlPnqM7Mb+6kOPPWnRp6J55rHb3RxM8weM1s86BZF7pFk2n2hpv1ApzgyPW
         fkh+OmFe2UAiQDWg/TLPMCwwfkpMLJf5guY8wdjPI8vEAL1lkt4E9TS4AVNcXYOEjCik
         pMSQ==
X-Gm-Message-State: AOAM532VmcvfByxQw22le6hdMFKSgjD+r7SbS3mLntMONyy/MBZZfX1W
        urXwRYg/B8mg04xxYOx8dKoOCv62UDNfRp5nxdvQhA==
X-Google-Smtp-Source: ABdhPJwTo8gF8VInP0qhhqNy4ZFN8A/468CxnETPax0e+O/H/ER0VTWC7zyYFvMzggVTxrcAXIRdiyvbiSWHzvOaXHA=
X-Received: by 2002:a67:1087:: with SMTP id 129mr5933112vsq.42.1624012976464;
 Fri, 18 Jun 2021 03:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210618082317.58408-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210618082317.58408-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Jun 2021 12:42:19 +0200
Message-ID: <CAPDyKFqkW9uwtJyWPFKggi2AJMtO4NJLW-6hviWgGSfoHyDm1A@mail.gmail.com>
Subject: Re: [PATCH] mmc: disable tuning when checking card presence
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Adrian

On Fri, 18 Jun 2021 at 10:23, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> When we use the alive callback, we expect a command to fail if the card
> is not present. We should not trigger a retune then which will confuse
> users with a failed retune on a removed card:
>
>  mmc2: tuning execution failed: -5
>  mmc2: card 0001 removed
>
> Disable retuning in this code path.
>
> Reported-by: Ulrich Hecht <uli+renesas@fpond.eu>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mmc/core/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 54f0814f110c..eb792dd845a3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2088,6 +2088,9 @@ int _mmc_detect_card_removed(struct mmc_host *host)
>         if (!host->card || mmc_card_removed(host->card))
>                 return 1;
>
> +       /* we expect a failure if the card is removed */
> +       mmc_retune_disable(host);
> +

Some controllers require a retune after it has been runtime suspended.

In the above path, when called via the bus_ops->detect() callback, it
could be that the controller may have been runtime suspended and then
got resumed by the call to mmc_get_card().

I think we need something more clever here, to make sure we don't end
up in that situation. I have looped in Adrian, to see if has some
ideas for how this can be fixed.

>         ret = host->bus_ops->alive(host);
>
>         /*
> @@ -2107,6 +2110,8 @@ int _mmc_detect_card_removed(struct mmc_host *host)
>                 pr_debug("%s: card remove detected\n", mmc_hostname(host));
>         }
>
> +       mmc_retune_enable(host);
> +
>         return ret;
>  }
>
> --
> 2.30.2
>

Kind regards
Uffe
