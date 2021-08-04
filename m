Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D39C4338F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 12:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4261660E8D
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 12:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbhHDMkY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 08:40:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:19343 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236625AbhHDMkW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Aug 2021 08:40:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="201078150"
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="201078150"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 05:40:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="480148024"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2021 05:40:05 -0700
Subject: Re: [PATCH v4 5/5] mmc: sdhci: simplify v2/v3+ clock calculation
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>
References: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
 <a8a677659b27244be865a730f6a7f2b7805a4390.1627204633.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9a6b8e4a-b944-c1d7-f310-fea1e1269e6d@intel.com>
Date:   Wed, 4 Aug 2021 15:40:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a8a677659b27244be865a730f6a7f2b7805a4390.1627204633.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/07/21 12:20 pm, Michał Mirosław wrote:
> For base clock setting, SDHCI V2 differs from V3+ only in allowed divisor
> values.  Remove the duplicate version of code and reduce indentation
> levels.  We can see now, that 'real_div' can't be zero, so the check is
> removed.  While at it, replace divisor search loops with divide-and-clamp
> to make the code even more readable.

It doesn't seem simpler to me, just different.

Simpler would mean broken into separate logical functions, getting rid of
the gotos, and above all having the changes broken into separate patches
for easy review.

> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
> v4: no changes
> v3: squashed div-conversion and deduplication patches to avoid code churn
> v2: no changes
> ---
>  drivers/mmc/host/sdhci.c | 124 ++++++++++++++++++---------------------
>  drivers/mmc/host/sdhci.h |   4 +-
>  2 files changed, 58 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index cfa314e659bc..90bda4150083 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1848,88 +1848,76 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
>  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  		   unsigned int *actual_clock)
>  {
> -	int div = 0; /* Initialized for compiler warning */
> -	int real_div = div, clk_mul = 1;
> +	unsigned int div, real_div, clk_mul = 1;
>  	u16 clk = 0;
> -	bool switch_base_clk = false;
>  
> -	if (host->version >= SDHCI_SPEC_300) {
> -		if (host->preset_enabled) {
> -			u16 pre_val;
> +	if (clock == 0)
> +		return clk;
> +
> +	if (host->preset_enabled) {
> +		/* Only version 3.00+ can have preset_enabled */
> +		u16 pre_val;
> +
> +		pre_val = sdhci_get_preset_value(host);
> +		div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
> +		if (!(pre_val & SDHCI_PRESET_CLKGEN_SEL))
> +			goto base_div_set;
> +
> +		clk = SDHCI_PROG_CLOCK_MODE;
> +		real_div = div + 1;
> +		clk_mul = host->clk_mul;
> +		if (!clk_mul) {
> +			/* The clock frequency is unknown. Assume undivided base. */
> +			clk_mul = 1;
> +		}
> +
> +		goto clock_set;
> +	}
> +
> +	/*
> +	 * Check if the Host Controller supports Programmable Clock
> +	 * Mode.
> +	 */
> +	if (host->version >= SDHCI_SPEC_300 && host->clk_mul) {
> +		div = DIV_ROUND_UP(host->max_clk * host->clk_mul, clock);
> +		if (div <= SDHCI_MAX_DIV_SPEC_300 / 2 + 1) {
> +			/*
> +			 * Set Programmable Clock Mode in the Clock
> +			 * Control register.
> +			 */
> +			clk = SDHCI_PROG_CLOCK_MODE;
> +			clk_mul = host->clk_mul;
> +			real_div = div--;
>  
> -			pre_val = sdhci_get_preset_value(host);
> -			div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
> -			if (pre_val & SDHCI_PRESET_CLKGEN_SEL) {
> -				clk = SDHCI_PROG_CLOCK_MODE;
> -				real_div = div + 1;
> -				clk_mul = host->clk_mul;
> -				if (!clk_mul) {
> -					/* The clock frequency is unknown. Assume undivided base. */
> -					clk_mul = 1;
> -				}
> -			} else {
> -				real_div = max_t(int, 1, div << 1);
> -			}
>  			goto clock_set;
>  		}
>  
>  		/*
> -		 * Check if the Host Controller supports Programmable Clock
> -		 * Mode.
> +		 * Divisor is too big for requested clock rate.
> +		 * Fall back to the base clock.
>  		 */
> -		if (host->clk_mul) {
> -			for (div = 1; div <= 1024; div++) {
> -				if ((host->max_clk * host->clk_mul / div)
> -					<= clock)
> -					break;
> -			}
> -			if ((host->max_clk * host->clk_mul / div) <= clock) {
> -				/*
> -				 * Set Programmable Clock Mode in the Clock
> -				 * Control register.
> -				 */
> -				clk = SDHCI_PROG_CLOCK_MODE;
> -				real_div = div;
> -				clk_mul = host->clk_mul;
> -				div--;
> -			} else {
> -				/*
> -				 * Divisor can be too small to reach clock
> -				 * speed requirement. Then use the base clock.
> -				 */
> -				switch_base_clk = true;
> -			}
> -		}
> +	}
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
> -			}
> -			real_div = div;
> -			div >>= 1;
> -		}
> +	div = DIV_ROUND_UP(host->max_clk, clock);
> +
> +	if (div == 1 && (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN))
> +		div = 2;
> +
> +	if (host->version >= SDHCI_SPEC_300) {
> +		/* Version 3.00 divisors must be a multiple of 2. */
> +		div = min(div, SDHCI_MAX_DIV_SPEC_300);
> +		div = DIV_ROUND_UP(div, 2);
>  	} else {
>  		/* Version 2.00 divisors must be a power of 2. */
> -		for (div = 1; div < SDHCI_MAX_DIV_SPEC_200; div *= 2) {
> -			if ((host->max_clk / div) <= clock)
> -				break;
> -		}
> -		real_div = div;
> -		div >>= 1;
> +		div = min(div, SDHCI_MAX_DIV_SPEC_200);
> +		div = roundup_pow_of_two(div) / 2;
>  	}
>  
> +base_div_set:
> +	real_div = div * 2 + !div;
> +
>  clock_set:
> -	if (real_div)
> -		*actual_clock = (host->max_clk * clk_mul) / real_div;
> +	*actual_clock = (host->max_clk * clk_mul) / real_div;
>  	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
>  	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
>  		<< SDHCI_DIVIDER_HI_SHIFT;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 074dc182b184..a3fa70d91410 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -284,8 +284,8 @@
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

