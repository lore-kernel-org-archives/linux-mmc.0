Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC638C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Apr 2022 18:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357188AbiDSS0M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Apr 2022 14:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357243AbiDSSWz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2022 14:22:55 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F143380
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2022 11:15:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bq30so30867347lfb.3
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2022 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7rLfgL8n1HzAKM5Z9puooLAMeuuPufr2kMAch+r94Zo=;
        b=g9ifeBph7P3f7s+l1Jr8jf8K9RLOZ0gCermOXFX6hZKM/56DwrKx6OtJviEpIUPHwM
         7s1fKhtxXofan8iS1Rec1SXdssIzVCtOCscEWRaT7+lkRUJmKiLbUnTUc92ofGRwwvWT
         wzlDz1hIQ1RDYagfhuSWy2cdXpD2nAS7KQL+xi/T+xX9uK2UJ/X7h/sckhyMrb5NEkP4
         yLzMDQzlWVqvQ3m/FiDaPFNw/P7wd5MInks/pmJkp3DZg8qIawfeP3jc3H1+aZKMtkXh
         og63Sd6VuEikMRvQrDXGp1DYPHFjB8YLxn9oF7cJoCpwOhymALogEsIoCq4gd3eAxSlf
         rGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rLfgL8n1HzAKM5Z9puooLAMeuuPufr2kMAch+r94Zo=;
        b=BU6qjIqvVwcOuh6/W9uAov6cWYfAKsCI7ZdKbtaqY9uBdDzdT6feIpWNF8uKWoODBN
         AhwaYems9/7x0EZOIVI+Xi6RkMVwXH6D18TPWwcoaanZ0YP8yMG06U19oCvnRlP1Fk58
         Hu5ytTKNf1UT+Y5b7+zv+KRzAuo9AwCFn12peUkesCgTqxbHgBS2rQQ+N5HaPxjrTsFy
         Gfy8/BveOyMU5sAfMSAm6z2yECRbOtGimeQ5bi1zUEs+oNYEVdTeXuDaFDGYvBm4bszx
         qr/zWsy/rvkI8010wRLKOfYu2ze26Gkc3Sc2p5wHeedXBob8f7aU7KOct1AWLNWYK8kv
         gj0g==
X-Gm-Message-State: AOAM530EtiAXObHBTX1w4CXTmYqllEVS5EhI0IxwLHDPWMAO5wiiKFYn
        wCLGggCv7Tf8YnEvXFqOi3KI+qeBwdHj92l4bdFdzg==
X-Google-Smtp-Source: ABdhPJzW1PMzi9ZHugp9YdN4Kl0Iav6IkrK3+o2b7IIFEPanOohq585xVVgiS8AOaJbnveJ5KQRC1iFIU/cHLizmmkI=
X-Received: by 2002:a19:7001:0:b0:46e:404d:fdd9 with SMTP id
 h1-20020a197001000000b0046e404dfdd9mr11605632lfc.71.1650392135080; Tue, 19
 Apr 2022 11:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220415222931.481352-1-linus.walleij@linaro.org>
In-Reply-To: <20220415222931.481352-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Apr 2022 20:14:58 +0200
Message-ID: <CAPDyKFq23tHDtEYs9OoEedNbtZ+ytdeLDEc_4qOH6qtbcAZPFg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add CIDs for cards to the entropy pool
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 16 Apr 2022 at 00:31, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> To make the entropy pool a bit better we can toss in the
> CID for eMMC and SD cards into it, usually the serial
> number portion is at least unique.
>
> This does not count as improvement of the entropy but
> in practice it makes it a bit more random to mix in these
> numbers.
>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/mmc.c | 7 +++++++
>  drivers/mmc/core/sd.c  | 7 +++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e7ea45386c22..974d8a02b966 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/stat.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/random.h>
>  #include <linux/sysfs.h>
>
>  #include <linux/mmc/host.h>
> @@ -1673,6 +1674,12 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                 err = mmc_decode_cid(card);
>                 if (err)
>                         goto free_card;
> +               /*
> +                * Add card ID (cid) data to the entropy pool.
> +                * It doesn't matter that not all of it is unique,
> +                * it's just bonus entropy.
> +                */
> +               add_device_randomness(&card->cid, sizeof(card->cid));

We can move this into mmc_decode_cid() instead, to avoid open coding.
Moreover, this would make it work for SDIO/SD combo cards too,
whatever that matters.

One thing though, what is the typical execution time to do this?
Probably negligible, but as this may be a card that holds the rootfs,
it could delay the boot to be completed.

[...]

Kind regards
Uffe
