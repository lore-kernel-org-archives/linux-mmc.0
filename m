From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: claim host during mmc_power_off on suspend
Date: Tue, 17 Jan 2012 09:18:46 +0200
Message-ID: <4F1520D6.6070703@intel.com>
References: <1326293468-18604-1-git-send-email-arik@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59658 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307Ab2AQHSp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Jan 2012 02:18:45 -0500
In-Reply-To: <1326293468-18604-1-git-send-email-arik@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arik Nemtsov <arik@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 11/01/12 16:51, Arik Nemtsov wrote:
> Make sure the host is claimed in all calls of mmc_power_off() during
> suspend. In addition make sure mmc_power_off() isn't called twice in
> some suspend flows.
> 
> Signed-off-by: Arik Nemtsov <arik@wizery.com>
> Signed-off-by: Ido Yariv <ido@wizery.com>
> ---
>  drivers/mmc/core/core.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 950b97d..d830c5c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2305,6 +2305,7 @@ EXPORT_SYMBOL(mmc_cache_ctrl);
>  int mmc_suspend_host(struct mmc_host *host)
>  {
>  	int err = 0;
> +	bool powered_off = false;
>  
>  	if (host->caps & MMC_CAP_DISABLE)
>  		cancel_delayed_work(&host->disable);
> @@ -2348,6 +2349,7 @@ int mmc_suspend_host(struct mmc_host *host)
>  				mmc_release_host(host);
>  				host->pm_flags = 0;
>  				err = 0;
> +				powered_off = true;
>  			}
>  		} else {
>  			err = -EBUSY;
> @@ -2355,8 +2357,11 @@ int mmc_suspend_host(struct mmc_host *host)
>  	}
>  	mmc_bus_put(host);
>  
> -	if (!err && !mmc_card_keep_power(host))
> +	if (!powered_off && !err && !mmc_card_keep_power(host)) {
> +		mmc_claim_host(host);

Why not mmc_try_claim_host() etc?

>  		mmc_power_off(host);
> +		mmc_release_host(host);
> +	}
>  
>  out:
>  	return err;

