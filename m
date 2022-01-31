Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBF5C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Jan 2022 16:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380320AbiAaQ0v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Jan 2022 11:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380321AbiAaQ0q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jan 2022 11:26:46 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D917C061714
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2022 08:26:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id i34so7645454lfv.2
        for <linux-mmc@vger.kernel.org>; Mon, 31 Jan 2022 08:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Um0nxT+/Dz9M+g2IG+RC+3lCXucmu9GLiKtAkjfmcOU=;
        b=mJiFKKQt3lFIi8TFpPQStmviBW9loexMRTNcZ/wbcmzNa8d0IXzz/aMe6XVlUB4VVm
         lYvJ7nJNUjUj9KSFFpjYjvY3I3Ibrk7CLmeZSvP8Y8L74hlpplKH84ulqgRabqHi/bIf
         qGzsaxCJ0JBiXHlHznV+uMJ3Z4fwhbIpcSb4RaN3hgAmoVsxfC0xbtXu7Tw0cyr2MM17
         WHfpfpNs9eU2iHuctCKsBioTuKq+0xQETT4x4iHetF0xsrOoxdlvaRTxMq3hczgdLtHY
         AQb3D5dYRbW8YnKWD/GgOeOrLTjj7P80+HbxW/cM3sbudZPIO8EG+OPaQmcyoK0KLBC/
         nvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Um0nxT+/Dz9M+g2IG+RC+3lCXucmu9GLiKtAkjfmcOU=;
        b=OFqszkwJhHOfFj+XCZ4Lw80xX3uuTgZdteoXvM8TcuTTmG7hyDMkXRAvdneM+X5jSR
         Ye30p02AdOZO07atztLLDg8y1LvGqP8+Iwi5GwkZgj/0Z8otcPJS5HIsyt1gtWoYHY71
         f36IaEjkhO2kTTkkmvYlHKNDIgaR4qtWdRjPI+fp9M/avNXsqjDUsr6/cxopAQmVeVXQ
         OeQ+Judz2gwaIkUQzc0ktBImzFsst8URn4MGpKsLYjT5NOP41LXvQG5zcFxUo2zFjKW5
         U5yM8Lh13ZPVYrcNyMn0tQdq991hcob/5CK/Q3gRpOtaFBYJOcYDN96R1ArAiGJT1TbV
         s6dw==
X-Gm-Message-State: AOAM531khNCy5c3D8emYxXxxcZSQ7NUbiWzkYH7OnH9lX4IsNCGNszvf
        E+HrtYdKUVCyLikoCLc3jgUrTpWX0AljSMxIb8McSQ==
X-Google-Smtp-Source: ABdhPJyGFfbB2Oqh8e/kxYcSwVZwwem0ItXiqbGKvY3VTiqxwE1IjRZm8D9+/KZXUgbap/NMtNEVueW6DdDQnCy0arg=
X-Received: by 2002:a05:6512:3b9a:: with SMTP id g26mr14576820lfv.71.1643646403897;
 Mon, 31 Jan 2022 08:26:43 -0800 (PST)
MIME-Version: 1.0
References: <5e22c587-5698-e132-4429-48674a6ddbb7@omp.ru>
In-Reply-To: <5e22c587-5698-e132-4429-48674a6ddbb7@omp.ru>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 31 Jan 2022 17:26:07 +0100
Message-ID: <CAPDyKFrm5==gBSZBuPWYU+AcNxYz8K_=X_=5k6JnHN+3a9-bug@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi_sys_dmac: use DMA_SLAVE_BUSWIDTH_UNDEFINED
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, Vinod Koul <vkoul@kernel.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Vinod

On Fri, 21 Jan 2022 at 21:38, Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> The 'dma_slave_config::{src|dst}_addr_width' fields have the *enum* type
> which isn't isomorphic with the *bool* type, however is used as a boolean
> expression. Use the *enum* dma_slave_buswidth's value corresponding to 0
> instead.
>
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.

I have no strong opinion, but just wanted to make sure this is inline
with what Vinod wants.

There are not so many users checking DMA_SLAVE_BUSWIDTH_UNDEFINED,
perhaps we should simply drop it and instead leave the checks below as
is?

>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Kind regards
Uffe

>
> ---
> This patch is against the 'next' branch of Ulf Hansson's 'mmc.git' repo.
>
> drivers/mmc/host/renesas_sdhi_sys_dmac.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: mmc/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> ===================================================================
> --- mmc.orig/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ mmc/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -370,7 +370,7 @@ static void renesas_sdhi_sys_dmac_reques
>                 cfg.dst_addr = res->start +
>                         (CTL_SD_DATA_PORT << host->bus_shift);
>                 cfg.dst_addr_width = priv->dma_priv.dma_buswidth;
> -               if (!cfg.dst_addr_width)
> +               if (cfg.dst_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
>                         cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>                 cfg.src_addr = 0;
>                 ret = dmaengine_slave_config(host->chan_tx, &cfg);
> @@ -389,7 +389,7 @@ static void renesas_sdhi_sys_dmac_reques
>                 cfg.direction = DMA_DEV_TO_MEM;
>                 cfg.src_addr = cfg.dst_addr + host->pdata->dma_rx_offset;
>                 cfg.src_addr_width = priv->dma_priv.dma_buswidth;
> -               if (!cfg.src_addr_width)
> +               if (cfg.src_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
>                         cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>                 cfg.dst_addr = 0;
>                 ret = dmaengine_slave_config(host->chan_rx, &cfg);
