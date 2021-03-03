Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D0DC43381
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A6C64F4B
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350311AbhCDAAJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:1134 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1445851AbhCCHEK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 3 Mar 2021 02:04:10 -0500
IronPort-SDR: MCynbg9QqafsO/iXL4O4+QXr15eektXEhpWiySUtRhcmDSkuz/PfgHVRcHexwmB0E0QokUi5lY
 ZBFzSu7qaC1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="206803455"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="206803455"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 23:01:27 -0800
IronPort-SDR: WHAJmjKN/Azc0sQYc8LYpZjpCGYAY91pLznCIavql1chYxmkc+h3LsBhNyfmrphq2mU3WtjQWd
 ghOAq0zJH5Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="406347875"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 02 Mar 2021 23:01:22 -0800
Subject: Re: [PATCH V1] mmc: sdhci: Check for reset prior to DMA address unmap
To:     Pradeep P V K <pragalla@codeaurora.org>, ulf.hansson@linaro.org
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        rampraka@codeaurora.org, vbadigan@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1614163985-38914-1-git-send-email-pragalla@codeaurora.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <17f65e3f-de29-795d-6b05-e501db31463e@intel.com>
Date:   Wed, 3 Mar 2021 09:01:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1614163985-38914-1-git-send-email-pragalla@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/02/21 12:53 pm, Pradeep P V K wrote:
> For data read commands, SDHC may initiate data transfers even before it
> completely process the command response. In case command itself fails,
> driver un-maps the memory associated with data transfer but this memory
> can still be accessed by SDHC for the already initiated data transfer.
> This scenario can lead to un-mapped memory access error.
> 
> To avoid this scenario, reset SDHC (when command fails) prior to
> un-mapping memory. Resetting SDHC ensures that all in-flight data
> transfers are either aborted or completed. So we don't run into this
> scenario.
> 
> Swap the reset, un-map steps sequence in sdhci_request_done().
> 
> Suggested-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Signed-off-by: Pradeep P V K <pragalla@codeaurora.org>

Seems like a good change to make.  A couple of cosmetic tweaks below,
but:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 58 ++++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 646823d..e78d84c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2996,6 +2996,35 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  		spin_unlock_irqrestore(&host->lock, flags);
>  		return true;
>  	}

Blank line here please.

> +	/*
> +	 * The controller needs a reset of internal state machines
> +	 * upon error conditions.
> +	 */
> +	if (sdhci_needs_reset(host, mrq)) {
> +		/*
> +		 * Do not finish until command and data lines are available for
> +		 * reset. Note there can only be one other mrq, so it cannot
> +		 * also be in mrqs_done, otherwise host->cmd and host->data_cmd
> +		 * would both be null.
> +		 */
> +		if (host->cmd || host->data_cmd) {
> +			spin_unlock_irqrestore(&host->lock, flags);
> +			return true;
> +		}
> +
> +		/* Some controllers need this kick or reset won't work here */
> +		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
> +			/* This is to force an update */
> +			host->ops->set_clock(host, host->clock);
> +
> +		/* Spec says we should do both at the same time, but Ricoh
> +		 * controllers do not like that.
> +		 */

Please change comment style:

		/*
		 * Spec says we should do both at the same time, but Ricoh
		 * controllers do not like that.
		 */

> +		sdhci_do_reset(host, SDHCI_RESET_CMD);
> +		sdhci_do_reset(host, SDHCI_RESET_DATA);
> +
> +		host->pending_reset = false;
> +	}
>  
>  	/*
>  	 * Always unmap the data buffers if they were mapped by
> @@ -3060,35 +3089,6 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  		}
>  	}
>  
> -	/*
> -	 * The controller needs a reset of internal state machines
> -	 * upon error conditions.
> -	 */
> -	if (sdhci_needs_reset(host, mrq)) {
> -		/*
> -		 * Do not finish until command and data lines are available for
> -		 * reset. Note there can only be one other mrq, so it cannot
> -		 * also be in mrqs_done, otherwise host->cmd and host->data_cmd
> -		 * would both be null.
> -		 */
> -		if (host->cmd || host->data_cmd) {
> -			spin_unlock_irqrestore(&host->lock, flags);
> -			return true;
> -		}
> -
> -		/* Some controllers need this kick or reset won't work here */
> -		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
> -			/* This is to force an update */
> -			host->ops->set_clock(host, host->clock);
> -
> -		/* Spec says we should do both at the same time, but Ricoh
> -		   controllers do not like that. */
> -		sdhci_do_reset(host, SDHCI_RESET_CMD);
> -		sdhci_do_reset(host, SDHCI_RESET_DATA);
> -
> -		host->pending_reset = false;
> -	}
> -
>  	host->mrqs_done[i] = NULL;
>  
>  	spin_unlock_irqrestore(&host->lock, flags);
> 

