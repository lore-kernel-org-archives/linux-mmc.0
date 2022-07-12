Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245C5C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jul 2022 10:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiGLKwJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGLKwI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 06:52:08 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615D2AE38E
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 03:52:07 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bn33so9373346ljb.13
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 03:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvjl37PfjvotfuUJbfheqj7v+sZVTOGge3DQ+4pXsTM=;
        b=uv6uTUB+zDBLwMtNPmgLvhpkq4A9j6HneT7GysQvSn01RXoZeZiWR0qzq4EraUqrqd
         fOOboPFgPRxGCVLuofrYzSu/PgQe8oa8r5rk/zT/DswfiB/Q1YTH4J9cX73A3sKlHhbg
         Xy5LUY3N1y6T6IYxpxI8XVvi7msxdQ+Y/AdH9zbHjBfHIUWh3PICau7zcwj3OPiBjSmv
         KnI1+9HR/yjm4S3m+5cLrY0G0+AETSyfEitSy8vwrRCG6mqeoRBF8ahzxkIXQrnMZUZd
         2yaTJ+5JXH0FoN6JTscfKC6oNPpwAfyu4RF1N5EnJwYALjJQdmqvHXlr7KfdlAv2yY0y
         2YKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvjl37PfjvotfuUJbfheqj7v+sZVTOGge3DQ+4pXsTM=;
        b=CcU3kXy4gO9+2oq1Unza2BVCH+gFxDhFJhjJ5Vu+lh5fDHgKBW+x6G3ZYdy2ZleOcn
         PCPmpoYuQaexPpsI22vVcImQEfqZ3TEI+kdVkU0W/n0i5HzrMJ6CEfw+TbmIs2gsmGR2
         Vfc7eljZr/1TXI308FOmKiid1isAskyl0Oe6vNpBUcuUoOIbbw3vKMhdV92Vf4jfI2Gs
         muYwoZip0extI03zsfI83ZUU5pFH9uMJXbT3kYrRke8KifczzRqsTjOkNvF6WaihmDqX
         vZp4eoixu81SdRnIuBUpQqcnXLZmAk6Hqfc7WWM2WjtA0MyZMO7Wj9DdxUzBZHEG0f41
         b1WQ==
X-Gm-Message-State: AJIora/eir9u9xQpOoG5RTht8ejloUXrQ3evBBgCqf0TX1Os9hUvEa7Q
        +z6o8kjyeFitMXVRQwYC1wvVZvyfaiR5PLCO8uPzAA==
X-Google-Smtp-Source: AGRyM1uXvwQ1ihDOR9BJBTqYDFH4HjpJm8bCeGzRjsNDE5BCtOFejtRDnfGNAm9JyTfcKlgO2CqrywRQZYVGJKuZGP0=
X-Received: by 2002:a05:651c:10a3:b0:25d:66c5:ce4c with SMTP id
 k3-20020a05651c10a300b0025d66c5ce4cmr7169405ljn.463.1657623125755; Tue, 12
 Jul 2022 03:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220705001814epcas1p40a4eadbf8429f01a98bdb56f00ba3310@epcas1p4.samsung.com>
 <20220705005035.14195-1-sh043.lee@samsung.com>
In-Reply-To: <20220705005035.14195-1-sh043.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 12:51:29 +0200
Message-ID: <CAPDyKFqzVJ+EQYZWJG3adYEWdr=9kAXunwyKESvWqT8-L84Q9w@mail.gmail.com>
Subject: Re: [PATCH] mmc: print clock frequency with recognization
To:     Seunghui Lee <sh043.lee@samsung.com>
Cc:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        linux@dominikbrodowski.net, alexandre.belloni@bootlin.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, junwoo80.lee@samsung.com,
        jangsub.yi@samsung.com, cw9316.lee@samsung.com,
        sh8267.baek@samsung.com, wkon.kim@samsung.com,
        seunghwan.hyun@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 5 Jul 2022 at 02:18, Seunghui Lee <sh043.lee@samsung.com> wrote:
>
> It's easy to figure out how fast frequency it has from the log.
> e.g. mmc0: new ultra high speed SDR104 SDXC card
> at address aaaa(clk 202000000)

Well, this information is already available through debugfs and I
think that is sufficient.

Moreover, card->host->ios.clock doesn't necessarily contain that
actual clock rate, but rather the rate that is requested by the core.
To really know the rate the bus is running on,
card->host->ios.actual_clock needs to be checked too. This too is
available through debugfs.

Kind regards
Uffe

>
> Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
> ---
>  drivers/mmc/core/bus.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 58a60afa650b..3623cc27a61c 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -348,7 +348,7 @@ int mmc_add_card(struct mmc_card *card)
>                         mmc_card_ddr52(card) ? "DDR " : "",
>                         type);
>         } else {
> -               pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
> +               pr_info("%s: new %s%s%s%s%s%s card at address %04x(clk %u)\n",
>                         mmc_hostname(card->host),
>                         mmc_card_uhs(card) ? "ultra high speed " :
>                         (mmc_card_hs(card) ? "high speed " : ""),
> @@ -356,7 +356,8 @@ int mmc_add_card(struct mmc_card *card)
>                         (mmc_card_hs200(card) ? "HS200 " : ""),
>                         mmc_card_hs400es(card) ? "Enhanced strobe " : "",
>                         mmc_card_ddr52(card) ? "DDR " : "",
> -                       uhs_bus_speed_mode, type, card->rca);
> +                       uhs_bus_speed_mode, type, card->rca,
> +                       card->host->ios.clock);
>         }
>
>  #ifdef CONFIG_DEBUG_FS
> --
> 2.29.0
>
