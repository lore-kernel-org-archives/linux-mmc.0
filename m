Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DCBC63697
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 11:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EED520872
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 11:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="zOqStgub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgKRLcK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Nov 2020 06:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgKRLcK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Nov 2020 06:32:10 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11641C0613D4
        for <linux-mmc@vger.kernel.org>; Wed, 18 Nov 2020 03:32:10 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id s9so1927936ljo.11
        for <linux-mmc@vger.kernel.org>; Wed, 18 Nov 2020 03:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ROaaptIlFxoZPMh3eKEr9Wb/hsxjEjQvBKY/Z69few8=;
        b=zOqStgubbQ3/8E2vL1xD/qXQpcrzaF8nB2WPdVr3OzCwzEZpHetRrcTOGlsTL+7N+0
         b3TmGgSSooh4L74hOLtcdLPaANx7cCXLEqRAE7iZv6BT16ia3xbkf4ThjXnXuChFjtlX
         SVOqvokV6Mg/LeLD2atnxJHeOdjmap5omPu8BG8wZCr6xi7dAz8aRNQhoqnUizyt7RP8
         bD3YVDHrr1jyhfMHjwZKa4jiSN4QBvoWvheOjLvHNkhSR5/7nmZyoWAQa8WABvjmBfKf
         xoJGj4nkfwdt2QlSmL62KQQgZI/JisXsdwOmGO328pzJRPkYQjTFlm4xxEP4cbVZkSTw
         8lEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ROaaptIlFxoZPMh3eKEr9Wb/hsxjEjQvBKY/Z69few8=;
        b=ErhAnfykYa8+ZUFoLIYHpoP9q8hbiDCxSqyrdgB4EyVgMd1yoE+I2qxHPP4f8xSzCr
         BRD3PqICyLjPQfK7r/1YrLd2Ztcu0Qb6COFI0bdszjPe5OdTPQUEGa29HWgF0/AKxya4
         Gtmqmi9TZRbHdU4HqMUUu+YktM/IarWTBbrJf4zZJfvaf/0HTxkfKis0ZiDmjY8BTNbD
         lyzX9pjoLP7QiUosN5zLWblamOqKxCY046zmLb/a4hCyxAQVe04m3vQwG9LrjDlV4Mgo
         /PPwP5cJuDkXKQFf9/fDiTgWVIpd3OPjX3UyQwsAloOCeXYleneedOCQFji0wTz1d8l1
         bFyg==
X-Gm-Message-State: AOAM533ZUBDB0e8kzVo1EINV1BAjFIqCkht9oXs6p5OhUj6TrHR81Imc
        YqOOxc4bVWzVoPHan+dDyqXsJQ==
X-Google-Smtp-Source: ABdhPJxJ9Q0RTB4m+hFWfIFhNjC99Bgbkj0I4lz1SLIe8idmirlmZuz2AmjpUJL0BNQj7tuPTPRYtQ==
X-Received: by 2002:a2e:8641:: with SMTP id i1mr3876075ljj.134.1605699128567;
        Wed, 18 Nov 2020 03:32:08 -0800 (PST)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id d12sm3231618lfa.22.2020.11.18.03.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 03:32:07 -0800 (PST)
Date:   Wed, 18 Nov 2020 12:32:07 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>,
        Takeshi Saito <takeshi.saito.xv@renesas.com>
Subject: Re: [PATCH] mmc: tmio: Fix command error processing
Message-ID: <20201118113207.GC3118893@oden.dyn.berto.se>
References: <20201117131337.35307-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201117131337.35307-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2020-11-17 14:13:37 +0100, Wolfram Sang wrote:
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
> ---
> 
> Because the test case is hard to reproduce (lots of radio noise and
> temperature changes), I trust the BSP team here. But the reasoning makes
> a lot of sense to me. I verified that there are no regressions with the
> test cases I usually do. The patch is based on mmc/next as of today,
> i.e. with all previous series included.

I agree the reasoning make sens and the patch looks good,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

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
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
> -	if (mrq->cmd->error || (mrq->data && mrq->data->error))
> +	if (mrq->cmd->error || (mrq->data && mrq->data->error)) {
> +		tmio_mmc_ack_mmc_irqs(host, TMIO_MASK_IRQ); /* Clear all */
>  		tmio_mmc_abort_dma(host);
> +	}
>  
>  	/* Error means retune, but executed command was still successful */
>  	if (host->check_retune && host->check_retune(host))
> -- 
> 2.28.0
> 

-- 
Regards,
Niklas Söderlund
