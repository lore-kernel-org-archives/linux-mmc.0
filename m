Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084FDC2BA19
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 12:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD53320936
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 12:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409853AbgDOM0t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:26:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:61376 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409850AbgDOM0s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Apr 2020 08:26:48 -0400
IronPort-SDR: 5bJ7U6SeDIVyBLtowxZF96Jj/UpGs+hzm04CObueHbTO2OtLQIK6oBdykosymwkS1qw5vzJG+9
 J3FdRoTu4Kcg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 05:26:45 -0700
IronPort-SDR: h9oBrlVuMfihHlm+c7RReoucOSid7EY9BIvBcCULrmmStw1b50KZcCYstK6IciHld7GaviMPoZ
 ZVX8WeOr083g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="400298276"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2020 05:26:42 -0700
Subject: Re: [PATCH 1/7] mmc: sdhci: fix base clock usage in preset value
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
 <23c3fe72b0ff0eabdbf3a45023a76da1b18a7e90.1585827904.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <218dd61b-48cc-a161-240f-b3823e8f48cb@intel.com>
Date:   Wed, 15 Apr 2020 15:25:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <23c3fe72b0ff0eabdbf3a45023a76da1b18a7e90.1585827904.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/04/20 2:54 pm, Michał Mirosław wrote:
> Fixed commit added an unnecessary read of CLOCK_CONTROL. The value read
> is overwritten for programmable clock preset, but is carried over for
> divided clock preset. This can confuse sdhci_enable_clk() if the register
> has enable bits set for some reason at time time of clock calculation.
> value to be ORed with enable flags. Remove the read.

The read is not needed, but drivers usually manage the enable bits,
especially disabling the clock before changing the frequency.  What driver
is it?

> 
> Fixes: 52983382c74f ("mmc: sdhci: enhance preset value function")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/mmc/host/sdhci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3f716466fcfd..9aa3af5826df 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1765,7 +1765,6 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  		if (host->preset_enabled) {
>  			u16 pre_val;
>  
> -			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>  			pre_val = sdhci_get_preset_value(host);
>  			div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
>  			if (host->clk_mul &&
> 

