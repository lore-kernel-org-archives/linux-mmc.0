Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F24C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 11:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B76D60F39
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 11:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244453AbhIXLfJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 07:35:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:34056 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244439AbhIXLfI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 24 Sep 2021 07:35:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="211295119"
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="211295119"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 04:33:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="703494531"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.84]) ([10.237.72.84])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2021 04:33:30 -0700
Subject: Re: [PATCH v2 1/2] mmc: sdhci-of-at91: wait for calibration done
 before proceed
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        eugen.hristev@microchip.com, ulf.hansson@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210924082851.2132068-1-claudiu.beznea@microchip.com>
 <20210924082851.2132068-2-claudiu.beznea@microchip.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9c38e4b6-c052-ec98-bf25-1a8d05f6d73d@intel.com>
Date:   Fri, 24 Sep 2021 14:34:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210924082851.2132068-2-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/09/21 11:28 am, Claudiu Beznea wrote:
> Datasheet specifies that at the end of calibration the SDMMC_CALCR_EN
> bit will be cleared. No commands should be send before calibration is
> done.
> 
> Fixes: dbdea70f71d67 ("mmc: sdhci-of-at91: fix CALCR register being rewritten")
> Fixes: 727d836a375ad ("mmc: sdhci-of-at91: add DT property to enable calibration on full reset")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Hi Nicolas,
> 
> I haven't added your tag from previous version as I changed the
> implementation to use read_poll_timeout().
> 
> Thank you,
> Claudiu Beznea
> 
>  drivers/mmc/host/sdhci-of-at91.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 5564d7b23e7c..134ba01d3063 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -11,6 +11,7 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/slot-gpio.h>
> @@ -114,6 +115,7 @@ static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	unsigned int tmp;
>  
>  	sdhci_reset(host, mask);
>  
> @@ -126,6 +128,10 @@ static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
>  
>  		sdhci_writel(host, calcr | SDMMC_CALCR_ALWYSON | SDMMC_CALCR_EN,
>  			     SDMMC_CALCR);
> +
> +		if (read_poll_timeout(sdhci_readl, tmp, !(tmp & SDMMC_CALCR_EN),
> +				      10, 20000, false, host, SDMMC_CALCR))
> +			dev_err(mmc_dev(host->mmc), "Failed to calibrate\n");
>  	}
>  }
>  
> 

