From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: core: Fix deadlock when the CONFIG_MMC_UNSAFE_RESUME
 is not defined
Date: Tue, 22 Nov 2011 16:43:46 +0100
Message-ID: <4ECBC332.9090407@stericsson.com>
References: <1321961437-27130-1-git-send-email-sthumma@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:48642 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755691Ab1KVPoD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2011 10:44:03 -0500
In-Reply-To: <1321961437-27130-1-git-send-email-sthumma@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>

Sujit Reddy Thumma wrote:
> mmc_suspend_host() tries to claim host during suspend
> and release it only when the bus suspend operation is
> compeleted. If CONFIG_MMC_UNSAFE_RESUME is defined and
> the host is flagged as removable, mmc_suspend_host()
> tries to remove the card. In this process, the file system
> sync can get blocked trying to acquire host which is already
> claimed by mmc_suspend_host() causing deadlock.
> 
> Fix this deadlock by releasing host before ->remove() is called.
> 
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> ---
>  drivers/mmc/core/core.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 271efea..8adbadf 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2338,6 +2338,7 @@ int mmc_suspend_host(struct mmc_host *host)
>  				 * We simply "remove" the card in this case.
>  				 * It will be redetected on resume.
>  				 */
> +				mmc_do_release_host(host);

Instead of having an "else" below move mmc_do_release_host to be done 
before "if (err == -ENOSYS || !host->bus_ops->resume)"

>  				if (host->bus_ops->remove)
>  					host->bus_ops->remove(host);
>  				mmc_claim_host(host);
> @@ -2346,8 +2347,9 @@ int mmc_suspend_host(struct mmc_host *host)
>  				mmc_release_host(host);
>  				host->pm_flags = 0;
>  				err = 0;
> +			} else {
> +				mmc_do_release_host(host);
>  			}

Remove else statement entirely.

> -			mmc_do_release_host(host);
>  		} else {
>  			err = -EBUSY;
>  		}

Otherwise it looks good to me! Thanks, for fixing this issue!

Br
Ulf Hansson

