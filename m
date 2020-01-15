Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6679BC33CB1
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 10:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4188224679
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 10:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgAOKCx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:02:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:33446 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbgAOKCx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Jan 2020 05:02:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 02:02:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,322,1574150400"; 
   d="scan'208";a="305450640"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga001.jf.intel.com with ESMTP; 15 Jan 2020 02:02:50 -0800
Subject: Re: [PATCH v3] mmc: sdhci: fix minimum clock rate for v3 controller
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ffb489519a446caffe7a0a05c4b9372bd52397bb.1579082031.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5ce78487-e60a-1ad5-4a12-5d068994416a@intel.com>
Date:   Wed, 15 Jan 2020 12:01:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ffb489519a446caffe7a0a05c4b9372bd52397bb.1579082031.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/01/20 11:54 am, Michał Mirosław wrote:
> For SDHCIv3+ with programmable clock mode, minimal clock frequency is
> still base clock / max(divider). Minimal programmable clock frequency is
> always greater than minimal divided clock frequency. Without this patch,
> SDHCI uses out-of-spec initial frequency when multiplier is big enough:
> 
> mmc1: mmc_rescan_try_freq: trying to init card at 468750 Hz
> [for 480 MHz source clock divided by 1024]
> 
> The code in sdhci_calc_clk() already chooses a correct SDCLK clock mode.
> 
> Cc: stable@vger.kernel.org
> Fixes: c3ed3877625f ("mmc: sdhci: add support for programmable clock mode")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  v3: commitmsg/comment rewording
>  v2: extend commitmsg and add comment
> ---
>  drivers/mmc/host/sdhci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 96609c961465..24fb6d710de6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3903,11 +3903,13 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	if (host->ops->get_min_clock)
>  		mmc->f_min = host->ops->get_min_clock(host);
>  	else if (host->version >= SDHCI_SPEC_300) {
> -		if (host->clk_mul) {
> -			mmc->f_min = (host->max_clk * host->clk_mul) / 1024;
> +		if (host->clk_mul)
>  			max_clk = host->max_clk * host->clk_mul;
> -		} else
> -			mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
> +		/*
> +		 * Divided Clock Mode minimum clock rate is always less than
> +		 * Programmable Clock Mode minimum clock rate.
> +		 */
> +		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
>  	} else
>  		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
>  
> 

