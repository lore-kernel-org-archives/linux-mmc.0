Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C4AC432BE
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 11:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F000E61037
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 11:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhHDLGl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 07:06:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:31103 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237455AbhHDLGk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Aug 2021 07:06:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="299487430"
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="299487430"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 04:06:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="419398163"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2021 04:06:22 -0700
Subject: Re: [PATCH v4 3/5] mmc: sdhci: fix SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>
References: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
 <b343556a93c2741b502723f63af189283235bc9a.1627204633.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8c03b995-f449-8f12-a4cf-8fc4978f05c7@intel.com>
Date:   Wed, 4 Aug 2021 14:06:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b343556a93c2741b502723f63af189283235bc9a.1627204633.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/07/21 12:20 pm, Michał Mirosław wrote:
> Fix returned clock rate for SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN case.
> This fixes real_div value that was calculated as 1 (meaning no division)
> instead of 2 with the quirk enabled.
> 
> Cc: stable@kernel.vger.org
> Fixes: d1955c3a9a1d ("mmc: sdhci: add quirk SDHCI_QUIRK_CLOCK_DIV_ZERO_BROKEN")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Notwithstanding comment below:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
> v4: no changes
> v3: updated commit message
> v2: no changes
> ---
>  drivers/mmc/host/sdhci.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3ab60e7f936b..0993f7d0ce8e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1903,9 +1903,12 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  
>  		if (!host->clk_mul || switch_base_clk) {
>  			/* Version 3.00 divisors must be a multiple of 2. */
> -			if (host->max_clk <= clock)
> +			if (host->max_clk <= clock) {
>  				div = 1;
> -			else {
> +				if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
> +					&& host->max_clk <= 25000000)

It is preferred to line break after '&&' and line up e.g.

				if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN) &&
				    host->max_clk <= 25000000)


> +					div = 2;
> +			} else {
>  				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
>  				     div += 2) {
>  					if ((host->max_clk / div) <= clock)
> @@ -1914,9 +1917,6 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  			}
>  			real_div = div;
>  			div >>= 1;
> -			if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
> -				&& !div && host->max_clk <= 25000000)
> -				div = 1;
>  		}
>  	} else {
>  		/* Version 2.00 divisors must be a power of 2. */
> 

