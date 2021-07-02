Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52139C11F68
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 15:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2888261413
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 15:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhGBPDZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Jul 2021 11:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhGBPDZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jul 2021 11:03:25 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019FC061762
        for <linux-mmc@vger.kernel.org>; Fri,  2 Jul 2021 08:00:52 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id j4so2069129uae.6
        for <linux-mmc@vger.kernel.org>; Fri, 02 Jul 2021 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DMcS3XXpKDZ+DGoKYyi/2bjhrH8C1s1OvCcE0f7dHw=;
        b=QfWYYwBVlDQ2opjtyN1r4e1JE4EfXk1ih3nvt5FLRaGztp54k5jjQvs8+F1jqKcO1m
         bZlWKE9IaDQsODFbxcO9KZNrNJn11Kt3VoRClS6PqVmsRw0RzcBzXtOvV/nUihpeuaS4
         2Q703G3oZvgdfdLM9rorJUyZZ+gTjCItwTloFGBy0zQsGJhcWN1dMlj/WwbKelo/xttf
         gVoEG6J3vOWlIvBZP1+kVrHNVprfFnrmxW55XmGg8vIQSfOlb7FB3FeNRlp8GGMQQJ56
         ktCc6aFKzEKCGFmnzNGqqO9LeEkoOMSri1SnLOMo+2010K1d1T6FimOMBAseWKp8Vx/M
         q8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DMcS3XXpKDZ+DGoKYyi/2bjhrH8C1s1OvCcE0f7dHw=;
        b=fGTyWkEAKOqBsuxUIdcpmNqF62vpT30w880R43r1vTlMb4rdOAmLapXX2ZZUWivggM
         +gKTiIHvDRE2LqJgfGym0VvDgKdKaFL6YkfswjeC+nTnRkwdJ8L6XNLN/olqMqzm7R9e
         0HuXYVF3Pl6Rnn3V/5dYgikrZm5C1nr8wSNYeHRdGY0WBPNUgqf6IBGbX738i0WwqACA
         cDtnI5JgOgvFWBGhJxcLaVxMna5dd149kxN9s3kL4JYWTHcnUJNXyT7uLWiltZQF8Yf+
         0xCgBKeLhCFuWrK7i9bfXa8tM7Kg0VyGiKBylhFxrAwVPyLwiTA5mMyC+RtoUy4gKqIR
         w6SA==
X-Gm-Message-State: AOAM530n7CCoy8gmIHDMzb0GovioiO0EgWDE9mVNUOMribyfY+Qksnis
        fSAFTIsyFkhO26VCrTHQzdx+tHsxxqifJFSfiPflnXC/T1TBcA==
X-Google-Smtp-Source: ABdhPJwfE/p/+oq9sCXwcPAe/ZweKnsphobJXELcp1iLRjopJ1rGNTE7m/UV7x8ce9B5EHpy4H1WM16Mpo6nQOwcpmI=
X-Received: by 2002:a9f:2f14:: with SMTP id x20mr372082uaj.104.1625238050823;
 Fri, 02 Jul 2021 08:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <1623134576-212150-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1623134576-212150-1-git-send-email-shawn.lin@rock-chips.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 2 Jul 2021 17:00:14 +0200
Message-ID: <CAPDyKFru-h=ypz2WN1Qoz0_XEa6ym6HD0OhEm6nx64C_Chef2Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: block: Use .card_busy() to detect busy state in card_busy_detect
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Jun 2021 at 08:43, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> No need to send CMD13 if host driver supports .card_busy().
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Shawn, I just sent a small series that moves the mmc block layer into
using the common mmc_poll_for_busy() code. I think $subject patch is
better to be discussed as an improvement on top in that series.

I already have some thoughts about it, but I will be awaiting to
provide you with some comment around it, until there is a new version
from you.

Kind regards
Uffe

>
> ---
>
> Changes in v2:
> - fix build issue
>
>  drivers/mmc/core/block.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 88f4c215..379614a9 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -417,10 +417,17 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
>         unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
>         int err = 0;
>         u32 status;
> +       bool busy;
>
>         do {
>                 bool done = time_after(jiffies, timeout);
>
> +               if (card->host->ops->card_busy) {
> +                       busy = card->host->ops->card_busy(card->host);
> +                       status = busy ? 0 : R1_READY_FOR_DATA | R1_STATE_TRAN << 9;
> +                       goto cb;
> +               }
> +
>                 err = __mmc_send_status(card, &status, 5);
>                 if (err) {
>                         dev_err(mmc_dev(card->host),
> @@ -431,7 +438,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
>                 /* Accumulate any response error bits seen */
>                 if (resp_errs)
>                         *resp_errs |= status;
> -
> +cb:
>                 /*
>                  * Timeout if the device never becomes ready for data and never
>                  * leaves the program state.
> --
> 2.7.4
>
>
>
