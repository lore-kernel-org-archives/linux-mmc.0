From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: fix CONFIG_MMC_UNSAFE_RESUME regression
Date: Tue, 08 Mar 2011 16:56:50 -0500
Message-ID: <m3hbbdp97h.fsf@pullcord.laptop.org>
References: <1299619922-22220-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49476 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151Ab1CHV75 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Mar 2011 16:59:57 -0500
In-Reply-To: <1299619922-22220-1-git-send-email-ohad@wizery.com> (Ohad
	Ben-Cohen's message of "Tue, 8 Mar 2011 23:32:02 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>, Maxim Levitsky <maximlevitsky@gmail.com>, stable@kernel.org

Hi Ohad,

On Tue, Mar 08 2011, Ohad Ben-Cohen wrote:
> 30201e7 allowed skipping detection of nonremovable cards on
> mmc_rescan(). The intention was to only skip detection of hardwired
> cards that cannot be removed, so make sure this is indeed the
> case by directly checking for (lack of) MMC_CAP_NONREMOVABLE, instead
> of using mmc_card_is_removable(), which is overloaded with
> CONFIG_MMC_UNSAFE_RESUME semantics.
>
> Reported-and-tested-by: Dmitry Shmidt <dimitrysh@google.com>
> Reported-and-tested-by: Maxim Levitsky <maximlevitsky@gmail.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: <stable@kernel.org>
> ---
> Based on linux-2.6.git master, as this should probably go to Linus.
>
>  drivers/mmc/core/core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6625c05..150b5f3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1529,7 +1529,7 @@ void mmc_rescan(struct work_struct *work)
>  	 * still present
>  	 */
>  	if (host->bus_ops && host->bus_ops->detect && !host->bus_dead
> -	    && mmc_card_is_removable(host))
> +	    && !(host->caps & MMC_CAP_NONREMOVABLE))
>  		host->bus_ops->detect(host);
>  
>  	/*

Thanks, I will send this to Linus for .38 final.

I have removed the stable@ tag, because the patch causing this
regression was introduced in .38-rc1 -- it has not been part of
any released kernel.  So, as long as we fix it before .38 releases
in a week, there's no need to involve stable@.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
