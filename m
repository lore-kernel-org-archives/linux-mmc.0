Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3088C47084
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92976613BF
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhEXONL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhEXOM4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:12:56 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2538C06138F
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:28 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id h26so2155157uab.13
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/uMjL2lf84q+9pWZKpf0FTOgmT4xPgReXnuOrvEho8=;
        b=R9XqqHDANjOLtdqN5DN03w0iYnOD/Prc+c6xaRwefnKzW44kJrwF/Dr6vQ4gScg5Eg
         rH2xbkiSkrByx1Rhgag60m4DCFT7knlrLPUeWSfG91tOmpn9S6RqM+rfNHHInwg9rRei
         HCXuyBON5fh3zEwzdHtUtGmlPiytwPdMfkVZ5ADMNgg9f0ahbqVJV1c2lCPPH0vL8xOJ
         znczT0yXQ3uWxB7L/VxvkK82Epme3nX8E4PwhxH2ENSOoQnGNtIVndPEi9nf/itj3WZb
         YyUN9ICauqajseW7BDylKnoaQODwcb9xCZbKKBFM586sogAm1DYG7CNY7hWN9F3YaVcZ
         fb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/uMjL2lf84q+9pWZKpf0FTOgmT4xPgReXnuOrvEho8=;
        b=eJ8Nc7xwMWSLhl7ak3CUdPSUmxVhlj5ppxqdGPcX/8xRkjLXENwskuXtc1VxCUea0Z
         VGYRSW2dLvoJRv1fXhi0V5ilgHHoRXVxPF9dfd39eyS6cXdNvpWHyvG57XzgZ5PYTjSe
         hkE7Z6KXjFsnYYHu8ZU/WmGxwGfQ98N274ldS49p6WMQ49OU+SbUdqbPt292Mb2HBh94
         eTdzPty8EH/AWksXdRAriJNP3D35DvD88oFQt9aY2WvSmqzMCrBiErhmTFkbwLcc+hcJ
         rHBFYgoKWRhsFD6tutQpGmDQ07UylOXt18CiZrynSIutcl5lT9/v4H39BluaPZ28+Tdv
         jkoQ==
X-Gm-Message-State: AOAM532qB5hVun4468avEgXtYp0QhVZuJvQ+5NdSdtxvUyVNNF+F7n6G
        a7X/1xsTQ096FKCcqEMiFAW+9W9AM5Zg2SOT/kIJNw==
X-Google-Smtp-Source: ABdhPJzZ6+ui/OLyDG8dNJdtD2Kv1vs6VnJ843ygUBUVkrYXCHDQfQfrUbWkIL94nHSY4GNa2TvlzqCsZ/QAKMkygN0=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr22770864uak.19.1621865488049;
 Mon, 24 May 2021 07:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <1621513304-27824-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1621513304-27824-1-git-send-email-tiantao6@hisilicon.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:50 +0200
Message-ID: <CAPDyKFpgEo=FxZMF47diXOi-TiHs7uyp9_d6wyM7EV5XPAB7pA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Use pm_runtime_resume_and_get() to replace
 open coding
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 20 May 2021 at 14:21, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> use pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. this change is just to simplify the code, no
> actual functional changes
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sdio.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 3eb94ac..68edf7a 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -937,11 +937,9 @@ static void mmc_sdio_detect(struct mmc_host *host)
>
>         /* Make sure card is powered before detecting it */
>         if (host->caps & MMC_CAP_POWER_OFF_CARD) {
> -               err = pm_runtime_get_sync(&host->card->dev);
> -               if (err < 0) {
> -                       pm_runtime_put_noidle(&host->card->dev);
> +               err = pm_runtime_resume_and_get(&host->card->dev);
> +               if (err < 0)
>                         goto out;
> -               }
>         }
>
>         mmc_claim_host(host);
> --
> 2.7.4
>
