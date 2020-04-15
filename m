Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64761C3815B
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 12:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DAB3206D5
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 12:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370187AbgDOMpr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:45:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:38139 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898214AbgDOMpQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Apr 2020 08:45:16 -0400
IronPort-SDR: z/6xoj2ZU/4X0z5P3Z4Y9rRZzu2YznYM3L0KmvhZ26hUTbpLDGc1K7kQh5GkUkG3MVh/L3Bdop
 J4WfLQqV9rDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 05:45:14 -0700
IronPort-SDR: q1xBjxILhRQpAuAQ37RLJ2+p/+tMWl0yibVHrlAqFoKxKj+N4QMVKNnfxcIB+5B9fk71i+ZJ3U
 2HwW4Yh2h3zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="400302526"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2020 05:45:10 -0700
Subject: Re: [PATCH 2/7] mmc: sdhci: fix programmable clock config from preset
 value
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Kevin Liu <kliu5@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <cover.1585827904.git.mirq-linux@rere.qmqm.pl>
 <0077b8bc2a4da024a3b985dd622674ebebe5b71b.1585827904.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <94e170c9-e4cd-2109-667c-f6c81f65acd3@intel.com>
Date:   Wed, 15 Apr 2020 15:44:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0077b8bc2a4da024a3b985dd622674ebebe5b71b.1585827904.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/04/20 2:54 pm, Michał Mirosław wrote:
> When host controller uses programmable clock presets but doesn't
> advertise programmable clock support, we can only guess what frequency
> it generates. Let's at least return correct SDHCI_PROG_CLOCK_MODE bit
> value in this case.

It sounds like the hardware is broken, so I tend to think a workaround
should be in the relevant vendor driver, because that is where
device-specific information really belongs.

> 
> Fixes: 52983382c74f ("mmc: sdhci: enhance preset value function")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/mmc/host/sdhci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9aa3af5826df..b2dc4f1cfa5c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1767,11 +1767,10 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  
>  			pre_val = sdhci_get_preset_value(host);
>  			div = FIELD_GET(SDHCI_PRESET_SDCLK_FREQ_MASK, pre_val);
> -			if (host->clk_mul &&
> -				(pre_val & SDHCI_PRESET_CLKGEN_SEL)) {
> +			if (pre_val & SDHCI_PRESET_CLKGEN_SEL) {
>  				clk = SDHCI_PROG_CLOCK_MODE;
>  				real_div = div + 1;
> -				clk_mul = host->clk_mul;
> +				clk_mul = host->clk_mul ?: 1;
>  			} else {
>  				real_div = max_t(int, 1, div << 1);
>  			}
> 

