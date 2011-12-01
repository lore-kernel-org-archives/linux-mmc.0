From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2] mmc: core: Fix deadlock when the CONFIG_MMC_UNSAFE_RESUME is not defined
Date: Thu, 01 Dec 2011 13:18:23 -0500
Message-ID: <87mxbckvf4.fsf@laptop.org>
References: <1322017998-16559-1-git-send-email-sthumma@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52342 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069Ab1LASSR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Dec 2011 13:18:17 -0500
In-Reply-To: <1322017998-16559-1-git-send-email-sthumma@codeaurora.org> (Sujit
	Reddy Thumma's message of "Wed, 23 Nov 2011 08:43:18 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@stericsson.com

Hi,

On Tue, Nov 22 2011, Sujit Reddy Thumma wrote:
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
>
> ---
> Changes in v2:
> 	- Addressed review comment from Ulf Hansson.
> ---
>  drivers/mmc/core/core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 271efea..950b97d 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2333,6 +2333,8 @@ int mmc_suspend_host(struct mmc_host *host)
>  				mmc_poweroff_notify(host);
>  				err = host->bus_ops->suspend(host);
>  			}
> +			mmc_do_release_host(host);
> +
>  			if (err == -ENOSYS || !host->bus_ops->resume) {
>  				/*
>  				 * We simply "remove" the card in this case.
> @@ -2347,7 +2349,6 @@ int mmc_suspend_host(struct mmc_host *host)
>  				host->pm_flags = 0;
>  				err = 0;
>  			}
> -			mmc_do_release_host(host);
>  		} else {
>  			err = -EBUSY;
>  		}

Thanks very much, pushed to mmc-next for 3.2 with ACKs from Ulf and Linus.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
