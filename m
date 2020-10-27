Return-Path: <SRS0=lEQw=EC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76407C55178
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 13:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E42B2071A
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 13:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwne/hsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbgJ0Nmd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Oct 2020 09:42:33 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:40737 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbgJ0Nmc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Oct 2020 09:42:32 -0400
Received: by mail-vs1-f47.google.com with SMTP id f4so869478vsk.7
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2020 06:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/27fN/8QK9Cg38sDbSPYXiTMyFhMrXj+q5HNlH7Q+A=;
        b=gwne/hsPPX+RWNYCqmVz3rbhUz+kSVxwMgM7t8Oql1eipeSivQ/xFHL77kTggOHCLy
         SjiktlF9YYetTu66A1Rksdb85zzesJu9cdch4ygnn8c+VpNW2lrKlr8+3rJhZvtyR/wb
         wPISivylszDSgN9eYyV0gywU47A8sHSeGgLtQBMSK3RZKcgFHYPhnv038WUTZzyeoNKb
         7gXlq25txziDvw5cpxMgm10qw77jfWCWyUH1WetY8+En++ALmJeF32LRvkPyDIda65tQ
         pPmtNanBIMn0luWBiz2fA2hu+wP1dCtE554BNjKWQ+wACwsFbaQJtMlrqn5DHGIh85fW
         3aTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/27fN/8QK9Cg38sDbSPYXiTMyFhMrXj+q5HNlH7Q+A=;
        b=KAj9Q4nX0IoExKTcpXDPT1z+/AW9cevfhubbm3OVcZI1ueudHSANoVE6XLnm2IsPS4
         yEYm9Ap/SS6tbGPEG4do+IvDRqjmj6jdMpmRB0uvRAv109XMvXVTr+b39vR8s6iIyICJ
         2Ykn9mrPGWtXZBF3NvviKrGTH49FjpXZ4xBS7obfCP8wATCulXONt5z35YnS84gwVVkr
         SjiuxC+IMSzzkQSkv+uqB59jqjyE8gnk0NmAgsqgDiJ0rkQI4TlfcThWAKTNTvAtZ6sX
         PQdGxZg2OXIvwqWon00B9XyCZVRyuVovAFq0S5uv0NIUbi2I98MVNWgYmf+etZVFqDiG
         qRZw==
X-Gm-Message-State: AOAM533QAfWzEjt290Q6srDl5LlHZ0ErSX6epdc8w6cv6n75DWKB9Znu
        pqWECSYAMTytObStMgxp2Apg/5Nav0PIi1nolVkcyhBknYb1jA==
X-Google-Smtp-Source: ABdhPJyzjUAL2gsoAO4Lpk5bKMxQWGO2KC12q/ZxnDh2j8gnWbn1rswmAFPJ3hpZyGfoE5JR7SYACC3HEUdikEejxBA=
X-Received: by 2002:a67:6c86:: with SMTP id h128mr1344059vsc.42.1603806150057;
 Tue, 27 Oct 2020 06:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201020081116.20918-1-yangbo.lu@nxp.com>
In-Reply-To: <20201020081116.20918-1-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Oct 2020 14:41:53 +0100
Message-ID: <CAPDyKFoOPmqPhk7+-kNo6WQejS-GFPvbJcap3fXeJknb6spWiA@mail.gmail.com>
Subject: Re: [v3] mmc: sdhci-of-esdhc: make sure delay chain locked for HS400
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 20 Oct 2020 at 10:20, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> For eMMC HS400 mode initialization, the DLL reset is a required step
> if DLL is enabled to use previously, like in bootloader.
> This step has not been documented in reference manual, but the RM will
> be fixed sooner or later.
>
> This patch is to add the step of DLL reset, and make sure delay chain
> locked for HS400.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next (please tell if you think this deserves to be tagged
for stable), thanks!

Kind regards
Uffe



> ---
> Changes for v2:
>         - Converted to use read_poll_timeout.
> Changes for v3:
>         - Included iopoll.h.
> ---
>  drivers/mmc/host/sdhci-esdhc.h    |  2 ++
>  drivers/mmc/host/sdhci-of-esdhc.c | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index a30796e..6de02f0 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2007 Freescale Semiconductor, Inc.
>   * Copyright (c) 2009 MontaVista Software, Inc.
>   * Copyright (c) 2010 Pengutronix e.K.
> + * Copyright 2020 NXP
>   *   Author: Wolfram Sang <kernel@pengutronix.de>
>   */
>
> @@ -88,6 +89,7 @@
>  /* DLL Config 0 Register */
>  #define ESDHC_DLLCFG0                  0x160
>  #define ESDHC_DLL_ENABLE               0x80000000
> +#define ESDHC_DLL_RESET                        0x40000000
>  #define ESDHC_DLL_FREQ_SEL             0x08000000
>
>  /* DLL Config 1 Register */
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 0b45eff..90e6085 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright (c) 2007, 2010, 2012 Freescale Semiconductor, Inc.
>   * Copyright (c) 2009 MontaVista Software, Inc.
> + * Copyright 2020 NXP
>   *
>   * Authors: Xiaobo Xie <X.Xie@freescale.com>
>   *         Anton Vorontsov <avorontsov@ru.mvista.com>
> @@ -19,6 +20,7 @@
>  #include <linux/clk.h>
>  #include <linux/ktime.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/iopoll.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include "sdhci-pltfm.h"
> @@ -743,6 +745,21 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>                 if (host->mmc->actual_clock == MMC_HS200_MAX_DTR)
>                         temp |= ESDHC_DLL_FREQ_SEL;
>                 sdhci_writel(host, temp, ESDHC_DLLCFG0);
> +
> +               temp |= ESDHC_DLL_RESET;
> +               sdhci_writel(host, temp, ESDHC_DLLCFG0);
> +               udelay(1);
> +               temp &= ~ESDHC_DLL_RESET;
> +               sdhci_writel(host, temp, ESDHC_DLLCFG0);
> +
> +               /* Wait max 20 ms */
> +               if (read_poll_timeout(sdhci_readl, temp,
> +                                     temp & ESDHC_DLL_STS_SLV_LOCK,
> +                                     10, 20000, false,
> +                                     host, ESDHC_DLLSTAT0))
> +                       pr_err("%s: timeout for delay chain lock.\n",
> +                              mmc_hostname(host->mmc));
> +
>                 temp = sdhci_readl(host, ESDHC_TBCTL);
>                 sdhci_writel(host, temp | ESDHC_HS400_WNDW_ADJUST, ESDHC_TBCTL);
>
> --
> 2.7.4
>
