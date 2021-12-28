Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31B3C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Dec 2021 16:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhL1Q6m (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Dec 2021 11:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbhL1Q6l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Dec 2021 11:58:41 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690A4C061401
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:58:41 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u13so42510655lff.12
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zrQnwrOYo44Zy15SHr8SgN0Chy99tnjGBiLMnJFezuA=;
        b=BmyOQ+n+2q8EtIH/+W2DQ5gXaSxydrZiDK9gQHpDFhjnKjR6A8ZiGKOFENrAsf6Kup
         7ZLAlzKRdwHSiPXOZhv7qImo9MVw0HrNTvk8cWiatYdoPJkjmx19D6e3+Zjwof54ELdh
         rDzOQJb8fwd8ex27GBGO4UTLQ3rCOBUXN8Wmi9bmDLnUWhoMgbZtH7yelbeYBB1sYK1c
         VQs6bRoXLKz/h0t+7Z5LMKBkLauP9PBtroxAEcn01Smq8JU0Mp2DOcS1CXKKyGSTke8I
         K6dya80J5nEoQmQ8hMXysyICDX3mgBxEhYMCysmu24r1wSPnKD+Zf1P384FKCozPUIS/
         2HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zrQnwrOYo44Zy15SHr8SgN0Chy99tnjGBiLMnJFezuA=;
        b=w7Vy3vJs3cDkhylycDn5fWVK3alGFdJn1QkvLRCgjXMv6TswIfor4P/YCG6dXTHkIi
         4unqFeL/+Vjiq8WznRtI20bf/T4wurVDlb2gv4Y7YFjR4eB4vfEj90llnhMyPGxXzoWZ
         9vOaVRRZWDv2k5yK2GuIwc/qf4UTtEa0X7Zoagfie/niT4lw+wJlaaTf9vtdIn1J3oVv
         TJaSFutm2DA1+4r6IDF103rPYU2vKpZSqIFVu/CbW1cGBpKnLWPSujAYk+F5MMGdEH7y
         3rNkXG6dursF7qikf9YFYjwwbuBdI6yepLbmI/KY/+IGX2IXmLs3s76dEgA7lClTmYNU
         FUaA==
X-Gm-Message-State: AOAM530T3pLCZHnaaJgbty4//z6fWKfni564FRCG7jhp+guB0/NH1Hcz
        RqVNairI8hZET2jzOw0pIHrUKbbOKvgQKB0jiS1f8g==
X-Google-Smtp-Source: ABdhPJx4JoO51qdE7YskaABs81LWtu6BBrmrra8NDnH7XzKiBYGjPn+QvguCjJ0yBPPCmHp7CTk73mpMwcHQOOasimo=
X-Received: by 2002:ac2:4c46:: with SMTP id o6mr20144159lfk.373.1640710719665;
 Tue, 28 Dec 2021 08:58:39 -0800 (PST)
MIME-Version: 1.0
References: <07a8e48db446888bd77f16b88568e80904f52103.1640528089.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <07a8e48db446888bd77f16b88568e80904f52103.1640528089.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 17:58:03 +0100
Message-ID: <CAPDyKFpeiPcbvB2gV3P5z2bGpo_--gpFT_zUaMKA1kX8HT0uEA@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq: Use bitmap_free() to free bitmap
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 26 Dec 2021 at 15:15, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> kfree() and bitmap_free() are the same. But using the later is more
> consistent when freeing memory allocated with bitmap_alloc().
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/pwrseq_simple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index ea4d3670560e..988467fbb621 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -54,7 +54,7 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
>                 gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
>                                                reset_gpios->info, values);
>
> -               kfree(values);
> +               bitmap_free(values);
>         }
>  }
>
> --
> 2.32.0
>
