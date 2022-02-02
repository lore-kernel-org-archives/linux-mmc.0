Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26669C433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Feb 2022 04:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244504AbiBBEUV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Feb 2022 23:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244517AbiBBEUP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Feb 2022 23:20:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCE9C06173E
        for <linux-mmc@vger.kernel.org>; Tue,  1 Feb 2022 20:13:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77469616D2
        for <linux-mmc@vger.kernel.org>; Wed,  2 Feb 2022 04:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E33CC004E1;
        Wed,  2 Feb 2022 04:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643775235;
        bh=Xx9B1zi+n/cstmxZQ6vEJuDkGxcEsV4uBlMIkUUId+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=smNOygxqhj6Ohp8rWrenjj2xlJubfoSeEgC5bszwiIRF12sfNii/2JT1tcCHm+B1X
         vwLkeBm4UxviWDIX+mlFocMX2RKAVeFCXreWmHcvUfUj8T46GRFW+J5WfhqnVKfQU7
         3cS5lHdzZsKPxK4GRuogiMb31BkE2bSIEuK4En5/xr8HEEZVW6qEY1uGyFxx3etFTQ
         F6bNiF5U/SXLd202v1reE6BgoTpfxBATLzdFhsxEsdogM+WY9uOT1hp+nwaVWT5JDN
         GoT56bcEGjTKcOF6NyPyKBIjPjP8NxoF2eziqPk0PUSChBOkBQlrswsKeUvEJ8i0U9
         +YdwDqkTi3wiQ==
Date:   Wed, 2 Feb 2022 09:43:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: renesas_sdhi_sys_dmac: use
 DMA_SLAVE_BUSWIDTH_UNDEFINED
Message-ID: <YfoE//tsrv8rrzA1@matsya>
References: <5e22c587-5698-e132-4429-48674a6ddbb7@omp.ru>
 <CAPDyKFrm5==gBSZBuPWYU+AcNxYz8K_=X_=5k6JnHN+3a9-bug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrm5==gBSZBuPWYU+AcNxYz8K_=X_=5k6JnHN+3a9-bug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 31-01-22, 17:26, Ulf Hansson wrote:
> + Vinod
> 
> On Fri, 21 Jan 2022 at 21:38, Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> >
> > The 'dma_slave_config::{src|dst}_addr_width' fields have the *enum* type
> > which isn't isomorphic with the *bool* type, however is used as a boolean
> > expression. Use the *enum* dma_slave_buswidth's value corresponding to 0
> > instead.
> >
> > Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> > analysis tool.
> 
> I have no strong opinion, but just wanted to make sure this is inline
> with what Vinod wants.
> 
> There are not so many users checking DMA_SLAVE_BUSWIDTH_UNDEFINED,
> perhaps we should simply drop it and instead leave the checks below as
> is?

DMA_SLAVE_BUSWIDTH_UNDEFINED was defined as 0.
I think it might be overkill and should be fine to keep the check as
is..

> 
> >
> > Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> Kind regards
> Uffe
> 
> >
> > ---
> > This patch is against the 'next' branch of Ulf Hansson's 'mmc.git' repo.
> >
> > drivers/mmc/host/renesas_sdhi_sys_dmac.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Index: mmc/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> > ===================================================================
> > --- mmc.orig/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> > +++ mmc/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> > @@ -370,7 +370,7 @@ static void renesas_sdhi_sys_dmac_reques
> >                 cfg.dst_addr = res->start +
> >                         (CTL_SD_DATA_PORT << host->bus_shift);
> >                 cfg.dst_addr_width = priv->dma_priv.dma_buswidth;
> > -               if (!cfg.dst_addr_width)
> > +               if (cfg.dst_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> >                         cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> >                 cfg.src_addr = 0;
> >                 ret = dmaengine_slave_config(host->chan_tx, &cfg);
> > @@ -389,7 +389,7 @@ static void renesas_sdhi_sys_dmac_reques
> >                 cfg.direction = DMA_DEV_TO_MEM;
> >                 cfg.src_addr = cfg.dst_addr + host->pdata->dma_rx_offset;
> >                 cfg.src_addr_width = priv->dma_priv.dma_buswidth;
> > -               if (!cfg.src_addr_width)
> > +               if (cfg.src_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> >                         cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> >                 cfg.dst_addr = 0;
> >                 ret = dmaengine_slave_config(host->chan_rx, &cfg);

-- 
~Vinod
