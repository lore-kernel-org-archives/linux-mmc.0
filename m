Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7235C49EA2
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Jun 2021 10:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9754C61003
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Jun 2021 10:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhFRKsj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Jun 2021 06:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhFRKsj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Jun 2021 06:48:39 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E07C06175F
        for <linux-mmc@vger.kernel.org>; Fri, 18 Jun 2021 03:46:30 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id e20so3232137ual.9
        for <linux-mmc@vger.kernel.org>; Fri, 18 Jun 2021 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CpD+Q5kU9ExZS+Yyb/2wyekLg8hGOlid4qrn2mysX88=;
        b=B1WaCiqMIWHn+Py8IGz4tcQS5fMljich/pg8OBTFtWjfvMXfs2F/e8Va1oRtjm1L1k
         mziLnN5BQllbtDJBWDfh6mR/hIBtN+f2I8yNZ/PUbASsXGVWiQMnbEvqHS+1hpnKFMee
         hpsz38laqP3pHhInRWlurLlC2avT8Ct/f17rR1hNHg3k1jQQUc6Xxy1wfQAMHY69pzqJ
         czn+C4yiXUFOJ69GA/ARtzct1dxKN3M8NL8Nn/6AHoWLXAsm0ogAaM7vrmymN6Flba31
         l7hRiO6pM9xx5FUaqWDyobTCq1sgwn98yawH4na0fVwDDgcPpXQT/ozORDORiGsjlHO/
         osOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CpD+Q5kU9ExZS+Yyb/2wyekLg8hGOlid4qrn2mysX88=;
        b=TKgs9tL0xSC7UKWVsoXtGxTb0iSuxpxv/XuMHRq44fkkKz02CcgZ2dfl1DHPmeYln6
         d/AR0+0hiXQpxJjt+Q7w9HzyzZk7yglJcNf/buMZ4PVd4Mt4cvvQep8032gYqHyB64HA
         5ZSucpdncZJyE3TgctN49w2Lz2Fx+JcbJHbWWk8WJMZods9FNYnyefgtMv+Py57UIlgL
         62dXeV2bNLE3WSXSHpwx739CBgq/V3U0STnaC6TjjB43rh44lo9BAkqqTOP+EFq1ePP8
         opCBbQGmOeclYM1OOJzHXYje/YPfsOjukpRB5ZrXxuqYoGGI9LMbeDQj8hAgPPgl1aOR
         RZIg==
X-Gm-Message-State: AOAM530hWVHoTbPneel3RjhTf6Ms9mas4aIrAO5wG8d1O1xCJj75Tafs
        kCnN27PXggGCQKS/kBs3ZHte3I6mBuH21XMT6qfr1w==
X-Google-Smtp-Source: ABdhPJz5q6uSmZIgqvH4cM/wxmk7wx6QFt+Me6npRtBFZ8w2cwkJ4ghB58Q7g3uDPxZcnewIjO457WJRXdMtnZORwZo=
X-Received: by 2002:ab0:d8f:: with SMTP id i15mr11168909uak.104.1624013189435;
 Fri, 18 Jun 2021 03:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210618073950.46154-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210618073950.46154-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Jun 2021 12:45:52 +0200
Message-ID: <CAPDyKFqNcAomh145-MH8LMKnGDi3zCFASMh-U5DK-xM1rwJqHg@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: disable retuning when tuning
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 18 Jun 2021 at 09:39, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> It might be that something goes wrong during tuning so the MMC core will
> immediately trigger a retune. In our case it was:
>
>  - we sent a tuning block
>  - there was an error so we need to send an abort cmd to the eMMC
>  - the abort cmd had a CRC error
>  - retune was set by the MMC core
>
> This lead to a vicious circle causing a performance regression of 75%.
> So, disable retuning while we tune. Let the tuning complete and see then
> if it worked out or not.
>
> Reported-by Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Hi Ulf, this patch is marked as RFC because I think this is a generic
> issue. Lots of things could happen in the driver callback which cause a
> retune, so I'd think it makes sense to deactivate it globally here. If
> you think this is a driver specific issue, just let me know. I can
> provide a small patch to create the issue for SDHI hardware, created
> by Shimoda-san. We couldn't think of an easy way to reproduce it with
> the fault injector, sadly. Let me know if you want to see that patch.

This certainly makes sense to me! We should probably tag this (or
something along this change) for stable.

However, I would like to get some input from Adrian about this as
well, so I have looped him in.

Kind regards
Uffe

>
>  drivers/mmc/core/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index b039dcff17f8..54f0814f110c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -927,6 +927,8 @@ int mmc_execute_tuning(struct mmc_card *card)
>         if (!host->ops->execute_tuning)
>                 return 0;
>
> +       mmc_retune_disable(host);
> +
>         if (host->cqe_on)
>                 host->cqe_ops->cqe_off(host);
>
> --
> 2.30.2
>
