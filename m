Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E82C4338F
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Aug 2021 10:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65554610A4
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Aug 2021 10:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhHLKBq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Aug 2021 06:01:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:36090 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236541AbhHLKBp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Aug 2021 06:01:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="279061099"
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; 
   d="scan'208";a="279061099"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 03:01:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; 
   d="scan'208";a="676709168"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga005.fm.intel.com with ESMTP; 12 Aug 2021 03:01:16 -0700
Subject: Re: [PATCH v4 4/5] mmc: sdhci: move
 SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN frequency limit
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Kevin Liu <kliu5@marvell.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>
References: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
 <ff3907df3aa91f83a4a0a22b63d51bfe491ed039.1627204633.git.mirq-linux@rere.qmqm.pl>
 <2cdb95f3-8943-715a-d3d7-804953e49786@intel.com>
 <YQ6U5EeOPzCvLT8z@qmqm.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a64c83a5-641a-84cf-a208-41c87afd61cf@intel.com>
Date:   Thu, 12 Aug 2021 13:01:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQ6U5EeOPzCvLT8z@qmqm.qmqm.pl>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/08/21 5:12 pm, Micha³ Miros³aw wrote:
> On Wed, Aug 04, 2021 at 03:33:56PM +0300, Adrian Hunter wrote:
>> On 25/07/21 12:20 pm, Micha³ Miros³aw wrote:
>>> Push handling of clock frequency dependence for
>>> SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN quirk to the drivers that use it.
>> What is the max_clk dependency for, and why push it down?
> 
> I guess this is a workaround for a hardware issue. When I wrote this,
> there was only a single user. Now I don't know if the second user got
> the limit by accident or just uses the flag not knowing it doesn't work
> as the quirk name suggests. IOW this makes it easier to fix in drivers
> if the limit is wrong or irrelevant. The dependency doesn't feel like
> it belongs to the generic driver anyway.

Would you mind reaching out to the authors of the relevant patches
and drivers to try to find out the purpose of the max_clk dependency,
before we make any changes?


> 
> [...]
>>> @@ -318,6 +317,9 @@ static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
>>>  	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
>>>  	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
>>>  
>>> +	if (sdhci_pltfm_clk_get_max_clock(host) <= 25000000)
>>> +		host->quirks2 |= SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN;
>>> +
>>>  	return 0;
>>>  }
>>>  
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 0993f7d0ce8e..cfa314e659bc 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1905,8 +1905,7 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>>>  			/* Version 3.00 divisors must be a multiple of 2. */
>>>  			if (host->max_clk <= clock) {
>>>  				div = 1;
>>> -				if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
>>> -					&& host->max_clk <= 25000000)
>>> +				if (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
>>>  					div = 2;
>>>  			} else {
>>>  				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;

