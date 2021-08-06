Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93951C432BE
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 13:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D74960EAF
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 13:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243637AbhHFNIU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Aug 2021 09:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbhHFNIS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Aug 2021 09:08:18 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAEFC061798
        for <linux-mmc@vger.kernel.org>; Fri,  6 Aug 2021 06:08:02 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id o10so3594473uaj.0
        for <linux-mmc@vger.kernel.org>; Fri, 06 Aug 2021 06:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmAhQlP9dlSHWsEPz99ylQ58gN43w15UGSNx2NbwKBM=;
        b=STiSeXyxpRSqICwSQnipskRRbqlRuVPyx1wPjT5UXA5Xw4jWjeiVJTdzhVL6ZdZEHj
         Hj/gPEaNaiaAEf0Xz+Ra1u8hnM3VbkGyyPlxrZBHvPdK6l3lWYTTFGSNOHeUFfqtTo2v
         3C3X04BBtKxQzkf6wHv5kHvK92DFMKNUY5jP/f1Vg6FvrljmKTRp4wLe/IBylzW/KBev
         3gzAg4aI6EjJd9KHZhvckurw7baJBVK+iyFCDKdaIXpvm1pd8E6sAl5dqFDja7tOAbeZ
         AVRWbU7PRNfP/lLJvhhsmcqHea47GLeXeDcvzZnhV5CaOld5/oGvh0pB2MbF7QxYCk3U
         zIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmAhQlP9dlSHWsEPz99ylQ58gN43w15UGSNx2NbwKBM=;
        b=nAP3bkCQ/t1EfrJvTnq76YR4hwAGv7/suwdfxNHjVpNEf7R2iT594e++4krDU9ZEHT
         gzJxbhaPQaVz06hnLRwjyHvua5jrmvGUN3u3Fo7hs3FlXeTkG+7il7FCOU7g7XXRAGi1
         m5xJAS5T0n7v5QbSLbuQS2R3TIlVtPhV28wBhSMW+oVnw7odFsWwnx4Vy/PX5kQGkJnj
         PPH4XmJiW2WyS9CVF5WWbEbTwTkjEyfQ50loVRb7sTusdOprfK6DX9BixzHgTzRotAcV
         vMQ3o6DpGjgHSsyXeAYOKT7Mzk0L3k7Y4KYZsIuKYqDkvbYRttP39SlAIIaKZWqdI0s3
         lcFQ==
X-Gm-Message-State: AOAM5339Iv6zfcdM02Te0hfDmFLvWENe+REvO1Ees4qqh+qAlBpfbLa/
        ERR5Kjhhn/CveIg0viIz/40aHeu1D/5Tg0fdktpOtg==
X-Google-Smtp-Source: ABdhPJzCi2WVGCtxjxLxgPDs1JUFc/moL4qQ/2gBcE3nziv1qLvjqwBf8tD7gGjZHW+4mVHMma7q8WRZIotADvOoY/U=
X-Received: by 2002:ab0:60c9:: with SMTP id g9mr8326216uam.100.1628255281536;
 Fri, 06 Aug 2021 06:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210726163654.1110969-1-sean.anderson@seco.com> <20210726163654.1110969-2-sean.anderson@seco.com>
In-Reply-To: <20210726163654.1110969-2-sean.anderson@seco.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Aug 2021 15:07:25 +0200
Message-ID: <CAPDyKFq0uS99FD+Dv0EZ766VTkGCYWiA_vEHU4w7P7J2+eFB+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdio: Print contents of unknown CIS tuples
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 26 Jul 2021 at 18:37, Sean Anderson <sean.anderson@seco.com> wrote:
>
> Print out the contents of the offending tuples when we do print them.
> This can make it easier to debug, since these tuples are not exposed to
> userspace anywhere else. We are limited to 64 bytes, so keep printing
> out the full length in case the tuple is truncated.
>
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/core/sdio_cis.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
> index 7518b27bcef2..a705ba6eff5b 100644
> --- a/drivers/mmc/core/sdio_cis.c
> +++ b/drivers/mmc/core/sdio_cis.c
> @@ -334,7 +334,7 @@ static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)
>                                 if (time_after(jiffies, timeout))
>                                         break;
>
> -#define FMT(type) "%s: queuing " type " CIS tuple 0x%02x (%u bytes)\n"
> +#define FMT(type) "%s: queuing " type " CIS tuple 0x%02x [%*ph] (%u bytes)\n"
>                                 /*
>                                  * Tuples in this range are reserved for
>                                  * vendors, so don't warn about them
> @@ -342,11 +342,13 @@ static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)
>                                 if (tpl_code >= 0x80 && tpl_code <= 0x8f)
>                                         pr_debug_ratelimited(FMT("vendor"),
>                                                 mmc_hostname(card->host),
> -                                               tpl_code, tpl_link);
> +                                               tpl_code, tpl_link, this->data,
> +                                               tpl_link);
>                                 else
>                                         pr_warn_ratelimited(FMT("unknown"),
>                                                 mmc_hostname(card->host),
> -                                               tpl_code, tpl_link);
> +                                               tpl_code, tpl_link, this->data,
> +                                               tpl_link);
>                         }
>
>                         /* keep on analyzing tuples */
> --
> 2.25.1
>
