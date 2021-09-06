Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355A6C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Sep 2021 17:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1310A60FBF
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Sep 2021 17:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243718AbhIFRLA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Sep 2021 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242561AbhIFRK7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2021 13:10:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDD7C061575
        for <linux-mmc@vger.kernel.org>; Mon,  6 Sep 2021 10:09:52 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l18so12267658lji.12
        for <linux-mmc@vger.kernel.org>; Mon, 06 Sep 2021 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwOCuprYbkSUA/THtMMV9PKpk9+aKaQeh1R3zOdVG40=;
        b=GzKiYy6zYtAnV54IqbOjO7YFzn9kKGQhm6jYExiS0MBAr6pyq82hfVQkFCa0eYPvPc
         H2tDkG+3wOiGQOBGFbgdeKLH302ysm8XRWIK+cRXhcJi0tV3C47gAEXKqmNSMLdxX9w8
         hHur20XkQtjtpG5GbT6Tv4U859Y+byyjBzUsvZessBqI8xpuV3FfAgNMDaKXqmLZ8aVh
         OmklfKxshBDIqbOKCS388omEIUdWdo396Yqwo1tYqOApmjJbe/jvOU8w8A9BgfJGxNEe
         gnMSjZCn00V9bIL31Bmb6v0W7UUh39Dx1ZB0d9+I5RwyMmJyO9ZkEf0MdltFqXeXAieM
         pNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwOCuprYbkSUA/THtMMV9PKpk9+aKaQeh1R3zOdVG40=;
        b=WQHUJXDFEHmDqNxIbMasmOLeGv6P8jyXlc49mQtPgC7PQGHXsXskg+ZEdBEHhxFpfA
         2OQFM9NeDI+M84puCGOc+yVeLMr9OpTCgFdwj1+rN+kggFKjqpVU8D0N9NcItSmABxM/
         zrHLOq5Dr2PxX92mYz3krlUsg56VIXHsPYcH1q71V5c7egTPazrc9D3heaRicyMfcM+E
         4U7nEaS0l6Rlb5f1O3oErGgvDDFYaT6SBC9vFHY5GtJXVtVIlCm8gtI58ia3d7xgqLGj
         Fo+OktltbjLugoznWZ9QwSbECFhTd2PIY4S8PZhKkYDkCRtwA4CaFgXKZjkEz0/XuL03
         KyOA==
X-Gm-Message-State: AOAM532U+jMNgvBh7LbPDAGONEtCrUj1HCS76mHxTCMGBC0gLRIiElyy
        +HYy0FR8AwO5JYJp+khcLRhgRgQhnG696fVAe0JLpw==
X-Google-Smtp-Source: ABdhPJzCI49eG9K/iE8OK4dQtWJnh1Tnn8OnZUgGLomJ8+WLB6GQmHxbUYfXxjiGBLr/LB0uY/5LxPuox/I20BKPjDk=
X-Received: by 2002:a2e:b610:: with SMTP id r16mr11489966ljn.367.1630948191250;
 Mon, 06 Sep 2021 10:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210825094127epcas1p26709a5004dacdb2066e7f21dc1c997f5@epcas1p2.samsung.com>
 <20210825093345.14706-1-cw9316.lee@samsung.com>
In-Reply-To: <20210825093345.14706-1-cw9316.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Sep 2021 19:09:15 +0200
Message-ID: <CAPDyKFomfnik==x5FtJeALr-9oZmjDNAXJiRft8-fXqPU8m0Dw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Change the code to check auto_cmd23
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        DooHyun Hwang <dh0421.hwang@samsung.com>,
        Seunghui Lee <sh043.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 25 Aug 2021 at 11:41, Chanwoo Lee <cw9316.lee@samsung.com> wrote:
>
> From: ChanWoo Lee <cw9316.lee@samsung.com>
>
> It is replaced with a function that is already declared.
> //[1/5] mmc: sdhci: Add helpers for the auto-CMD23 flag
> //20200412090349.1607-2-adrian.hunter@intel.com
>
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Queued for v5.16 on the temporary devel branch, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 36f15f81a6af..5782650ddf7d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3232,7 +3232,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
>                           -ETIMEDOUT :
>                           -EILSEQ;
>
> -               if (mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
> +               if (sdhci_auto_cmd23(host, mrq)) {
>                         mrq->sbc->error = err;
>                         __sdhci_finish_mrq(host, mrq);
>                         return;
> --
> 2.29.0
>
