Return-Path: <SRS0=abg9=DX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5918FC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Oct 2020 09:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121E820872
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Oct 2020 09:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405291AbgJPJGR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Oct 2020 05:06:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:26225 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405290AbgJPJGQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 16 Oct 2020 05:06:16 -0400
IronPort-SDR: ZKB2CFzee75GXJxvPIkcm8i9IjoQBHcDbgqoJYwg/io51EZtmcV1AGkvOVV2HAwYTGXbkTPe8Z
 SkYkSUcimm2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="153482579"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="153482579"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 02:06:16 -0700
IronPort-SDR: 6WLs1WRGOgcTjdv3Ub0p1LMbNK1+wYunnMB6LicT9lPhEuBrsZdlA+tTDLO4w40BC+uJrQv7jc
 uPkm8UZ3bqhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="522170440"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2020 02:06:14 -0700
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: make sure delay chain locked for
 HS400
To:     Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
References: <20201016042559.25618-1-yangbo.lu@nxp.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ce17988b-3d52-948c-e2c0-c61c573b4d98@intel.com>
Date:   Fri, 16 Oct 2020 12:05:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201016042559.25618-1-yangbo.lu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/10/20 7:25 am, Yangbo Lu wrote:
> For eMMC HS400 mode initialization, the DLL reset is a required step
> if DLL is enabled to use previously, like in bootloader.
> This step has not been documented in reference manual, but the RM will
> be fixed sooner or later.
> 
> This patch is to add the step of DLL reset, and make sure delay chain
> locked for HS400.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc.h    |  2 ++
>  drivers/mmc/host/sdhci-of-esdhc.c | 24 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
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
> index 0b45eff..a39ff86 100644
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
> @@ -743,6 +744,29 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
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
> +		timeout = ktime_add_ms(ktime_get(), 20);
> +		while (1) {
> +			bool timedout = ktime_after(ktime_get(), timeout);
> +
> +			if (sdhci_readl(host, ESDHC_DLLSTAT0) &
> +			    ESDHC_DLL_STS_SLV_LOCK)
> +				break;
> +			if (timedout) {
> +				pr_err("%s: timeout for delay chain lock.\n",
> +					mmc_hostname(host->mmc));
> +				break;
> +			}
> +			usleep_range(10, 20);
> +		}

It is possible now to do these loops using read_poll_timeout
e.g. something like this:

	if (read_poll_timeout(sdhci_readl, temp, temp & ESDHC_DLL_STS_SLV_LOCK,
			      10, 20000, false, host, ESDHC_DLLSTAT0))
		pr_err("%s: timeout for delay chain lock.\n",
		       mmc_hostname(host->mmc));



> +
>  		temp = sdhci_readl(host, ESDHC_TBCTL);
>  		sdhci_writel(host, temp | ESDHC_HS400_WNDW_ADJUST, ESDHC_TBCTL);
>  
> 

