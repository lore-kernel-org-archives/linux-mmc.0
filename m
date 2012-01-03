From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: deactivate tuning timer when host is suspending
Date: Mon, 02 Jan 2012 19:02:27 -0500
Message-ID: <m2hb0dpsa4.fsf@bob.laptop.org>
References: <1324959750-18203-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50787 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486Ab2ACACf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 Jan 2012 19:02:35 -0500
In-Reply-To: <1324959750-18203-1-git-send-email-aaron.lu@amd.com> (Aaron Lu's
	message of "Tue, 27 Dec 2011 12:22:30 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

Hi,

On Mon, Dec 26 2011, Aaron Lu wrote:
> From: Philip Rakity <prakity@marvell.com>
>
> Since we are suspending, the tuning timer should be deactivated.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Acked-by: Aaron Lu <aaron.lu@amd.com>
> ---
>  drivers/mmc/host/sdhci.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ab6018f..1abbd26 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2347,8 +2347,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
>  	if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
>  	    host->tuning_mode == SDHCI_TUNING_MODE_1) {
>  		host->flags &= ~SDHCI_NEEDS_RETUNING;
> -		mod_timer(&host->tuning_timer, jiffies +
> -			host->tuning_count * HZ);
> +		del_timer_sync(&host->tuning_timer);
>  	}
>  
>  	ret = mmc_suspend_host(host->mmc);

Pushed to mmc-next for 3.3 with a stable@ tag, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
