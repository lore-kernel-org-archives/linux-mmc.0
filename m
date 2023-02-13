Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767E2C636D4
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 23:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjBMXtM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Feb 2023 18:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjBMXtD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 18:49:03 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD3F1A97E
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:49:02 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id e1so4361987pgg.9
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kl8QzkXhRVqlS7J3L6dkB3lhTIHg1fIKAOZ1QC4ZzQs=;
        b=Rjiw0UtkkA5pdBI3pHmcoYBvBhNOaZwmXn6Skly3X5g9JzSml5VNrNrDLbFdYdA3jH
         LPiX4vffES/kzaQUqFhjeQ521/KlvAwysA7ob4kVlBY3Thos2RAEfY0Dm/l967Xaeeio
         4XdBLbkTL+YEt4Gvooky6kmnhHcPY1dLjjcc4Jiq94TMqHgzvpDp4bvLTpQpop6NTn2Q
         uUM/q7R9Cf2e52EOdNXqSsf1MIzPcHH15gOH5oFTHmTdiXm7DmRa2+PzY1bBJeRWmVOY
         +t4dBHCeI/mIQlnKbkAqgP35Q0I3/GJ9vKfDJAKhnTl041K35y/TvtyaVHNWgVn7TwNy
         LtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kl8QzkXhRVqlS7J3L6dkB3lhTIHg1fIKAOZ1QC4ZzQs=;
        b=yLs3wZvsr7bIzBE9c2PLI65JmusEOdJ2GBufwH63JPa2g9D0sxXdWcces4Be1ahOsm
         ozUjOjT+/5Hk+8PP0ETFEgE6qUQlTz7AAJ53IaVAMSIe+YTonbUiGOt8OHle6IM/OR/E
         e8Aa2gJC+RpZjObFoA6Pe7bHbTzs5ODWG3kqY4h2FcWtOaJ2HBHx09O85g9zK1qaAgT4
         rV/GJFw2Syo6N7jrO/THlCBQN2B2zuazZBi6YjQ+tUogsiB8ZNZhAm0xUBgItxIASO8m
         nioSqMevUN7igRig5fhiR3X+TgAbQ3KbNydMqB2OcJjLgiVEbbC25xkgZMubJ/Xjiysx
         Jz5g==
X-Gm-Message-State: AO0yUKVALUbwa+FAT8PEjJ+plbElHdfikGjMQmF9LgJxuVZe74qkSMR7
        zOFdGcX6hX7HmNM7w4csQWgv9gsh5VdYmkdZgeIARA==
X-Google-Smtp-Source: AK7set+6RSMgTKP2+GZlEeiAjA1q8cUPrJ2/QFq99Fpl/5bmDycICvdzoEIjD2syU8UNVJbvE22IdH4IdFNUSMtaMkE=
X-Received: by 2002:a63:340c:0:b0:4fb:9359:493b with SMTP id
 b12-20020a63340c000000b004fb9359493bmr1346452pga.77.1676332142070; Mon, 13
 Feb 2023 15:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20230131013835.3564011-1-yangyingliang@huawei.com>
In-Reply-To: <20230131013835.3564011-1-yangyingliang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 00:48:25 +0100
Message-ID: <CAPDyKFqV6sCYLkGsbRVvTC0Q5ajY-VKHjfDvqQbc4StB+kWxjg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_spi: fix error handling in mmc_spi_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org, drzeus@drzeus.cx, david-b@pacbell.net,
        CLoehle@hyperstone.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 31 Jan 2023 at 02:38, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> If mmc_add_host() fails, it doesn't need to call mmc_remove_host(),
> or it will cause null-ptr-deref, because of deleting a not added
> device in mmc_remove_host().
>
> To fix this, goto label 'fail_glue_init', if mmc_add_host() fails,
> and change the label 'fail_add_host' to 'fail_gpiod_request'.
>
> Fixes: 15a0580ced08 ("mmc_spi host driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> v1 -> v2:
>   Fix a typo.
> ---
>  drivers/mmc/host/mmc_spi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 106dd204b1a7..cc333ad67cac 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1437,7 +1437,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>
>         status = mmc_add_host(mmc);
>         if (status != 0)
> -               goto fail_add_host;
> +               goto fail_glue_init;
>
>         /*
>          * Index 0 is card detect
> @@ -1445,7 +1445,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>          */
>         status = mmc_gpiod_request_cd(mmc, NULL, 0, false, 1000);
>         if (status == -EPROBE_DEFER)
> -               goto fail_add_host;
> +               goto fail_gpiod_request;
>         if (!status) {
>                 /*
>                  * The platform has a CD GPIO signal that may support
> @@ -1460,7 +1460,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>         /* Index 1 is write protect/read only */
>         status = mmc_gpiod_request_ro(mmc, NULL, 1, 0);
>         if (status == -EPROBE_DEFER)
> -               goto fail_add_host;
> +               goto fail_gpiod_request;
>         if (!status)
>                 has_ro = true;
>
> @@ -1474,7 +1474,7 @@ static int mmc_spi_probe(struct spi_device *spi)
>                                 ? ", cd polling" : "");
>         return 0;
>
> -fail_add_host:
> +fail_gpiod_request:
>         mmc_remove_host(mmc);
>  fail_glue_init:
>         mmc_spi_dma_free(host);
> --
> 2.25.1
>
