From: "Sujit Reddy Thumma" <sthumma@codeaurora.org>
Subject: Re: [PATCH] mmc: core: Prevent too long response times for suspend
Date: Fri, 14 Oct 2011 23:47:37 -0700 (PDT)
Message-ID: <4f62290baad48cd8655f3f82f7b162b9.squirrel@www.codeaurora.org>
References: <1318514638-32452-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:21877 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab1JOGrh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Oct 2011 02:47:37 -0400
In-Reply-To: <1318514638-32452-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>

> While trying to suspend the mmc host there could still be
> ongoing requests that we need to wait for. At the same time
> a device driver must respond to a suspend request rather quickly.
>
> Instead of potentially wait "forever" by claiming the host we now
> "try" to claim the host instead. If it fails, -EBUSY is returned.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> ---
>  drivers/mmc/core/core.c |   42 +++++++++++++++++++++++++++---------------
>  1 files changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 61d7730..b900932 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2121,21 +2121,33 @@ int mmc_suspend_host(struct mmc_host *host)
>
>  	mmc_bus_get(host);
>  	if (host->bus_ops && !host->bus_dead) {
> -		if (host->bus_ops->suspend)
> -			err = host->bus_ops->suspend(host);
> -		if (err == -ENOSYS || !host->bus_ops->resume) {
> -			/*
> -			 * We simply "remove" the card in this case.
> -			 * It will be redetected on resume.
> -			 */
> -			if (host->bus_ops->remove)
> -				host->bus_ops->remove(host);
> -			mmc_claim_host(host);
> -			mmc_detach_bus(host);
> -			mmc_power_off(host);
> -			mmc_release_host(host);
> -			host->pm_flags = 0;
> -			err = 0;
> +
> +		/*
> +		 * A long response time is not acceptable for device drivers
> +		 * when doing suspend. Prevent mmc_claim_host in the suspend
> +		 * sequence, to potentially wait "forever" by trying to
> +		 * pre-claim the host.
> +		 */

Why would there be pending requests while host is suspending? Is the
kernel framework not handling sync before going to suspend? However, the
mmc_blk_suspend() would be called before the host driver suspends (as all
the driver suspend routines are serialized) which means it stops block
layer to queue more I/O requests well before the host driver start
suspend. Does this sequence break in your case?

Your concern seems to be valid for SDIO case, but again the function
driver must be intelligent enough to return -EBUSY as it knows that it had
posted a request to MMC.

> +		if (mmc_try_claim_host(host)) {
> +			if (host->bus_ops->suspend)
> +				err = host->bus_ops->suspend(host);
> +			if (err == -ENOSYS || !host->bus_ops->resume) {
> +				/*
> +				 * We simply "remove" the card in this case.
> +				 * It will be redetected on resume.
> +				 */
> +				if (host->bus_ops->remove)
> +					host->bus_ops->remove(host);
> +				mmc_claim_host(host);
> +				mmc_detach_bus(host);
> +				mmc_power_off(host);
> +				mmc_release_host(host);
> +				host->pm_flags = 0;
> +				err = 0;
> +			}
> +			mmc_do_release_host(host);
> +		} else {
> +			err = -EBUSY;
>  		}
>  	}
>  	mmc_bus_put(host);
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
Thanks,
Sujit

