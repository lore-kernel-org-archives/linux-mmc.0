Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F2BC4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Aug 2021 11:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB76B601FF
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Aug 2021 11:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbhHKLhM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Aug 2021 07:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbhHKLhL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Aug 2021 07:37:11 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D97EC0613D3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Aug 2021 04:36:48 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 11so558685vku.11
        for <linux-mmc@vger.kernel.org>; Wed, 11 Aug 2021 04:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=amH86pdEpwFZQx5PgrEAT4AyyUP4xmw2x8rvFH0W/ZU=;
        b=LP7rXoHsIku55aaoTCdqBMCY5LhNQLEr8KFwEo0z68iD2sXWac6MfNhOqOZfEWnB1U
         HwmxA/UlbkX6CEbPtXe9mtrc9B1ruwI7hSqGqe46n7ETgAly1C1wikXSFEkgDFqoUU//
         0t+vtvECchw9+6fPL2gzsLS54xjpTLWCzJa8eAwjqzive+F8ge/UVYlUNwgAnh0iN1Uh
         cafWGJMAiAVnP8MQ2dpSfOMQHIUMXu0w2zQ6nWDHuoI65Z1WdvwCJUiDV4Wh2sovu4JE
         kkXDavDWTg59gbj/odZ+EX6Fmt3Tg4UEvueFCC4M/9Z/kq9aq2RiIiWAjrcXxUkxswww
         TThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amH86pdEpwFZQx5PgrEAT4AyyUP4xmw2x8rvFH0W/ZU=;
        b=fzsV2cv/EZ00RAkwTu7NioREXqgfzGtr2jWjP487Wvbzxz5LTJbF9NcfzW4GLV3vGM
         kCl/CUuqo4HC84R273nedbfmbRONduKu1PghnLm2IWi2IRgDDAJWIUINZpAEz0qhZn4M
         VH4bvTeTzrbPN199w+rGtC+9DIm7BVWWClojaOGjqW97xAdIdPXfHCLDqWCq4cIuDWYP
         BQI/yd1CYjE73vH3lMrd7smBcZ4x2Xt6WoQKdQ9j7eS0mrG8WuOOSf1o3YVDepYLnbYk
         ormOVQy9N6/qPD2iyZWWvDqdR3Jl4AIEMAMM2/CNhZvotntxjzMj7Lfzc/xCpGppeW6Y
         tz/w==
X-Gm-Message-State: AOAM533qyuYybqqY+/NNTHk4LikRsUZQqwonM0AFrWzwI2L84zvbnefQ
        oeiZrUnBUTwzMcjyoq/rptLMuhj4C3QT1jqyQ2dOrg==
X-Google-Smtp-Source: ABdhPJwRMM9NLVopsXqxxHe/H4ER6vCPdLjvbWhBk3Nsz3qppUrTWQTn2ZFBHah9uqca6IOIH+osC0NhsgjmCz3D/hQ=
X-Received: by 2002:a1f:a301:: with SMTP id m1mr21755169vke.6.1628681807503;
 Wed, 11 Aug 2021 04:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210729072929.10267-1-jbe@pengutronix.de> <20210729072929.10267-2-jbe@pengutronix.de>
In-Reply-To: <20210729072929.10267-2-jbe@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Aug 2021 13:36:10 +0200
Message-ID: <CAPDyKFrkDb0X24F4cTopOF24sKWv4oxYqxv6U3jKbnRLMEF_Qw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: mxcmmc: really configure the DMA on demand
To:     Juergen Borleis <jbe@pengutronix.de>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Doug Anderson <dianders@chromium.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 29 Jul 2021 at 09:29, Juergen Borleis <jbe@pengutronix.de> wrote:
>
> Calling mxcmci_use_dma(host) is intended for the next transfer only, not
> for generic detection if DMA is possible. Without this change, the DMA gets
> never configured and thus, never used.

Wow, that's an old bug you found there.

>
> Signed-off-by: Juergen Borleis <jbe@pengutronix.de>

It looks like we should add a fixes tag and add a stable tag:

Fixes: f53fbde48ef0 ("mmc: mxcmmc: use dmaengine API")

> ---
>  drivers/mmc/host/mxcmmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 2fe6fcd..611f827 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -834,7 +834,8 @@ static void mxcmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         else
>                 burstlen = 4;
>
> -       if (mxcmci_use_dma(host) && burstlen != host->burstlen) {
> +       if (host->dma != NULL && burstlen != host->burstlen) {
> +               /* reconfigure DMA on changes only */
>                 host->burstlen = burstlen;
>                 ret = mxcmci_setup_dma(mmc);
>                 if (ret) {

A few lines below here, you should not clear host->do_dma, as it can't
be set at this point (thus clearing it just adds confusion).

Also I wonder if patch2 is really needed to fix the bug, or should be
considered as nice cleanup instead?

Kind regards
Uffe
