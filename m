Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F042EC433E3
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0DBA61981
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhCaJlg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbhCaJlR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 05:41:17 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3864C061760
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:15 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id d82so4213360vkd.3
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fd8jBA8I9u/EGaDkiHtzB7rTMkP1PjvtPxjlz3UgGqc=;
        b=sx7PN7n6fSeOBjqHjBWqV90nesMPPZHM3qtSjAN0coYTkO/40NfErfTntMRxIH1myK
         Ue1nIX45zU5X0J9W2p5fjw9uzn07+bLvi4UDgkNG8GS4BLu1+tZWo7GyIN0gduuNaUt3
         cbz++KoJ6LOBPb6sBcYbnegsRulu+C9x1zIsbrutkmsQsInx2mZRCqEDcOxTfEoLh0gx
         +MYS/cQwkxWu6D6Sqlgsu8jaIYaWJOER+vESrV9TPH30EqFH5rTnQneiflrmvPQZovvf
         NRxpr116QUXOY8YQuygI3qG6AeuWIVbhwDi6MlvxxbcU5rRKL23GyrbDaCF9k3o6rmi+
         /DWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fd8jBA8I9u/EGaDkiHtzB7rTMkP1PjvtPxjlz3UgGqc=;
        b=M7ltsDpePuf90/Gvwu89GajYvPxaCvXCGgbGEcvanjTkzDMzoiiJfJk4bqqzCNHXtr
         t7eblQGpAtYUJf+iMaVhjxfN19bfyFieZhoTUZzOKVhg0W/RseSkierMq4y7fE+pfjPJ
         mEakCOyVAOlLl7/WcfeEjiijQOS+gDow3fo/nupfOo9mmEU8rvF59FDUMF6H6LrNQm/h
         mVkDW90xvkXnhwgY+f8xkmhZRn9WhaTotWts60oq830e2XTkHzcnqsa9ED+rvn9CyYlB
         nkPzdalUjzBavxRSdccCnlZC2+VicERgBitAYpXqEpkMj9hR94FC1PCm7jy2/lillRix
         b2/w==
X-Gm-Message-State: AOAM531SGM64WBPqGfLoaT5M6W4hZ6J79PhEMxdie4LFQEjJVYEV/Kke
        QVndrqJvwK4/nBguKfWZSOU05Q567mzL2rsnIWYzyQ==
X-Google-Smtp-Source: ABdhPJxLDId5VTO4oEjTDELLkH8WswLPJe+6FghXvz5tWfHFwN1I/s5EqT41Yt8d8JL/UUEypBdRnLDBKLOUZyDj8QI=
X-Received: by 2002:a1f:2c58:: with SMTP id s85mr1045350vks.15.1617183674911;
 Wed, 31 Mar 2021 02:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDyKFrW6tXMVa_P=iAPk4FurH9+MGOvJiT7m8B72kz7p0-BnQ@mail.gmail.com>
 <20200401221453.267360-1-patrick.oppenlander@gmail.com>
In-Reply-To: <20200401221453.267360-1-patrick.oppenlander@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Mar 2021 11:40:38 +0200
Message-ID: <CAPDyKFqWrmOt4JQ+uqGKJBf7YxSOFf8JCe=cSLS-i7bhvKdi_A@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Fix scaling of cache size
To:     Patrick Oppenlander <patrick.oppenlander@gmail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 2 Apr 2020 at 00:15, <patrick.oppenlander@gmail.com> wrote:
>
> From: Patrick Oppenlander <patrick.oppenlander@gmail.com>
>
> Resend requested by Uffe.
>
> ===8<===
>
> JESD84-B51 7.4.30 CACHE_SIZE [252:249] states that "the size is
> indicated as multiple of kilobits". This is also supported by Table 39,
> "e.MMC internal sizes and related Units / Granularities" which lists
> "32Kb (=4KB)" as the cache size granularity for 4KiB native devices.
>
> Signed-off-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>  mmc_cmds.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index fb37189..a1b1d75 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1419,8 +1419,8 @@ int do_read_extcsd(int nargs, char **argv)
>                 printf("Power off notification [POWER_OFF_LONG_TIME: 0x%02x]\n",
>                         ext_csd[247]);
>                 printf("Cache Size [CACHE_SIZE] is %d KiB\n",
> -                       ext_csd[249] << 0 | (ext_csd[250] << 8) |
> -                       (ext_csd[251] << 16) | (ext_csd[252] << 24));
> +                       (ext_csd[249] << 0 | (ext_csd[250] << 8) |
> +                       (ext_csd[251] << 16) | (ext_csd[252] << 24)) / 8);
>         }
>
>         /* A441: Reserved [501:247]
> --
> 2.26.0
>
