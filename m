Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A554C43214
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D696330B
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhHPOA6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhHPOAh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 10:00:37 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CEBC0613CF
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:59:58 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 139so4457866vkx.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDUWY3GY2mcEb/nLBHZCA1OKpwYdreH3U1Cd8PeotHo=;
        b=VhnhWK6dXGQKKVC38h0kpgz6ETTiqlvoFff54sHnV52cMVjCBaUaS1u2v3rLPQf6TL
         l4+EaG6fNdd1glA8pikVkRDJHc82C0vQSOvFbbijNLjOPDOqd8BeTrIJsi8+ROkXIs2f
         U+GeNBU3fijU7IIXdShjMUonp/XUVK9MYxiBMNGZvuwubZFZ1C6TL+7FA2B7sivopJnW
         UyuQKX6i3y0DwbWXLB+Ab1GMC0/Opa1Z0wx7CjC2+0Akf94wjdzBS3KmQ6VyPRMTKlnX
         mqQ8N/lssgw0yLgOO2DBkpUhxE3pUGFtIl6+3aF3SMnXJBgv/kJlYP6w+H1I6xVCqRRJ
         paDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDUWY3GY2mcEb/nLBHZCA1OKpwYdreH3U1Cd8PeotHo=;
        b=J+loMH29mVFPRqQLkLdCKImYRiX9KTUsVuiUohH4MMhbLX0/PEC54/g5izRLJ/gsRk
         s4KW1hDMWTaprrq7XKWSbx/iZ6iLu97smqNF1HZP9yBsQMeLllZeYd4WKedtNk28RNyV
         ePdut1ctRYjf8rqFCOqd7gpyakJrZLt4oY37TuS5sV8P9h+l4X32eVF5Y0oVtME5kpCn
         SGQt3RiUrINNdSgKdicsdZ57t/8dlF+pDsR1r7ug2EXsMTFds+vmaLKnxyxgA0cpud5S
         WrwcO9e7Xyo5pMXbJYUqo9tQFRhaAOa3oQjBe7BebnHDvh0PkDZtCgvs1dOlqhelznkN
         Hbsg==
X-Gm-Message-State: AOAM533x8+Nc8PqWvzMIUofAyJU+i7bHwfLmQhpYwTfmV1kZzouWi7UY
        xVi3GOVEnNiVeSNAI8FdxxDOIasDZqDbb8zzWR3T8A==
X-Google-Smtp-Source: ABdhPJwx+EpE6BMNMks7bP67b6mI8BGq2FeaIe4CCjinB1aVIpP7RHttCRzWfwsgj8bp7Y3f18NTn9C4gqoKOFU/css=
X-Received: by 2002:a1f:a555:: with SMTP id o82mr9094018vke.8.1629122398119;
 Mon, 16 Aug 2021 06:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210810081644.19353-1-tony@atomide.com> <20210810081644.19353-3-tony@atomide.com>
In-Reply-To: <20210810081644.19353-3-tony@atomide.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Aug 2021 15:59:21 +0200
Message-ID: <CAPDyKFonwD1-EZsC3bSBM=x9=8zAJEzAKEr78URv-=bmaVxdSw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: moxart: Fix issue with uninitialized dma_slave_config
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 10 Aug 2021 at 10:16, Tony Lindgren <tony@atomide.com> wrote:
>
> Depending on the DMA driver being used, the struct dma_slave_config may
> need to be initialized to zero for the unused data.
>
> For example, we have three DMA drivers using src_port_window_size and
> dst_port_window_size. If these are left uninitialized, it can cause DMA
> failures.
>
> For moxart, this is probably not currently an issue but is still good to
> fix though.
>
> Fixes: 1b66e94e6b99 ("mmc: moxart: Add MOXA ART SD/MMC driver")
> Cc: Jonas Jensen <jonas.jensen@gmail.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -628,6 +628,7 @@ static int moxart_probe(struct platform_device *pdev)
>                          host->dma_chan_tx, host->dma_chan_rx);
>                 host->have_dma = true;
>
> +               memset(&cfg, 0, sizeof(cfg));
>                 cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>                 cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>
> --
> 2.32.0
