From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 2/2] mmc: sdhci: Deal with failure case in sdhci_suspend_host
Date: Mon, 09 Jan 2012 16:56:28 +0200
Message-ID: <4F0B001C.9010205@intel.com>
References: <1325642863-8734-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34210 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754079Ab2AIO43 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 Jan 2012 09:56:29 -0500
In-Reply-To: <1325642863-8734-1-git-send-email-aaron.lu@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

On 04/01/12 04:07, Aaron Lu wrote:
> V3: Rework on top of Adrian's vmmc patch
> 
> V2: Error processing code in sdhci_pci_suspend should not be deleted,
> it is used to resume hosts which are already successfully suspended for
> a multi slot pci device as suggested by Adrian.
> 
> If there are errors happened in sdhci_suspend_host, handle it so that
> when the function returns with an error, the host's behaviour is the
> same before this function call, e.g. card detection is enabled and
> tuning timer is active, etc.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Aaron Lu <aaron.lu@amd.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c |   18 ++++++++++++++----
>  1 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 988ae06..823b83e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2349,20 +2349,30 @@ out:
>  
>  int sdhci_suspend_host(struct sdhci_host *host)
>  {
> -	int ret;
> +	int ret, has_tuning_timer;
>  
>  	sdhci_disable_card_detection(host);
>  
>  	/* Disable tuning since we are suspending */
> -	if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
> -	    host->tuning_mode == SDHCI_TUNING_MODE_1) {
> +	has_tuning_timer = host->version >= SDHCI_SPEC_300 &&
> +		host->tuning_count && host->tuning_mode == SDHCI_TUNING_MODE_1;
> +	if (has_tuning_timer) {
>  		del_timer_sync(&host->tuning_timer);
>  		host->flags &= ~SDHCI_NEEDS_RETUNING;
>  	}
>  
>  	ret = mmc_suspend_host(host->mmc);
> -	if (ret)
> +	if (ret) {
> +		if (has_tuning_timer) {
> +			host->flags |= SDHCI_NEEDS_RETUNING;
> +			mod_timer(&host->tuning_timer, jiffies +
> +					host->tuning_count * HZ);
> +		}
> +
> +		sdhci_enable_card_detection(host);
> +
>  		return ret;
> +	}
>  
>  	free_irq(host->irq, host);
>  

