Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D7DC4320A
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F361063322
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhHPOAz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbhHPOAh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 10:00:37 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2228C061764
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:59:56 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id y14so7592103uai.7
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ih6l3GUYDQo8G5Xp6gmRAuzPpzvzTU7E0Xuxw7hUhrw=;
        b=re7rzrqlJSi0VW8NsI+xlZV0TWkdZx8bje8a+H5KqplAnemCj44RQdxSPC7w0kF+lS
         zpG7RyVtG16nnBGZPNgeyJBBOcmcKeENd3un/xZVJZAAVjoq33B1BfnL9A70be9TQkt7
         zUBqVS7IBV+AroAY0+linLQUBqvpzdANgHKelOsbesOQP5T4kliWWo9JxHJllxp7iwlq
         kjD9/gb2L0XjwVTp6VaWD9XQZ/c+G+wiauZ/Y7uy2fGQLzQeyzm0LUhYwI2LH3j2HtnO
         xnbBVfYPstT3ZIJV/jNMOepNhfzrqbn/vfbmDhcf81EdDBWEIfxMIyhR63u2ABlLFbHc
         ZNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ih6l3GUYDQo8G5Xp6gmRAuzPpzvzTU7E0Xuxw7hUhrw=;
        b=aTineP2Pd4HHIE7OWEGd5qP/Xh7V+L6rOQh7Dtj5pLdQG2/SUpjDmk1heYSjlus6BN
         HSBI1CRq9ArcOZNcPVvKqG46t32bJ82aOOOUY7g4CMNU2n4Mwp+uG0OzbKRWq3u+R4Ku
         f/m8nBxxBUCJvc7W4k+N9PsYPikP24aZEdO7fyVf4p5hxbOFwWCt3w3Fkn/xfRgDJT9R
         IKu1LwO0t+WxQUqb1tBbxDyaHfGTqUb6A8eXSNNx1VlZdk+WGjvx5yfET6Ft+1pNLZ36
         /rkqd9RdRZ8ZuuLZJQUtlcT9iDI+wW9yCuQ5JdSEPvOsq3G3ZbiAh6ZhwAJ+PKDrZtLQ
         enCg==
X-Gm-Message-State: AOAM5312erAVCTq4WBaRCAzlCFAplLYCG7/T1CNuKXyPkY6iQ4HhRxrd
        UqYvo6LZF5phwALoSGV8NC2YW0096Bx3bQQVBaBvkw==
X-Google-Smtp-Source: ABdhPJyAWnMbFZX0gk5sdOJqYXJJd7ism/C/Kv9EVu/ODJV3WBFwx2BOeedZhZyoAMCiKqjr+i5o/1LwODpOCSizDfo=
X-Received: by 2002:ab0:6258:: with SMTP id p24mr3155184uao.100.1629122395877;
 Mon, 16 Aug 2021 06:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210810081644.19353-1-tony@atomide.com> <20210810081644.19353-2-tony@atomide.com>
In-Reply-To: <20210810081644.19353-2-tony@atomide.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Aug 2021 15:59:18 +0200
Message-ID: <CAPDyKFr=LcHYt+YM_L1ymxE3JxOvkYRv-dS+161ctaiXTGUhcw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: Fix issue with uninitialized dma_slave_config
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
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
> For dw_mmc, this is probably not currently an issue but is still good to
> fix though.
>
> Fixes: 3fc7eaef44db ("mmc: dw_mmc: Add external dma interface support")
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -782,6 +782,7 @@ static int dw_mci_edmac_start_dma(struct dw_mci *host,
>         int ret = 0;
>
>         /* Set external dma config: burst size, burst width */
> +       memset(&cfg, 0, sizeof(cfg));
>         cfg.dst_addr = host->phy_regs + fifo_offset;
>         cfg.src_addr = cfg.dst_addr;
>         cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> --
> 2.32.0
