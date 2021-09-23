Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C0EC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 09:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BC561216
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 09:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbhIWJDu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 05:03:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:28068 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239985AbhIWJDs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 23 Sep 2021 05:03:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="210875978"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="210875978"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 02:02:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="550781819"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.84]) ([10.237.72.84])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Sep 2021 02:02:09 -0700
Subject: Re: [PATCH] mmc: sdhci-of-at91: wait for calibration done before
 proceed
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        eugen.hristev@microchip.com, ulf.hansson@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210915102838.8344-1-claudiu.beznea@microchip.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4e20c4fb-ff54-59b7-bca2-1b359fe9ff42@intel.com>
Date:   Thu, 23 Sep 2021 12:02:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210915102838.8344-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/09/21 1:28 pm, Claudiu Beznea wrote:
> Datasheet specifies that at the end of calibration the SDMMC_CALCR_EN
> bit will be cleared. No commands should be send before calibration is
> done.
> 
> Fixes: dbdea70f71d67 ("mmc: sdhci-of-at91: fix CALCR register being rewritten")
> Fixes: 727d836a375ad ("mmc: sdhci-of-at91: add DT property to enable calibration on full reset")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/mmc/host/sdhci-of-at91.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 5564d7b23e7c..2b28711e039d 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -114,6 +114,8 @@ static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	unsigned long timeout = jiffies + msecs_to_jiffies(20);
> +	unsigned int tmp;
>  
>  	sdhci_reset(host, mask);
>  
> @@ -126,6 +128,14 @@ static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
>  
>  		sdhci_writel(host, calcr | SDMMC_CALCR_ALWYSON | SDMMC_CALCR_EN,
>  			     SDMMC_CALCR);
> +
> +		do {
> +			tmp = sdhci_readl(host, SDMMC_CALCR);
> +		} while (time_before(jiffies, timeout) &&
> +			 (tmp & SDMMC_CALCR_EN));
> +
> +		if (tmp & SDMMC_CALCR_EN)
> +			dev_err(mmc_dev(host->mmc), "Failed to calibrate\n");

Please use a polling macro (include <linux/iopoll.h>)
i.e.

		if (read_poll_timeout(sdhci_readl, tmp, !(tmp & SDMMC_CALCR_EN),
				      10, 20000, false, host, SDMMC_CALCR))
			dev_err(mmc_dev(host->mmc), "Failed to calibrate\n");



>  	}
>  }
>  
> 

