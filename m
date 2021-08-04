Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13F7C4338F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 10:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE9B361037
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 10:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbhHDKuF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:50:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:53456 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236736AbhHDKuE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Aug 2021 06:50:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="201081271"
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="201081271"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 03:49:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="419388484"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2021 03:49:42 -0700
Subject: Re: [PATCH v4 1/5] mmc: sdhci: fix base clock usage in preset value
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>
References: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
 <fff139f001835efb5ee428093a9522d7761642de.1627204633.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <84dfa2fd-0b02-82b3-80ba-f0a9d59d89b6@intel.com>
Date:   Wed, 4 Aug 2021 13:50:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <fff139f001835efb5ee428093a9522d7761642de.1627204633.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/07/21 12:20 pm, Michał Mirosław wrote:
> Fixed commit added an unnecessary read of CLOCK_CONTROL. The value read
> is overwritten for programmable clock preset, but is carried over for
> divided clock preset. This can confuse sdhci_enable_clk() if the register
> has enable bits set for some reason at time time of clock calculation.

"time time" -> "time"

> Remove the read.
> 
> Quoting Al Cooper:
> 
> sdhci_brcmstb_set_clock() assumed that sdhci_calc_clk() would always
> return the divider value without the enable set, so this fixes a case
> for DDR52 where the enable was not being cleared when the divider
> value was changed.
> 
> Cc: stable@vger.kernel.org
> Fixes: 52983382c74f ("mmc: sdhci: enhance preset value function")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Acked-by: Al Cooper <alcooperx@gmail.com>

Apart from above:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> v4: no changes
> v3: updated commit message
> v2: removed truncated sentence from commitmsg
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/mmc/host/sdhci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index aba6e10b8605..c7438dd13e3e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1857,7 +1857,6 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  		if (host->preset_enabled) {
>  			u16 pre_val;
>  
> -			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>  			pre_val = sdhci_get_preset_value(host);
>  			div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
>  			if (host->clk_mul &&
> 

