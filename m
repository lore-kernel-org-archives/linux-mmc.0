Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C0FC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 13:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F7823432
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 13:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbhAMNJ3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbhAMNJ2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 08:09:28 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878BCC0617A3
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 05:08:14 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id u7so1039695vsg.11
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 05:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TtnXd+iTDg9Rg+Mw0g6+815d+x7k6NpX0spOlvkZURM=;
        b=K3ThR3oAwHsQDZ7xbu/9Z6R2rjT8kKSP3SkyMW0wlSYsB51z5XKfnUKwBX4AKvt9KM
         tA5GcrNpQvXFDqTJQtPi0kTXaO/Zp6IStPrlpHHNiBaqGOqEXnYUQpL53QFEKvODpWZO
         imW7tIAKGQuoFxvHjS+dbmymtQA4Kyt6Wcu79PG+IfS2dNoz/cz6ZrEZojn2dxKPtVqh
         fsqvFG3GUVjy6V84g4+u6egXd8SNRXYZWg+rYQLI1nQhTi//6pkCUUJtS4SaD4UOsKV8
         CL7EXYn8eEwQSr0T8JOVDX/JMekYRwf6E/9RMLwh8Ul9kLeJTXj2bsrNzJGgFwV0nGsT
         WcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TtnXd+iTDg9Rg+Mw0g6+815d+x7k6NpX0spOlvkZURM=;
        b=Wy5QrtglChcipFBBRqd17bAXCQAjNSZW12pAB1Qh+/AHdLywxcvVmK3jsI9cnDIxHo
         SAO6T7Rkev3wPk7h+sVf/zc/HuoER124THx01BT3rlgFrWGzOEP1++Jc68CtoXOOisvF
         InYy+Dxlk97gRIpebT5eEdFBldeEnl8HHRHNFWWTtYLJRA40i0Vno98gwIzida9XINdf
         jyK+YjwYTu8XoWyNQdljBUa3liOwfpvWlKrSdeyM8fdFEQInAi5ybLBXXeq3KvHLRpcD
         CZyv3qaJZc3b8CfhbmImrwQghBO1sYeBX2GjbyiwPjJgCUA2jn4KuAF9JHrizle7CetQ
         sxLw==
X-Gm-Message-State: AOAM530kTkckTktW6xAlk/USNDC7xsG34gzmb+JBurkjZc/773AF3YzG
        y08YIo9I1ozKkJnte507Htm92B/GZHO98QWBMoNYeQ==
X-Google-Smtp-Source: ABdhPJxBxJLzhErcrlYsDsTsERCk05HcKbtoPrJ+uP6qmTZlC6tz44CDMpxLSFjXCO26CrdrMiUdnEXasFsZ32t/om0=
X-Received: by 2002:a67:e286:: with SMTP id g6mr1920721vsf.42.1610543293702;
 Wed, 13 Jan 2021 05:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20210113113431.522-1-zbestahu@gmail.com>
In-Reply-To: <20210113113431.522-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 14:07:36 +0100
Message-ID: <CAPDyKFqzKf44RV29c+ncKffgRQrz7gSHNGmmKqeYWJMj5rQ0hw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: remove needless err = 0 in mmc_init_card()
To:     Yue Hu <zbestahu@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 Jan 2021 at 12:34, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> Since they will always being in successful path to return 0 directly,
> no need to set err = 0.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index ff3063c..54ab1c7 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1697,7 +1697,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                         goto free_card;
>
>                 if (err) {
> -                       err = 0;
>                         /*
>                          * Just disable enhanced area off & sz
>                          * will try to enable ERASE_GROUP_DEF
> @@ -1802,7 +1801,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                         pr_warn("%s: Enabling HPI failed\n",
>                                 mmc_hostname(card->host));
>                         card->ext_csd.hpi_en = 0;
> -                       err = 0;
>                 } else {
>                         card->ext_csd.hpi_en = 1;
>                 }
> @@ -1831,7 +1829,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                         pr_warn("%s: Cache is supported, but failed to turn on (%d)\n",
>                                 mmc_hostname(card->host), err);
>                         card->ext_csd.cache_ctrl = 0;
> -                       err = 0;
>                 } else {
>                         card->ext_csd.cache_ctrl = 1;
>                 }
> @@ -1851,7 +1848,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                                 mmc_hostname(card->host));
>                         card->ext_csd.cmdq_support = false;
>                         card->ext_csd.cmdq_depth = 0;
> -                       err = 0;
>                 }
>         }
>         /*
> --
> 1.9.1
>
