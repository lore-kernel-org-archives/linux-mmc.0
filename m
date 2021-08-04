Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193D6C4338F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 10:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F089060F38
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 10:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbhHDKwD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:52:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:29882 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237593AbhHDKwD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Aug 2021 06:52:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="194176956"
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="194176956"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 03:51:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="419390433"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2021 03:51:47 -0700
Subject: Re: [PATCH v4 2/5] mmc: sdhci: always obey programmable clock config
 in preset value
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>
References: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
 <e65dc96eb24caf8baa5431a51fe694b969e2d51f.1627204633.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fe01b20d-779b-1e2c-7702-5a4702900d84@intel.com>
Date:   Wed, 4 Aug 2021 13:52:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e65dc96eb24caf8baa5431a51fe694b969e2d51f.1627204633.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/07/21 12:20 pm, Michał Mirosław wrote:
> When host controller uses programmable clock presets but doesn't
> advertise programmable clock support, we can only guess what frequency
> it generates. Let's at least return correct SDHCI_PROG_CLOCK_MODE bit
> value in this case.

If the preset value doesn't make sense, why use it at all?

> 
> Fixes: 52983382c74f ("mmc: sdhci: enhance preset value function")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
> v4: no changes
> v3: added a comment for this case
> v2: no changes
> ---
>  drivers/mmc/host/sdhci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c7438dd13e3e..3ab60e7f936b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1859,11 +1859,14 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  
>  			pre_val = sdhci_get_preset_value(host);
>  			div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
> -			if (host->clk_mul &&
> -				(pre_val & SDHCI_PRESET_CLKGEN_SEL)) {
> +			if (pre_val & SDHCI_PRESET_CLKGEN_SEL) {
>  				clk = SDHCI_PROG_CLOCK_MODE;
>  				real_div = div + 1;
>  				clk_mul = host->clk_mul;
> +				if (!clk_mul) {
> +					/* The clock frequency is unknown. Assume undivided base. */
> +					clk_mul = 1;
> +				}
>  			} else {
>  				real_div = max_t(int, 1, div << 1);
>  			}
> 

