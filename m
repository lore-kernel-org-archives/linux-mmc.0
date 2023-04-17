Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DABDC77B76
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Apr 2023 14:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDQOt2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Apr 2023 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDQOt1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Apr 2023 10:49:27 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5771F5FE8
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 07:49:26 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id o11so7136963ybk.11
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681742965; x=1684334965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WxXndlId4ohZGjntL7iThgXNUysxJnkyV1SPpbL6TWE=;
        b=LCs6AsAgq0GyOiYOlwAzNLdQYWSuGgLA342sdAlgcwBR69wAOF8eThbjdAk3r2VJbo
         cK4KdE7XfbbPA+jRn9YzNDfa8BKhEdi36WSLfxudFKYjR4IJgSBUOlQxQ+hudZOrl3CN
         LNZfuGANyOoy/9TNSltW0fjnqgpHR7Giyo2qS8gMfPfwCMFIEdqbU0MSt6XwtW5wo8sG
         W2+XN9yW+MldaypfbEwLmCxHy0qdLoHCVzlfROpVHlgAOamP62JbBoX3fA+SHwSXONgo
         eX4NUfh4S0LxvXV4BGgzB7ygrEvsEkasmtdWpYyXf8ueOes82pdq65RyNIXL7/hhIMFP
         c15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681742965; x=1684334965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxXndlId4ohZGjntL7iThgXNUysxJnkyV1SPpbL6TWE=;
        b=Rm7Sxbb8mHxNLchIG66q9CoPxtEOmrJKtdszRUsAOUB6DQBdXWg6I/iFM3lFNIYjOb
         mEwgZdRSigGXr3u19diRkaIduA6oARQ/fOQeXBIZZnJXQtMN/a9BfS24Yk3iinLDtDU1
         5cpYpvAh+94ThfWeUgNQxCUxcfdi34izEj0UBL5UVj1h62YkC4NFr10Tu7e7/mAJ5KZy
         mMhGik2pMA09xDHsr53sU24aN3HztK77lvsP4opvaWwFtNWYZlFhFuILfUa7zZV5r4/Z
         I4fu15FKnbrWzEybSLh09PM/mwd7wSRpj+sTEk3lVItta3aWfHqjQHZVHhbiYMraRWL2
         hQBQ==
X-Gm-Message-State: AAQBX9d90B7uc0TshPThsqBt0nk4Xuf6F0L3dT36LDPog1e91CvFNBg4
        ypLtidsnOs2yyfi6M45APzBrT0GwN9aBG7uld7m6qJ3xf7sKEspA8+s=
X-Google-Smtp-Source: AKy350aFddSft+67I+ym9T9ozH6nJhyR4qQOTiYtkLZNDUD1zROxZMSEdxVBKmLzQLcxvjWiIkuoynoRtN4wV+2UTXk=
X-Received: by 2002:a25:ca52:0:b0:b76:ceb2:661b with SMTP id
 a79-20020a25ca52000000b00b76ceb2661bmr9800406ybg.3.1681742965484; Mon, 17 Apr
 2023 07:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org> <20230405-pl180-busydetect-fix-v2-10-eeb10323b546@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v2-10-eeb10323b546@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 16:48:49 +0200
Message-ID: <CAPDyKFptLGySEz3ygoacQ00rk69DKP=1wrt1Hq-weSMASwkF7w@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] mmc: mmci: mmci_card_busy() from state machine
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 9 Apr 2023 at 00:00, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> If we have a .busy_complete() callback, then check if
> the state machine triggered from the busy detect interrupts
> is busy: then we are certainly busy.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Do this in a safer way that falls back to reading busy
>   status from the hardware if the state machine is NOT
>   busy.
> ---
>  drivers/mmc/host/mmci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 9a7f441ec9d6..180a7b719347 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -339,6 +339,12 @@ static int mmci_card_busy(struct mmc_host *mmc)
>         unsigned long flags;
>         int busy = 0;
>
> +       /* If we are waiting for IRQs we are certainly busy */
> +       if (host->ops->busy_complete &&
> +           host->busy_state != MMCI_BUSY_IDLE &&
> +           host->busy_state != MMCI_BUSY_DONE)
> +               return 1;

This looks fishy to me.

If this is needed, that means that the mmc core is calling the
->card_busy() ops in the middle of a request that has not been
completed yet. This shouldn't happen - unless I am misunderstanding
some part of the internal new state machine.

> +
>         spin_lock_irqsave(&host->lock, flags);
>         if (readl(host->base + MMCISTATUS) & host->variant->busy_detect_flag)
>                 busy = 1;
>
> --
> 2.39.2
>

Kind regards
Uffe
