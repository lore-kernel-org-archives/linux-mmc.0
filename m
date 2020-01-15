Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271F6C33CB1
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 08:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEF7222C3
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 08:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgAOI4j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:56:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:34087 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729026AbgAOI4j (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Jan 2020 03:56:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 00:56:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="305435177"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga001.jf.intel.com with ESMTP; 15 Jan 2020 00:56:36 -0800
Subject: Re: [PATCH v2] mmc: sdhci: fix minimum clock rate for v3 controller
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <36180c2b31b154b482892d6c7a3c6d5f386a6a73.1579077085.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7def4624-e1c5-6208-efaa-4f11f98fda6d@intel.com>
Date:   Wed, 15 Jan 2020 10:55:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <36180c2b31b154b482892d6c7a3c6d5f386a6a73.1579077085.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/01/20 10:32 am, Michał Mirosław wrote:
> For SDHCIv3+ with programmable clock mode, minimal clock frequency is
> still base clock / max(divider). Minimal programmable clock frequency is
> always greater than minimal divided clock frequency. Without this patch,
> SDHCI uses out-of-spec initial frequency when multiplier is big enough:
> 
> mmc1: mmc_rescan_try_freq: trying to init card at 468750 Hz
> [for 480 MHz source clock divided by 1024]
> 
> The code in sdhci_calc_clk() already chooses a correct SDCLK clock source.

source -> mode

> 
> Cc: stable@vger.kernel.org
> Fixes: c3ed3877625f ("mmc: sdhci: add support for programmable clock mode")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  v2: extend commitmsg and add comment
> ---
>  drivers/mmc/host/sdhci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 96609c961465..fde510c55c89 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3903,11 +3903,11 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	if (host->ops->get_min_clock)
>  		mmc->f_min = host->ops->get_min_clock(host);
>  	else if (host->version >= SDHCI_SPEC_300) {
> -		if (host->clk_mul) {
> -			mmc->f_min = (host->max_clk * host->clk_mul) / 1024;
> +		if (host->clk_mul)
>  			max_clk = host->max_clk * host->clk_mul;
> -		} else
> -			mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
> +		/* minimal divided clock rate is always less than minimal
> +		 * programmable clock rate */

Comment format and let's use the same terminology as the spec.

		/*
		 * Divided Clock Mode minimum clock rate is always less than
		 * Programmable Clock Mode minimum clock rate.
		 */

> +		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
>  	} else
>  		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
>  
> 

