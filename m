Return-Path: <SRS0=RtJ+=3D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E25CC33CB1
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jan 2020 13:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2F024685
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jan 2020 13:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgANNJC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:09:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:11756 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgANNJC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Jan 2020 08:09:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 05:09:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,432,1571727600"; 
   d="scan'208";a="256295592"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jan 2020 05:09:00 -0800
Subject: Re: [PATCH] mmc: sdhci: fix minimum clock rate for v3 controller
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org
References: <3f3b2ac4634802af591a20b1b98dc8d0158aec45.1577962196.git.mirq-linux@rere.qmqm.pl>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4264051e-6126-83c3-e49e-3d9050ff35ce@intel.com>
Date:   Tue, 14 Jan 2020 15:08:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3f3b2ac4634802af591a20b1b98dc8d0158aec45.1577962196.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/01/20 12:51 pm, Michał Mirosław wrote:
> For SDHCIv3+ with programmable clock mode, minimal clock frequency is
> still base clock / max(divider). Minimal programmable clock frequency is
> always greater than minimal divided clock frequency. Without this patch,
> SDHCI uses out-of-spec initial frequency when multiplier is big enough:
> 
> mmc1: mmc_rescan_try_freq: trying to init card at 468750 Hz
> [for 480 MHz source clock divided by 1024]

The maximum divisor in programmable clock mode is 1024.  So I do not
understand what is wrong.  Can you explain some more?

> 
> Cc: stable@vger.kernel.org
> Fixes: c3ed3877625f ("mmc: sdhci: add support for programmable clock mode")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/mmc/host/sdhci.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 275102c0a1bf..0036ddf85674 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3902,11 +3902,9 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	if (host->ops->get_min_clock)
>  		mmc->f_min = host->ops->get_min_clock(host);
>  	else if (host->version >= SDHCI_SPEC_300) {
> -		if (host->clk_mul) {
> -			mmc->f_min = (host->max_clk * host->clk_mul) / 1024;
> +		if (host->clk_mul)
>  			max_clk = host->max_clk * host->clk_mul;
> -		} else
> -			mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
> +		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
>  	} else
>  		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
>  
> 

