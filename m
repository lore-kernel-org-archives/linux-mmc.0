From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Fix tuning timer incorrect setting when
 suspending host
Date: Wed, 28 Dec 2011 14:24:44 +0200
Message-ID: <4EFB0A8C.7040207@intel.com>
References: <1325041873-1320-1-git-send-email-aaron.lu@amd.com> <1325041873-1320-2-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53842 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319Ab1L1MYp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Dec 2011 07:24:45 -0500
In-Reply-To: <1325041873-1320-2-git-send-email-aaron.lu@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, stable@kernel.org

On 28/12/11 05:11, Aaron Lu wrote:
> When suspending host, the tuning timer shoule be deactivated.
> And the HOST_NEEDS_TUNING flag should be set after tuning timer is
> deactivated.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Aaron Lu <aaron.lu@amd.com>
> Cc: stable@kernel.org

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ab6018f..2007d37 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2346,9 +2346,8 @@ int sdhci_suspend_host(struct sdhci_host *host)
>  	/* Disable tuning since we are suspending */
>  	if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
>  	    host->tuning_mode == SDHCI_TUNING_MODE_1) {
> +		del_timer_sync(&host->tuning_timer);
>  		host->flags &= ~SDHCI_NEEDS_RETUNING;
> -		mod_timer(&host->tuning_timer, jiffies +
> -			host->tuning_count * HZ);
>  	}
>  
>  	ret = mmc_suspend_host(host->mmc);

