From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] sdhci: do not program timer when tuning_count is zero
Date: Fri, 08 Nov 2013 14:50:04 +0800
Message-ID: <527C899C.3030506@intel.com>
References: <1383821960-2533-1-git-send-email-arend@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65074 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452Ab3KHGtV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Nov 2013 01:49:21 -0500
In-Reply-To: <1383821960-2533-1-git-send-email-arend@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On 11/07/2013 06:59 PM, Arend van Spriel wrote:
> When the host->tuning_count is zero it means that the

If the tuning_count is zero, then the retuning timer shouldn't be
started in the first place and not possible to run code there. Or is the
tuning_count dynamically changed?

Thanks,
Aaron

> retuning is disabled. Doing a mod_timer() with a zero
> tuning_count does something else.
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
>  drivers/mmc/host/sdhci.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7a7fb4f..9803e7a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2007,7 +2007,8 @@ out:
>  	} else {
>  		host->flags &= ~SDHCI_NEEDS_RETUNING;
>  		/* Reload the new initial value for timer */
> -		if (host->tuning_mode == SDHCI_TUNING_MODE_1)
> +		if (host->tuning_count &&
> +		    host->tuning_mode == SDHCI_TUNING_MODE_1)
>  			mod_timer(&host->tuning_timer, jiffies +
>  				host->tuning_count * HZ);
>  	}
> 

