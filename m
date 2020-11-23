Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF4AC56202
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 16:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6752320782
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 16:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3xM+YIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbgKWQH2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbgKWQH2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2020 11:07:28 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABDFC0613CF
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 08:07:28 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id s123so8735469vsc.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2020 08:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01T8i2higIPcJjxKqbsURk/bCiDazYvW4xBU5Unn5jE=;
        b=e3xM+YIUfdKiXMwJIC7WHNKp+PDF43OKC1P3S3XID2bbAWdBKFipD+7GfX9ukLE9+g
         q7+nTCSnBaxYedwf2ea60chAzB0b3HMvR2EnQQ4gAVwHldcmZDIuwLXgEeqvKPixBCMb
         1ArvaVwMGywjMj/eynHCC15DFMhu3TFxXdf8JRAMZpyC7MjMI115bkRkLUPxjEtmJkLx
         uG3+dAyRZLAqrM6V0gTu1CqLM6dMQMZb6cw2tFHyzbpEk+V5yFLfkcpQtuVhyLrjQKAW
         rbCPmBa91GXXlmxK+gs3REWms46aJt/+dltnvj+aB5rsX9o0JS//+VOcIX4S1ge8jhXv
         D6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01T8i2higIPcJjxKqbsURk/bCiDazYvW4xBU5Unn5jE=;
        b=N7VqLLi+bVCUmgUkl7v2CR/ltxyC68fM5vBN3GP/KRotl2+gEof6HH/F1xs82ne69h
         4RT4RcjMaRGJPj/Xa+/G1DTWEBqAXFwS+lOI3X/nuFQBq+grnGzZxRt0PLiYyUmB53uq
         ZqZ8W50NAWvWvYuJ20D9IzP/guxqrO1eOhZKiO+HoyHPGTiLXXLdjHLfiJO7pqpL6WPA
         bIFZhMwj9lFOl1/Zvt9OaYq53GAP8OgyLOJ5t+05NHaOaDE9hkx4hJEB/DBHMAqgmq7p
         NXlExpAnLe93gyJSPV8UYzNa/BvXLK8V4fgP/q5nm8iAp898yO4v08GaWe8KBAy9ncAc
         UHZw==
X-Gm-Message-State: AOAM532181aRa+wZtoCiMdx+/Co5BSZ5HQtO4grBoeyRSm8mdpdFFh0c
        FXKFCzSd5S2CnSTulQN1yul90pGFzTS9ghpX0K9DrX2AiL45SQ==
X-Google-Smtp-Source: ABdhPJzeaOPLWe6Z4vWEAedLOKrO9CwI/XNyVvf4xThoo55EzZndxUGYkpPAewh7TJ67lJ0sQgmT/XO0VX/0o9pRLp0=
X-Received: by 2002:a67:3357:: with SMTP id z84mr380435vsz.34.1606147645555;
 Mon, 23 Nov 2020 08:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20201117131337.35307-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20201117131337.35307-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Nov 2020 17:06:48 +0100
Message-ID: <CAPDyKFrhKRJ7imTb=YsZbHCfBTunRhctngJ+HmRyoCqocXZM_A@mail.gmail.com>
Subject: Re: [PATCH] mmc: tmio: Fix command error processing
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>,
        Takeshi Saito <takeshi.saito.xv@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 17 Nov 2020 at 14:15, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
>
> If some errors are detected at the same time as the access end
> interrupt, the access end interrupt was not cleared. Especially with
> DMA, because then the access end interrupt was never enabled and, thus,
> never cleared. Clear the interrupt register always when a command error
> occurs.
>
> Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> [saito: rebase to v5.4]
> Signed-off-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
> [wsa: rebase and extension of the commit message]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Because the test case is hard to reproduce (lots of radio noise and
> temperature changes), I trust the BSP team here. But the reasoning makes
> a lot of sense to me. I verified that there are no regressions with the
> test cases I usually do. The patch is based on mmc/next as of today,
> i.e. with all previous series included.
>
>  drivers/mmc/host/tmio_mmc_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index cb4149fd12e0..7f4a28125010 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -796,8 +796,10 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
>
>         spin_unlock_irqrestore(&host->lock, flags);
>
> -       if (mrq->cmd->error || (mrq->data && mrq->data->error))
> +       if (mrq->cmd->error || (mrq->data && mrq->data->error)) {
> +               tmio_mmc_ack_mmc_irqs(host, TMIO_MASK_IRQ); /* Clear all */
>                 tmio_mmc_abort_dma(host);
> +       }
>
>         /* Error means retune, but executed command was still successful */
>         if (host->check_retune && host->check_retune(host))
> --
> 2.28.0
>
