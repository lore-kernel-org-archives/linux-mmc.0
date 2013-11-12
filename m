From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH V2] sdhci: only reprogram retuning timer when flag is
 set
Date: Tue, 12 Nov 2013 14:49:29 +0800
Message-ID: <5281CF79.1040803@intel.com>
References: <1383821960-2533-1-git-send-email-arend@broadcom.com> <1384163395-27038-1-git-send-email-arend@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6522 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255Ab3KLGsk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Nov 2013 01:48:40 -0500
In-Reply-To: <1384163395-27038-1-git-send-email-arend@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On 11/11/2013 05:49 PM, Arend van Spriel wrote:
> When the host->tuning_count is zero it means that the
> retuning is disabled. This is checked on the first
> run of sdhci_execute_tuning() by the if statement below:
> 
> 	if (!(host->flags & SDHCI_NEEDS_RETUNING) && host->tuning_count &&
> 	    (host->tuning_mode == SDHCI_TUNING_MODE_1)) {
> 
> So only when tuning_count is non-zero it will set the host
> flag SDHCI_USING_RETUNING_TIMER. The else statement is only
> for re-programming the timer, which means that flag must be
> set. Because that is not checked the else statement is executed
> in the first run when tuning_count is zero.
> 
> This was seen on a host controller which indicated
> SDHCI_TUNING_MODE_1 (0) and tuning_count being zero. Suspect
> that (one of) these registers is not properly set.
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>

Reviewed-by: Aaron Lu <aaron.lu@intel.com>

-Aaron

> ---
> This patch applies to the mmc-next branch.
> 
> V2:
> - add more explanation to the commit message
> - check host flag SDHCI_USING_RETUNING_TIMER
> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index bd8a098..5974599 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2014,7 +2014,7 @@ out:
>  			host->tuning_count * HZ);
>  		/* Tuning mode 1 limits the maximum data length to 4MB */
>  		mmc->max_blk_count = (4 * 1024 * 1024) / mmc->max_blk_size;
> -	} else {
> +	} else if (host->flags & SDHCI_USING_RETUNING_TIMER) {
>  		host->flags &= ~SDHCI_NEEDS_RETUNING;
>  		/* Reload the new initial value for timer */
>  		if (host->tuning_mode == SDHCI_TUNING_MODE_1)
> 

