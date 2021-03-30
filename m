Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FDAC433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 10:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2E26198A
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 10:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhC3Kjr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Mar 2021 06:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhC3Kjd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2021 06:39:33 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E87C061762
        for <linux-mmc@vger.kernel.org>; Tue, 30 Mar 2021 03:39:32 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id u144so3437296vkb.13
        for <linux-mmc@vger.kernel.org>; Tue, 30 Mar 2021 03:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fx+qunAgeaKNzL/3vPJGFvdOm7PGo9OLfJ6hKlJPmiE=;
        b=kI5FFf3THdLIjOHzOjtIhhe00n2B3q6Tr0GaFLMTyppf+VBJ57i/smGoRVF+UFkdAX
         Wo0iXNy6Afvc+PPUqmzTLbO6FvNqEbb231rlN1GKiotRSwA2zNkNazyilIcVKiKSvy+N
         KR9k5fycIyRtmjdD6OU29//Ta4JOLoLOeHlZ7Sr4UDaF2dm+X+Ars7TgLaqDanRu2qMm
         DKnIMuNXvMMdowm9Vo3vc6/8YA1GRXhAliaTUKDoX1Za4NYWdhI9nWBHnk7bAztXsaRY
         0LK00BCHMbP9z0eBcwo5uyU//2AgP7AdBMqgWdx1QyY/pj1EBjewLx3NocixinBOauzA
         TGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fx+qunAgeaKNzL/3vPJGFvdOm7PGo9OLfJ6hKlJPmiE=;
        b=fUfqIPgZ2V/opdbVMS6Q+8BLvcxl1B5LMmPz+evEgSlK5Wkxr0Xic7/DjYZepJZdDS
         a901hGoaucTOdOnDRoJNyW3KQ7bDSQPsKpZXzh0P6ayw94EWwHoW9f+577IiLL/DSXjI
         wdicslNuFOakRQlMmX2qzqGM4Zev+JRiP7vJy/I7EBPaLgHkPap/3JQk+jUDKeKyyT/J
         3oL8FcneIOmcMKbTCoMebSaUxxF7zArAMOFhnElAUZV8s3aoJIyrUNvf87R76gnz+0JJ
         esHCFbHHEVm6eyDLktSbQtxPnNxZqlN2l9GGjXNv5xQSRoHaKzNaEimj8V7lksljju+K
         YE9Q==
X-Gm-Message-State: AOAM5305ywHfHuSHJiFlYpXqm0Fh3vdUzMnemId5TDAjYAlS5g2bvGY0
        pu4qHcLKQyRZuokeC8eh2K+TsFB9u57ve2nBX4POEQ==
X-Google-Smtp-Source: ABdhPJwp6Yp7RPHEVG9ZmngWfrWlYd1ALHAiwdqzhYpcPJDe2HYa5uuEsgtTfkkdE0xa/zFeWHhuvpX+9E1QgqiUxPs=
X-Received: by 2002:a1f:5504:: with SMTP id j4mr17032947vkb.7.1617100771387;
 Tue, 30 Mar 2021 03:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <1617086448-51054-1-git-send-email-fanghao11@huawei.com>
In-Reply-To: <1617086448-51054-1-git-send-email-fanghao11@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Mar 2021 12:38:55 +0200
Message-ID: <CAPDyKFoUUu=Rb0pHMZb+gKXPsKESBnXG=4U=n_XFMZJLHyY7kA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-k3: use the correct HiSilicon copyright
To:     Hao Fang <fanghao11@huawei.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 30 Mar 2021 at 08:43, Hao Fang <fanghao11@huawei.com> wrote:
>
> s/Hisilicon/HiSilicon/g.
> It should use capital S, according to
> https://www.hisilicon.com/en/terms-of-use.
>
> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> ---
>  drivers/mmc/host/dw_mmc-k3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 29d2494..0311a37 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2013 Linaro Ltd.
> - * Copyright (c) 2013 Hisilicon Limited.
> + * Copyright (c) 2013 HiSilicon Limited.

This change looks really silly to me, but I am not a lawyer - so I
can't tell if this makes sense or not.

In any case, "Hisilicon" is being used all over the kernel - do you
intend to patch all places with similar changes like this one? Perhaps
just send a big tree-wide-patch instead and see what people think?

>   */
>
>  #include <linux/bitops.h>

Kind regards
Uffe
