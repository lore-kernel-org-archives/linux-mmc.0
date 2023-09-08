Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C839EE57E2
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Sep 2023 08:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbjIHIiA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Sep 2023 04:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbjIHIh7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Sep 2023 04:37:59 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F52C1BE6;
        Fri,  8 Sep 2023 01:37:55 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-649a653479bso10900016d6.0;
        Fri, 08 Sep 2023 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694162274; x=1694767074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IZLIX+qkXBSKjQlXcim9NmeX7B/uqpBQpeJJ9z2xGlQ=;
        b=A0Kdoj05fjHCpXszkveCQ8H0iJ+QfK2YTZ/YwuTthB+CAVOevjFeESeSQcNGQ1DNGD
         JUBL18Aztp30W0eB51xcYgZyBVPb9onj9j5DdXsuFZWNYB3M4CPXaxuyT8We4JeJ1NUh
         UFfVSTyrwKR9s3hWkFmLvf8x+oBDYE9jl00K1gpmXLx0/anw09l32tfk7rZdE51hzuSZ
         Yqz51v8IlHpRiAytNkFGLuZv93HmFfTsqHh2sn3UbMBinAb5YLcEuDoO6mNjiKv+y10l
         7FW1wr8o2gk8pWum/oC5d7r6EQp+ZfjgeIP0how2FH/mmYmvhP8gVAsIhq3PT16Ye4Ox
         MdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694162274; x=1694767074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZLIX+qkXBSKjQlXcim9NmeX7B/uqpBQpeJJ9z2xGlQ=;
        b=MoqnPxydA0Bzy0JQgHYIGZif5JigmUTmPRFZlzlXEUvn+awfL8Jx+e4wzGxBSlSl5a
         Oa5p37cqG2D72+++NeTqCrdUIhHVQh0Fac6TWldxnQVUHZ4hWwfhEgE9iVEcBKxjRHwx
         GbNRMwqL/6i5kb3hKuRAnMj9DNtBvi+QoDHyVAupqGvFWuOULbDDKoGVr0ZGEHWAFGx+
         +ElMUYhJvDubRKsL3SVD1sgtmhaOz5qP2L54dyGK6VXyQgVxbgjanoil2H7ovCKXbK/j
         wjoRWUm0+zw/iFWWSvuzzQBhSmywwhYoJlqQjQ9kmQMwYeABOyx6cLKSy1BBIrZD6S4l
         TXnQ==
X-Gm-Message-State: AOJu0Yx4M8RMg6o9UqsROtfDJsM5NyfN3BQxzACGgi0J3Tx/9PnYMQeD
        kFctzq83pe+5267l7LyKvqodlGO/jNe9D8R9RNs=
X-Google-Smtp-Source: AGHT+IHFy6wcaGj3ffQOJmttrg2ui42ldutOVivvrtIwaEbq7LnnNMUHxyMTvsuLMKtN+AQ4nFcTC7V3BgMT2kgYWEo=
X-Received: by 2002:a0c:c985:0:b0:647:1bae:a37b with SMTP id
 b5-20020a0cc985000000b006471baea37bmr1566886qvk.60.1694162274453; Fri, 08 Sep
 2023 01:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <a8af0a08-8405-43cc-bd83-85ff25f572ca@moroto.mountain> <CAAfSe-tMK=4D3=JTw-tLDz8OL0BPgzCd35eUFx7gxD49BHLOrA@mail.gmail.com>
In-Reply-To: <CAAfSe-tMK=4D3=JTw-tLDz8OL0BPgzCd35eUFx7gxD49BHLOrA@mail.gmail.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Fri, 8 Sep 2023 16:37:43 +0800
Message-ID: <CA+Da2qy4Gt7g4g5N2HyOZjk4KXu=fkkVO=Wr_vsDBZKxTc75dg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix error code in sdhci_sprd_tuning()
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 8 Sept 2023 at 15:31, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> + Wenchao's gmail
>
> On Thu, 7 Sept 2023 at 17:54, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > Return an error code if sdhci_sprd_get_best_clk_sample() fails.
> > Currently, it returns success.
> >
> > Fixes: d83d251bf3c2 ("mmc: sdhci-sprd: Add SD HS mode online tuning")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---

Reviewed-by: Wenchao Chen <wenchao.chen@unisoc.com>

Thanks,
Wenchao

> > This is from static analysis and has not been tested.
> > ---
> >  drivers/mmc/host/sdhci-sprd.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > index 649ae075e229..6b84ba27e6ab 100644
> > --- a/drivers/mmc/host/sdhci-sprd.c
> > +++ b/drivers/mmc/host/sdhci-sprd.c
> > @@ -644,6 +644,7 @@ static int sdhci_sprd_tuning(struct mmc_host *mmc, struct mmc_card *card,
> >         best_clk_sample = sdhci_sprd_get_best_clk_sample(mmc, value);
> >         if (best_clk_sample < 0) {
> >                 dev_err(mmc_dev(host->mmc), "all tuning phase fail!\n");
> > +               err = best_clk_sample;
> >                 goto out;
> >         }
> >
> > --
> > 2.39.2
> >
