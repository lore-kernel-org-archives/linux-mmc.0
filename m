Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5881AC64E90
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265022173E
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388756AbgKZIQj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:16:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:49317 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388754AbgKZIQj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 03:16:39 -0500
IronPort-SDR: m31vHCa+XY+sE+vSmV5UPLh542cBkoubW2NPcbpGENopF4nqF0bB0D01ei/2RzV7mhW7ADVxsf
 C/uIj4n1GP1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="236384688"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="236384688"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 00:16:38 -0800
IronPort-SDR: 92+5kxHRm22J1QxOhD/8PW1RRFDhiEPGtj8A4bQ32ZCwq+GOd06C173cn0q2f1uR/fKlmwJc6C
 /2FZZO4BSBfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="362721502"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2020 00:16:33 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH v3.1 12/27] mmc: sdhci-uhs2: add reset function
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-13-takahiro.akashi@linaro.org>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ed1e3497-4deb-49ad-22b0-ed74fb0ef7ec@intel.com>
Date:   Thu, 26 Nov 2020 10:16:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106022726.19831-13-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> Sdhci_uhs2_reset() does a UHS-II specific reset operation.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 49 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |  1 +
>  drivers/mmc/host/sdhci.c      |  3 ++-
>  drivers/mmc/host/sdhci.h      |  1 +
>  4 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 08905ed081fb..e2b9743fe17d 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -10,6 +10,7 @@
>   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/module.h>
>  
>  #include "sdhci.h"
> @@ -49,6 +50,54 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>  
> +/*****************************************************************************\
> + *                                                                           *
> + * Low level functions                                                       *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +/**
> + * sdhci_uhs2_reset - invoke SW reset
> + * @host: SDHCI host
> + * @mask: Control mask
> + *
> + * Invoke SW reset, depending on a bit in @mask and wait for completion.
> + */
> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
> +{
> +	unsigned long timeout;
> +
> +	if (!(host->mmc->caps & MMC_CAP_UHS2))

Please make a helper so this can be like:

	if (!sdhci_uhs2_mode(host))

The capability will be always present for hosts that support UHS2, but not
all cards support UHS2 mode.  I suggest just adding a bool to struct
sdhci_host to keep track of when the host is in UHS2 mode.

> +		return;
> +
> +	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
> +
> +	if (mask & SDHCI_UHS2_SW_RESET_FULL) {
> +		host->clock = 0;
> +		/* Reset-all turns off SD Bus Power */
> +		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)

I would prefer not to support any legacy quirks that we do not need right
now.  Just be sure to add a comment somewhere listing which quirks are not
supported for UHS2 host controllers.

> +			sdhci_runtime_pm_bus_off(host);
> +	}
> +
> +	/* Wait max 100 ms */
> +	timeout = 10000;
> +
> +	/* hw clears the bit when it's done */
> +	while (sdhci_readw(host, SDHCI_UHS2_SW_RESET) & mask) {

This kind of loop can now be done with read_poll_timeout_atomic(sdhci_readw,
..., host, SDHCI_UHS2_SW_RESET)

> +		if (timeout == 0) {
> +			pr_err("%s: %s: Reset 0x%x never completed.\n",
> +			       __func__, mmc_hostname(host->mmc), (int)mask);
> +			pr_err("%s: clean reset bit\n",
> +			       mmc_hostname(host->mmc));
> +			sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
> +			return;
> +		}
> +		timeout--;
> +		udelay(10);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index b9529d32b58d..7bb7a0d67109 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -210,5 +210,6 @@
>  struct sdhci_host;
>  
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> +void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>  
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d4a57e8c9bb8..af336bdb4305 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -195,13 +195,14 @@ static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
>  	pm_runtime_get_noresume(host->mmc->parent);
>  }
>  
> -static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
> +void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
>  {
>  	if (!host->bus_on)
>  		return;
>  	host->bus_on = false;
>  	pm_runtime_put_noidle(host->mmc->parent);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_off);
>  
>  void sdhci_reset(struct sdhci_host *host, u8 mask)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d9d7a76cedc1..b9932423db08 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -831,6 +831,7 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
>  	__sdhci_read_caps(host, NULL, NULL, NULL);
>  }
>  
> +void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
>  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  		   unsigned int *actual_clock);
>  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
> 

