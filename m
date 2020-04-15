Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4180CC2BA19
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 13:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E55E20737
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 13:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506017AbgDONG5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:06:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:12616 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503911AbgDONGz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Apr 2020 09:06:55 -0400
IronPort-SDR: U5qlzJyLxtMK43nMYAjQ/ZWsmVyQdhXr0JepVrLFKt/fpihuyLy4+bAszaJ5q3Cn4rdbRrRzbX
 5jWPPi9bg6nA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 06:06:53 -0700
IronPort-SDR: X0FV4juNS/j6mhVgSKyGzTWkLMQfq/EdlDRtnBYd9XoCMXDaq1clfbOdrKq8BA0ui9WyQaW9cV
 LSg0XpREzEWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="400307602"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2020 06:06:51 -0700
Subject: Re: [PATCH 3/7] mmc: sdhci: fix SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
 <eb105eedaa387ced14bb687e38d3aa33d4fcf70a.1585827904.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <67dc68ce-d8ec-4486-f4f9-3fb2580d2675@intel.com>
Date:   Wed, 15 Apr 2020 16:06:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <eb105eedaa387ced14bb687e38d3aa33d4fcf70a.1585827904.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/04/20 2:54 pm, Michał Mirosław wrote:
> Fix returned clock rate for SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN case.

Does this change anything, because it looks the same to me?

> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Cc: stable@kernel.vger.org
> Fixes: d1955c3a9a1d ("mmc: sdhci: add quirk SDHCI_QUIRK_CLOCK_DIV_ZERO_BROKEN")
> ---
>  drivers/mmc/host/sdhci.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b2dc4f1cfa5c..a043bf5e3565 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1807,9 +1807,12 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  
>  		if (!host->clk_mul || switch_base_clk) {
>  			/* Version 3.00 divisors must be a multiple of 2. */
> -			if (host->max_clk <= clock)
> +			if (host->max_clk <= clock) {
>  				div = 1;
> -			else {
> +				if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
> +					&& host->max_clk <= 25000000)
> +					div = 2;
> +			} else {
>  				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
>  				     div += 2) {
>  					if ((host->max_clk / div) <= clock)
> @@ -1818,9 +1821,6 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
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

