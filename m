Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80866C56202
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2866E20B80
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbgKZIS0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:18:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:58565 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731216AbgKZIS0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 03:18:26 -0500
IronPort-SDR: rtr+s8TUqCfu3MBghY650rWHE8jlomxgV1IA4z0oWbPXZxeB2eMuuUn/6I7kPnRqVvnjJl27CD
 QGTl5hvPFOFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="159300539"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="159300539"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 00:18:25 -0800
IronPort-SDR: hm96Pd3nq9Btt6G79BlvolHcf808bMMLAHyi8LDq5GKPCoXdGiM5QEyQ+M6AeSGZVISNiuaVlW
 nmRCyfw55Rng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="362722199"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2020 00:18:21 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH v3.1 18/27] mmc: sdhci-uhs2: add clock operations
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-19-takahiro.akashi@linaro.org>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <14ad8c85-0dbb-b023-6a0d-7805cc6f0ab8@intel.com>
Date:   Thu, 26 Nov 2020 10:17:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106022726.19831-19-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> This is a sdhci version of mmc's uhs2_[enable|disable]_clk operations.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 41 +++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 994dff967e85..55362ace1857 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/ktime.h>
>  #include <linux/module.h>
>  
>  #include "sdhci.h"
> @@ -385,6 +386,42 @@ void sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	__sdhci_uhs2_set_ios(mmc, ios);
>  }
>  
> +static void sdhci_uhs2_disable_clk(struct mmc_host *mmc)
> +{
> +        struct sdhci_host *host = mmc_priv(mmc);
> +	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +	clk &= ~SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +}
> +
> +static void sdhci_uhs2_enable_clk(struct mmc_host *mmc)
> +{
> +        struct sdhci_host *host = mmc_priv(mmc);
> +	u16 clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	ktime_t timeout;
> +
> +	clk |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	/* Wait max 20 ms */
> +	timeout = ktime_add_ms(ktime_get(), 20);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);

Can use read_poll_timeout(sdhci_readw,..., host, SDHCI_CLOCK_CONTROL)

> +		if (clk & SDHCI_CLOCK_INT_STABLE)
> +			break;
> +		if (timedout) {
> +			pr_err("%s: Internal clock never stabilised.\n",
> +			       mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			return;
> +		}
> +		udelay(10);
> +	}
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> @@ -556,6 +593,10 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  
>  	if (!host->mmc_host_ops.uhs2_detect_init)
>  		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
> +	if (!host->mmc_host_ops.uhs2_disable_clk)
> +		host->mmc_host_ops.uhs2_disable_clk = sdhci_uhs2_disable_clk;
> +	if (!host->mmc_host_ops.uhs2_enable_clk)
> +		host->mmc_host_ops.uhs2_enable_clk = sdhci_uhs2_enable_clk;
>  
>  	return 0;
>  }
> 

