Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F82C2BA19
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 13:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579E52074F
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 13:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636318AbgDONzd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:55:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:28170 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633760AbgDONzb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Apr 2020 09:55:31 -0400
IronPort-SDR: 9F9/ogCQ/wPBgOfbXmxotnNienVmICYhet8BKoSt/M/VySBpNTwZ8L/yjiArntWhtj7GImyCJI
 tlUCZCFAz3kg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 06:55:27 -0700
IronPort-SDR: f9TFseWEQrNrAtDl824wuoh2h/P/FEZtsT1/9F9U9AoqOJHGZLvYCpuKtTG1isC/fs983xh/fm
 M1ciN3h2/gxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="400320752"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2020 06:55:23 -0700
Subject: Re: [PATCH 5/7] mmc: sdhci: simplify clock frequency calculation
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
 <1a7f7f0941314da66acda3c60f44b3d2417133e6.1585827904.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7967c035-52e3-1ce7-a82f-47d28a3cf484@intel.com>
Date:   Wed, 15 Apr 2020 16:54:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1a7f7f0941314da66acda3c60f44b3d2417133e6.1585827904.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/04/20 2:54 pm, Michał Mirosław wrote:
> Make clock frequency calculations simpler by replacing loops
> with divide-and-clamp.

I am sorry, but I am not really sure the simplification is worth the code
churn, risk of introducing new bugs, or validation effort.

IMO, the loops, while perhaps inefficient, are not hard to understand.

> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/mmc/host/sdhci.c | 56 +++++++++++++++++++---------------------
>  drivers/mmc/host/sdhci.h |  4 +--
>  2 files changed, 29 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ed88ac4e4cf3..d750c0997c3f 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1756,10 +1756,13 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
>  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  		   unsigned int *actual_clock)
>  {
> -	int div = 0; /* Initialized for compiler warning */
> +	unsigned int div = 0; /* Initialized for compiler warning */
>  	int real_div = div, clk_mul = 1;
>  	u16 clk = 0;
> -	bool switch_base_clk = false;
> +	bool use_base_clk;
> +
> +	if (clock == 0)
> +		unreachable();
>  
>  	if (host->version >= SDHCI_SPEC_300) {
>  		if (host->preset_enabled) {
> @@ -1781,13 +1784,12 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  		 * Check if the Host Controller supports Programmable Clock
>  		 * Mode.
>  		 */
> -		if (host->clk_mul) {
> -			for (div = 1; div <= 1024; div++) {
> -				if ((host->max_clk * host->clk_mul / div)
> -					<= clock)
> -					break;
> -			}
> -			if ((host->max_clk * host->clk_mul / div) <= clock) {
> +		use_base_clk = !host->clk_mul;
> +
> +		if (!use_base_clk) {
> +			div = DIV_ROUND_UP(host->max_clk * host->clk_mul, clock);
> +
> +			if (div <= SDHCI_MAX_DIV_SPEC_300 / 2 + 1) {
>  				/*
>  				 * Set Programmable Clock Mode in the Clock
>  				 * Control register.
> @@ -1798,35 +1800,31 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  				div--;
>  			} else {
>  				/*
> -				 * Divisor can be too small to reach clock
> -				 * speed requirement. Then use the base clock.
> +				 * Divisor is too big for requested clock rate.
> +				 * Use the base clock, then.
>  				 */
> -				switch_base_clk = true;
> +				use_base_clk = true;
>  			}
>  		}
>  
> -		if (!host->clk_mul || switch_base_clk) {
> -			/* Version 3.00 divisors must be a multiple of 2. */
> -			if (host->max_clk <= clock) {
> -				div = 1;
> -				if (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
> -					div = 2;
> -			} else {
> -				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
> -				     div += 2) {
> -					if ((host->max_clk / div) <= clock)
> -						break;
> -				}
> +		if (use_base_clk) {
> +			/* Version 3.00 divisors must be 1 or a multiple of 2. */
> +			div = DIV_ROUND_UP(host->max_clk, clock);
> +			if (div > 1) {
> +				div = min(div, SDHCI_MAX_DIV_SPEC_300);
> +				div = round_up(div, 2);
>  			}
> -			real_div = div;
>  			div >>= 1;
> +			if (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
> +				div += !div;
> +
> +			real_div = div * 2 + !div;
>  		}
>  	} else {
>  		/* Version 2.00 divisors must be a power of 2. */
> -		for (div = 1; div < SDHCI_MAX_DIV_SPEC_200; div *= 2) {
> -			if ((host->max_clk / div) <= clock)
> -				break;
> -		}
> +		div = DIV_ROUND_UP(host->max_clk, clock);
> +		div = min(div, SDHCI_MAX_DIV_SPEC_200);
> +		div = roundup_pow_of_two(div);
>  		real_div = div;
>  		div >>= 1;
>  	}
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 79dffbb731d3..ea8aabb3bf16 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -290,8 +290,8 @@
>   * End of controller registers.
>   */
>  
> -#define SDHCI_MAX_DIV_SPEC_200	256
> -#define SDHCI_MAX_DIV_SPEC_300	2046
> +#define SDHCI_MAX_DIV_SPEC_200	256u
> +#define SDHCI_MAX_DIV_SPEC_300	2046u
>  
>  /*
>   * Host SDMA buffer boundary. Valid values from 4K to 512K in powers of 2.
> 

