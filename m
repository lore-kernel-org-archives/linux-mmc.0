Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F602C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 06:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68DD360E9B
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 06:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244165AbhIXGdx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 02:33:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:1855 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244176AbhIXGdv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 24 Sep 2021 02:33:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="220811716"
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="220811716"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 23:32:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="703332305"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.84]) ([10.237.72.84])
  by fmsmga006.fm.intel.com with ESMTP; 23 Sep 2021 23:32:11 -0700
Subject: Re: [PATCH v1 1/2] mmc: sdhci: Return true only when timeout exceeds
 capacity of the HW timer
To:     Bean Huo <huobean@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210917172727.26834-1-huobean@gmail.com>
 <20210917172727.26834-2-huobean@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8abc1138-9192-fe7a-8e51-3939181a4992@intel.com>
Date:   Fri, 24 Sep 2021 09:32:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210917172727.26834-2-huobean@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/09/21 8:27 pm, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Clean up sdhci_calc_timeout() a bit,  and let it set too_big to be true only
> when the timeout value required by the eMMC device exceeds the capability of
> the host hardware timer.
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7ae398f8d4d3..357b365bf0ec 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -930,7 +930,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
>  	struct mmc_data *data;
>  	unsigned target_timeout, current_timeout;
>  
> -	*too_big = true;
> +	*too_big = false;
>  
>  	/*
>  	 * If the host controller provides us with an incorrect timeout
> @@ -941,7 +941,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
>  	if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
>  		return host->max_timeout_count;
>  
> -	/* Unspecified command, asume max */
> +	/* Unspecified command, assume max */
>  	if (cmd == NULL)
>  		return host->max_timeout_count;
>  
> @@ -968,17 +968,14 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
>  	while (current_timeout < target_timeout) {
>  		count++;
>  		current_timeout <<= 1;
> -		if (count > host->max_timeout_count)
> +		if (count > host->max_timeout_count) {
> +			if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
> +				DBG("Too large timeout 0x%x requested for CMD%d!\n",
> +				    count, cmd->opcode);
> +			count = host->max_timeout_count;
> +			*too_big = true;
>  			break;
> -	}
> -
> -	if (count > host->max_timeout_count) {
> -		if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
> -			DBG("Too large timeout 0x%x requested for CMD%d!\n",
> -			    count, cmd->opcode);
> -		count = host->max_timeout_count;
> -	} else {
> -		*too_big = false;
> +		}
>  	}
>  
>  	return count;
> 

