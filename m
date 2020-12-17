Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39853C4361B
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Dec 2020 22:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1045823A54
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Dec 2020 22:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbgLQW4E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Dec 2020 17:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732168AbgLQW4E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2020 17:56:04 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37A9C0617B0;
        Thu, 17 Dec 2020 14:55:23 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n10so95258pgl.10;
        Thu, 17 Dec 2020 14:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cb7FwoEM95bPdPXQJmHT4TufQ9QvBdIpL47kT7jRkDk=;
        b=g5UXcBDDuNrzI7H4Ezzci/0lZaIxdyUG6zYZBGiAtm382qqTwa3RECIG+/oNwblzN6
         k4A7IWdGlxY0EozpbSDtMU1Hwh2vZZk/1C1tg/S3FTkmlvb3SaX7k2vZPIAHN9xYTcfv
         nuLCQQZ6uJOxI/1Px998F3V5Rc/f+s64ZOkK6LW1txpPkDw6SOynFgSDYulJ78Jdg3yk
         7uOH44UFLqedsBer1o0b8+LPt0wmWLY5kLBAd8wzYl62NsTB7qBKZ4nybXWiwUCT5u5A
         oZWDQNK6gfnrtuwEY1e80MYRJSNBgKxSw538Vx3HUjxDdP6pO6vs9bZ8/6/jCoqbmZiF
         fBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cb7FwoEM95bPdPXQJmHT4TufQ9QvBdIpL47kT7jRkDk=;
        b=k5rUuEr/TENELJ1tXsqbHZ/oDmSYOqwIQ7OVwNKYTUK4Kn9bZYL+0LckVpqBvMqgMw
         OckLdx1mrNbAW7sYYxkAqdfLK8nZUYjlAs7Lc8hAMiPggUTuHj13sCrZUE4BpIIwTQlp
         lxZ37gpyrbZJZzSi1Yqvq6mOu06vkVj6wI6u6RZpmvNLS1O+Plx4YRNwBWoby3BSP1MX
         0CRx8Dr0Nmwui5fpim0/AiUm7LcbLQCDmksKo9oig0+c3gNuwUM4ETw9kItfIUkxtJBH
         HdK/vVlZNe6wGWqTBZHleqV/ELIRHO9YLO1Kif552y5h9VrDdaJpLujwK8N83fHndTUS
         +Lrw==
X-Gm-Message-State: AOAM531Z+YJluJ5V1xAOV/5jopCh0RMIJIyh8BzPFBjCa6jAhaL1tJMF
        mKHbYKXZb0QL5f6ARlp+tCWu0WoHJzGocfoMhZ8=
X-Google-Smtp-Source: ABdhPJx1varRneHVaJ0OMknGe2XRNuPZxuk4qSiltwbAcAguT0qIxPH58+a0G8tP/f5d6z58TXzggT7rqgJYG6YuSLg=
X-Received: by 2002:a63:2882:: with SMTP id o124mr1398512pgo.11.1608245723518;
 Thu, 17 Dec 2020 14:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20201217204236.163446-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20201217204236.163446-1-christophe.jaillet@wanadoo.fr>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Fri, 18 Dec 2020 06:55:12 +0800
Message-ID: <CA+H2tpGkv0sPQ2e6OfUVuW2xFx-KSpZy_vYY3TG_9JBWvFZxAA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix some resource leaks in the remove function
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, billows.wu@unisoc.com,
        Wu Hongtao <wuht06@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ cc: Billows

Hi Christophe,
On Fri, Dec 18, 2020 at 4:50 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'sdhci_remove_host()' and 'sdhci_pltfm_free()' should be used in place of
> 'mmc_remove_host()' and 'mmc_free_host()'.
>
> This avoids some resource leaks, is more in line with the error handling
> path of the probe function, and is more consistent with other drivers.
>
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Other adjustment may be needed.
> I'm not sure at all of the 0 passed to 'sdhci_remove_host()'. Some drivers
> pass 0, some have some more complicated computation.
> ---
>  drivers/mmc/host/sdhci-sprd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index f85171edabeb..5dc36efff47f 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -708,14 +708,14 @@ static int sdhci_sprd_remove(struct platform_device *pdev)
>  {
>         struct sdhci_host *host = platform_get_drvdata(pdev);
>         struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
> -       struct mmc_host *mmc = host->mmc;
>
> -       mmc_remove_host(mmc);
> +       sdhci_remove_host(host, 0);
> +
>         clk_disable_unprepare(sprd_host->clk_sdio);
>         clk_disable_unprepare(sprd_host->clk_enable);
>         clk_disable_unprepare(sprd_host->clk_2x_enable);
>
> -       mmc_free_host(mmc);
> +       sdhci_pltfm_free(pdev);

I saw a lot of drivers also use mmc_free_host().
Do you have patches elsewhere to clean them?

Thanks,
-Orson

>
>         return 0;
>  }
> --
> 2.27.0
>
