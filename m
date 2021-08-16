Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1F9C4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF6763305
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhHPOBA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhHPOAh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 10:00:37 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BC5C0613C1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:59:50 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id u39so1591135uad.10
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSsi28CmwO06irWVfufwN2bPudeZItWDGgBnH+cn0es=;
        b=f/xCt6WEQpbw6Q+cCtPqeCPr2uj6JP3zPudSy/JshxuCGglp8XmJIFogwxuhmjOACP
         Ycvyzi9/jd8pnVGnJ7iCHlpEJyn0hbbCN+Is1EYu94iXfNAZM7LraB/FPSfYr+pxSPnw
         FrUctDaLRblxPUZTH9Y09MBbyZdLZ9AiUMhiKIidaI+ee/cOUuYnK4w+8S4xcWNM7yax
         42s9AoXLTVzdLWJ3OGmxe2BBOdjyvEMrSka0NOdjAhnpciJxLr00liZN/gMt53ukNuyF
         0qkhZqsgllKPsGfRplOmmn0/zEr+K9sTnZNbKFiH+6D9+jiR0Bt2M2xHx0ESop7wAvJF
         NClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSsi28CmwO06irWVfufwN2bPudeZItWDGgBnH+cn0es=;
        b=pVDrJrUlZdeAxiHxwuDYCKqGs9Tf3iZJ8Ag2/roGOXoSBhzvnaj43Yirddz3XbHGjs
         mAm0bF8kPoQhQlt+PgyU+E1nF4FssvVjdyWvrCVjMDIGuoiKsujNaxJzaZTdbq/ZGKBi
         MSZj/Q0BQ8qmpKJoA5HZnnqlpnMuP5+ThxrajMYVHl/T56k8kPE/HMPOzyv33pf8ex1f
         6XsxRJSgb09xEf1qvPbiza62gaNYauewMt8N8mAH1rjK0shztcbnEf/LFMUKLGH6T3NW
         jLQSBId2n2w5ee1A2df/UVxBZNUYeC4+unGq6M7shy00+JR0yGEwFEFVB7JcKUxdxP+y
         q//A==
X-Gm-Message-State: AOAM531uoWd4+G3g8EWimqKYTzufUuU06/hceCZQ2kN7XZLtLlo4ySw0
        loA/gVVfu4hlMFUj1A+nbwXybcF43RZ6hpvbf9UKvg==
X-Google-Smtp-Source: ABdhPJxVkUP7oU/we411PrgEfVaCHvo0LawklSGUw/v6mk6/I4F/0163EOWU72Qt9BnmmRsUWy62IQ3MpPIH9QQZrtk=
X-Received: by 2002:a9f:25a7:: with SMTP id 36mr8960629uaf.129.1629122389426;
 Mon, 16 Aug 2021 06:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210810081644.19353-1-tony@atomide.com>
In-Reply-To: <20210810081644.19353-1-tony@atomide.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Aug 2021 15:59:12 +0200
Message-ID: <CAPDyKFrBbrru2kBknz6UpnJAwM_355Ape3fkq=8oEyrqWCvm-w@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci: Fix issue with uninitialized dma_slave_config
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
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
> failures at least if external TI SDMA is ever configured for sdhci.
>
> For other external DMA cases, this is probably not currently an issue but
> is still good to fix though.
>
> Fixes: 18e762e3b7a7 ("mmc: sdhci: add support for using external DMA devices")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
> Cc: Faiz Abbas <faiz_abbas@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1222,6 +1222,7 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
>         if (!host->mapbase)
>                 return -EINVAL;
>
> +       memset(&cfg, 0, sizeof(cfg));
>         cfg.src_addr = host->mapbase + SDHCI_BUFFER;
>         cfg.dst_addr = host->mapbase + SDHCI_BUFFER;
>         cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> --
> 2.32.0
