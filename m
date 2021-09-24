Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBE1C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 11:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A65A4610F7
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 11:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244933AbhIXLfj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 07:35:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:34093 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244439AbhIXLfj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 24 Sep 2021 07:35:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="211295196"
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="211295196"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 04:34:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="703494695"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.84]) ([10.237.72.84])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2021 04:34:03 -0700
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-at91: replace while loop with
 read_poll_timeout
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        eugen.hristev@microchip.com, ulf.hansson@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210924082851.2132068-1-claudiu.beznea@microchip.com>
 <20210924082851.2132068-3-claudiu.beznea@microchip.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <10b77993-8ab9-75dc-69e8-2775f8fcc7b1@intel.com>
Date:   Fri, 24 Sep 2021 14:34:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210924082851.2132068-3-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/09/21 11:28 am, Claudiu Beznea wrote:
> Replace while loop with read_poll_timeout().
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-at91.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 134ba01d3063..d1a1c548c515 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -62,7 +62,6 @@ static void sdhci_at91_set_force_card_detect(struct sdhci_host *host)
>  static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	u16 clk;
> -	unsigned long timeout;
>  
>  	host->mmc->actual_clock = 0;
>  
> @@ -87,16 +86,11 @@ static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned int clock)
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>  
>  	/* Wait max 20 ms */
> -	timeout = 20;
> -	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> -		& SDHCI_CLOCK_INT_STABLE)) {
> -		if (timeout == 0) {
> -			pr_err("%s: Internal clock never stabilised.\n",
> -			       mmc_hostname(host->mmc));
> -			return;
> -		}
> -		timeout--;
> -		mdelay(1);
> +	if (read_poll_timeout(sdhci_readw, clk, (clk & SDHCI_CLOCK_INT_STABLE),
> +			      1000, 20000, false, host, SDHCI_CLOCK_CONTROL)) {
> +		pr_err("%s: Internal clock never stabilised.\n",
> +		       mmc_hostname(host->mmc));
> +		return;
>  	}
>  
>  	clk |= SDHCI_CLOCK_CARD_EN;
> 

