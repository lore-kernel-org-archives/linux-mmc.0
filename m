Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED23C433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE7564E66
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhCCBqN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349593AbhCBKm2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2021 05:42:28 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53391C0611C2
        for <linux-mmc@vger.kernel.org>; Tue,  2 Mar 2021 02:39:48 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id o20so28225uaj.9
        for <linux-mmc@vger.kernel.org>; Tue, 02 Mar 2021 02:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uqD7e6snPAg+REOGnvL5UhMkN7faVoII5yYXfeiMIHw=;
        b=iAImHneZGy76BnvMMrVFqGOfHaW5X5/iQ00pVhKUf/qeklkuG6qsOf9pMnhEOqMqW1
         QlDL7SJ5JE7F/oK5yuLHndHQzeUGPJfKH7YXDhROi7F0EOqbj6s0j/cYc43c5wQMHi+b
         nRxlGbIUCfY2CnkmRtGVugR5ovYg+UNjIG9mURXtDJhdyluYyLKAQha0ay/B0muoEfCZ
         mkUvEjWmYveptFfDy9zwnD69AJ2NRc3xhAzuBMv0HqyiJuirZFEBmI8C8fM7mnvUkH5C
         5SPSP4mVSz3H+L70q6qkI1nBK+RcK4MdVoKTkP2EV589vrpGfWLA8bdbzff8lLYdnaIR
         c8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uqD7e6snPAg+REOGnvL5UhMkN7faVoII5yYXfeiMIHw=;
        b=MNP+gH0FGixxSJ4LUxkXvZq1duF5Cbh1DqyRdJ2AiwVnoqZKE8/Adx20mTWzzF1F7V
         RKLj2jKTBxEofuX5rcZCUGkmBV5QSNkJGxcjbSQvnX01hWJQLxBn089RDE+ywixVGUpk
         aEf23fCcLooE143pEAG1vO66pUFuxfyuawkhh0W0cXV6QqSu5VFWObld6X8qIYcWOixc
         SfWghjTHSj99PZCvtRpboO1GKMuD74O0MJThbqMsl0XjmI5ve48u8NrHm7RZR2OR1a3E
         Asj8WBd69bfiHo6yVwtRQBtVecbBhOsoIwmq88N4ushuYG+ZTEMmqbAZ3P90Da1Y/mT2
         Ve0A==
X-Gm-Message-State: AOAM53141jXaL2sxx/n1ajI31SP0b9F+RjgJoTvP93IJCHLOr4EQABlW
        ucAyftJOyUbTtpDuHs56JdvUIYizkdDP5rhaaHNyxQ==
X-Google-Smtp-Source: ABdhPJwuumk8VdmG6aZhUft9BtFUdPFYTvE0ulgyGtO2w5vys5dMZsUFjlKYiKQY/2Cxj9nRcmAYNQAaqHG1Ud/QtE4=
X-Received: by 2002:ab0:6045:: with SMTP id o5mr10028156ual.100.1614681587573;
 Tue, 02 Mar 2021 02:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20210223100830.25125-1-wsa+renesas@sang-engineering.com> <20210223100830.25125-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210223100830.25125-2-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 11:39:11 +0100
Message-ID: <CAPDyKFrdxYNBeV4Fy_NJ+1JdF9OtHaxXmSdnvyepAPH4cxUs2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: tmio: support custom irq masks
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 23 Feb 2021 at 11:10, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> SDHI Gen2+ has a different value for TMIO_MASK_ALL, so add a member to
> support that. If the member is not used, the previous default value is
> applied.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

To be clear, I am awaiting a v2 of patch 2/2.

Kind regards
Uffe


> ---
>  drivers/mmc/host/tmio_mmc.h      | 1 +
>  drivers/mmc/host/tmio_mmc_core.c | 8 +++++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 2d1db9396d4a..7d5201d6a006 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -164,6 +164,7 @@ struct tmio_mmc_host {
>         u32                     sdio_irq_mask;
>         unsigned int            clk_cache;
>         u32                     sdcard_irq_setbit_mask;
> +       u32                     sdcard_irq_mask_all;
>
>         spinlock_t              lock;           /* protect host private data */
>         unsigned long           last_req_ts;
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 0e7a2faa5238..eca767dcabba 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1175,7 +1175,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
>         tmio_mmc_reset(_host);
>
>         _host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
> -       tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
> +       if (!_host->sdcard_irq_mask_all)
> +               _host->sdcard_irq_mask_all = TMIO_MASK_ALL;
> +       tmio_mmc_disable_mmc_irqs(_host, _host->sdcard_irq_mask_all);
>
>         if (_host->native_hotplug)
>                 tmio_mmc_enable_mmc_irqs(_host,
> @@ -1229,7 +1231,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
>         cancel_work_sync(&host->done);
>         cancel_delayed_work_sync(&host->delayed_reset_work);
>         tmio_mmc_release_dma(host);
> -       tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
> +       tmio_mmc_disable_mmc_irqs(host, host->sdcard_irq_mask_all);
>
>         if (host->native_hotplug)
>                 pm_runtime_put_noidle(&pdev->dev);
> @@ -1259,7 +1261,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
>  {
>         struct tmio_mmc_host *host = dev_get_drvdata(dev);
>
> -       tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
> +       tmio_mmc_disable_mmc_irqs(host, host->sdcard_irq_mask_all);
>
>         if (host->clk_cache)
>                 host->set_clock(host, 0);
> --
> 2.30.0
>
