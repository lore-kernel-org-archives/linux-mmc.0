Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1112AC2BA19
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 13:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6EC20575
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 13:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504996AbgDONRG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:17:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:35931 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370723AbgDONQ5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Apr 2020 09:16:57 -0400
IronPort-SDR: BwP8BQtRXZBOsdFpgZ7pL+msVfAGtgutK66soFYjcSXi8JLMnCtqsCUt/rBHjM1FtoQYspesKs
 TRMqa/IDO7+A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 06:16:57 -0700
IronPort-SDR: dxJsauTrNCBbEh9iRMOkRDojitIw6xUBlogGlmKuMR3+VcdA0n00UBJN1nw/Nb9K5gm6QZoErM
 DBtUmoVA3EHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="400309880"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2020 06:16:54 -0700
Subject: Re: [PATCH 4/7] mmc: sdhci: move SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
 frequency limit
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Michal Simek <michal.simek@xilinx.com>,
        Kevin Liu <kliu5@marvell.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
 <637b9bea4c28a0eeacf754d2930596b8e6673808.1585827904.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2b111407-0f35-3c5e-f7f0-4a05a281dce2@intel.com>
Date:   Wed, 15 Apr 2020 16:16:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <637b9bea4c28a0eeacf754d2930596b8e6673808.1585827904.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/04/20 2:54 pm, Michał Mirosław wrote:
> Move clock frequency limit for SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN where
> it belongs.

Did you consider getting rid of SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN and
handling it in sdhci-of-arasan instead?

> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 7 ++++---
>  drivers/mmc/host/sdhci.c           | 3 +--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index d4905c106c06..5e3b9131a631 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -339,7 +339,6 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
>  	.ops = &sdhci_arasan_ops,
>  	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
>  			SDHCI_QUIRK2_STOP_WITH_TC,
>  };
>  
> @@ -410,8 +409,7 @@ static const struct sdhci_ops sdhci_arasan_cqe_ops = {
>  static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>  	.ops = &sdhci_arasan_cqe_ops,
>  	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>  
>  static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
> @@ -1155,6 +1153,9 @@ static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
>  	bool dma64;
>  	int ret;
>  
> +	if (sdhci_pltfm_clk_get_max_clock(host) <= 25000000)
> +		host->quirks2 |= SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN;
> +
>  	if (!sdhci_arasan->has_cqe)
>  		return sdhci_add_host(host);
>  
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a043bf5e3565..ed88ac4e4cf3 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1809,8 +1809,7 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  			/* Version 3.00 divisors must be a multiple of 2. */
>  			if (host->max_clk <= clock) {
>  				div = 1;
> -				if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
> -					&& host->max_clk <= 25000000)
> +				if (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
>  					div = 2;
>  			} else {
>  				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
> 

