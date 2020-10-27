Return-Path: <SRS0=lEQw=EC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43052C55178
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 12:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFAB21655
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 12:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbgJ0MfE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Oct 2020 08:35:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:9287 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900048AbgJ0MfE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 27 Oct 2020 08:35:04 -0400
IronPort-SDR: i/n76WnclbAwtbr7gxBet80H6I8LA6FoqZVHYKm4xE5iR5qedhZgx/Lypy58PqLBXqKAigEQ4A
 sRUKqHadtIUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168196301"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="168196301"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 05:35:03 -0700
IronPort-SDR: ADm/eNUcWxrgY9wl8+F3YvmcxEsF7zj8Mkj2mZpWmBrfDRJOpd+cALBgdGhWH0HN7jvtMFgZl7
 S791dCMxEtdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="468280319"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga004.jf.intel.com with ESMTP; 27 Oct 2020 05:35:01 -0700
Subject: Re: [v3] mmc: sdhci-of-esdhc: make sure delay chain locked for HS400
To:     Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
References: <20201020081116.20918-1-yangbo.lu@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2d6e5308-e406-c1c6-f7a2-dce406df0aa8@intel.com>
Date:   Tue, 27 Oct 2020 14:34:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201020081116.20918-1-yangbo.lu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/10/20 11:11 am, Yangbo Lu wrote:
> For eMMC HS400 mode initialization, the DLL reset is a required step
> if DLL is enabled to use previously, like in bootloader.
> This step has not been documented in reference manual, but the RM will
> be fixed sooner or later.
> 
> This patch is to add the step of DLL reset, and make sure delay chain
> locked for HS400.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes for v2:
> 	- Converted to use read_poll_timeout.
> Changes for v3:
> 	- Included iopoll.h.
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
>  #define ESDHC_DLLCFG0			0x160
>  #define ESDHC_DLL_ENABLE		0x80000000
> +#define ESDHC_DLL_RESET			0x40000000
>  #define ESDHC_DLL_FREQ_SEL		0x08000000
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
>   *	    Anton Vorontsov <avorontsov@ru.mvista.com>
> @@ -19,6 +20,7 @@
>  #include <linux/clk.h>
>  #include <linux/ktime.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/iopoll.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include "sdhci-pltfm.h"
> @@ -743,6 +745,21 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>  		if (host->mmc->actual_clock == MMC_HS200_MAX_DTR)
>  			temp |= ESDHC_DLL_FREQ_SEL;
>  		sdhci_writel(host, temp, ESDHC_DLLCFG0);
> +
> +		temp |= ESDHC_DLL_RESET;
> +		sdhci_writel(host, temp, ESDHC_DLLCFG0);
> +		udelay(1);
> +		temp &= ~ESDHC_DLL_RESET;
> +		sdhci_writel(host, temp, ESDHC_DLLCFG0);
> +
> +		/* Wait max 20 ms */
> +		if (read_poll_timeout(sdhci_readl, temp,
> +				      temp & ESDHC_DLL_STS_SLV_LOCK,
> +				      10, 20000, false,
> +				      host, ESDHC_DLLSTAT0))
> +			pr_err("%s: timeout for delay chain lock.\n",
> +			       mmc_hostname(host->mmc));
> +
>  		temp = sdhci_readl(host, ESDHC_TBCTL);
>  		sdhci_writel(host, temp | ESDHC_HS400_WNDW_ADJUST, ESDHC_TBCTL);
>  
> 

