Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45751C4724C
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 08:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A6F20870
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 08:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhLnbO3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEHIMt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 04:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHIMs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 04:12:48 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F14C05BD43
        for <linux-mmc@vger.kernel.org>; Fri,  8 May 2020 01:12:48 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id s11so561466vsq.13
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLgXT1iXwEsv0n4D71KjbeqOvQsScYFNvF3vfJHXObo=;
        b=JhLnbO3vnTrc8iy4nj4rne02q2jjhauyWDFcSfp1ojAce/wbADRALu49bRPQYl8zC6
         B90E4ITqd7ttpublhLiYinUD8YW0I9y12Z0F7RG2rVOnkiXZiNsuHt5wEXm9exkE3Jix
         xebHI7UucTC4NSALzWxBW/JrFGnj0QLL1aRKhvKncqyLROSY243O/lTdkB3sT/Mb00EC
         9NB+d6H0mWkI9kuZ7ATff+2fHRupccnRQNhmweu855x4/LfmJXTr0quer6Kl7e8CZRKA
         nVU7UodpEcUAv2vgjroqXMm2VTn482NOhBfIAfid0ze+eVGhIEXcq5HOSxfwls9Jpl9n
         5erA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLgXT1iXwEsv0n4D71KjbeqOvQsScYFNvF3vfJHXObo=;
        b=Rtwjs05Zy/DiYEQ5Q8IuGlf/HQ3AK/xFIGfP2Y0BY7KqolF4WWJ2+0VNF1nbzD82Up
         kvRrGNedXQrkLoRT+odD1m7Srl7XyhRqCK9rlxuyNX1XRsVAVr3efU1EAEah4rDBr9qH
         Sbz1jyW2H57Mwz6DkiMf4yh25zI2zGUXjeqbnDeCIXxN0xWRFuaauYOtGFu/ZpXmyI2u
         SVtZhquZuX8TuefXvT9vz1VKTiR8w6fl9kNVfFXTzA4+CU9mJhQgao6nCED/EciiTL/E
         nj3Ivc05leT76JvEN0Ddbr8JrpnhlrXIoMxW0lGWYxa5gIqV1QzGNyvh5RnuB1kBz6eC
         ZcaA==
X-Gm-Message-State: AGi0PubtnXIQfmh8w0kpP+XdYi7CHNG2bJI+E9RU/uuL9gr953xYQ+FA
        B8VAA3rH9FoQyj6HwZXnCY5bSyeRGYbB3bfecruvFw==
X-Google-Smtp-Source: APiQypIBO+2l3VhsWZ1KIb9ZX8P9YSg4Snqi4gWQ+q9mtr749jE50gBgs9jolF5Oy+q7+Duj1LBVWKkfFW8G9oQc50o=
X-Received: by 2002:a67:6ec2:: with SMTP id j185mr954905vsc.34.1588925567859;
 Fri, 08 May 2020 01:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200507192218.GA16315@embeddedor>
In-Reply-To: <20200507192218.GA16315@embeddedor>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 May 2020 10:12:11 +0200
Message-ID: <CAPDyKFqd6QKSOzZp2Cq1kMusNQYithdodk2anpWWVOiQ6w0+SQ@mail.gmail.com>
Subject: Re: [PATCH] memstick: Replace zero-length array with flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 7 May 2020 at 21:17, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
>
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  include/linux/memstick.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/memstick.h b/include/linux/memstick.h
> index 216a713bef7f..da4c65f9435f 100644
> --- a/include/linux/memstick.h
> +++ b/include/linux/memstick.h
> @@ -288,7 +288,7 @@ struct memstick_host {
>         int                 (*set_param)(struct memstick_host *host,
>                                          enum memstick_param param,
>                                          int value);
> -       unsigned long       private[0] ____cacheline_aligned;
> +       unsigned long       private[] ____cacheline_aligned;
>  };
>
>  struct memstick_driver {
>
