From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Allow sdio operations in other thread during sdio_add_func()
Date: Thu, 03 Mar 2011 17:42:16 -0500
Message-ID: <m3tyfjomgn.fsf@pullcord.laptop.org>
References: <loom.20110212T012443-915@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50249 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758945Ab1CCWoG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Mar 2011 17:44:06 -0500
In-Reply-To: <loom.20110212T012443-915@post.gmane.org> (Dmitry Shmidt's
	message of "Sat, 12 Feb 2011 00:25:30 +0000 (UTC)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@android.com>
Cc: linux-mmc@vger.kernel.org

Hi Dmitry,

On Fri, Feb 11 2011, Dmitry Shmidt wrote:
> commit 9cb71a1eb86a2acf0762d31af633984cf9e24d32
> Author: Dmitry Shmidt <dimitrysh@google.com>
> Date:   Fri Feb 11 16:10:33 2011 -0800
>
>     mmc: core: Allow sdio operations in other thread during sdio_add_func()
>
>     Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index dec4290..d4e6e6ef 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -834,7 +834,6 @@ int mmc_attach_sdio(struct mmc_host *host)
>          */
>         mmc_release_host(host);
>         err = mmc_add_card(host->card);
> -       mmc_claim_host(host);
>         if (err)
>                 goto remove_added;
>
> @@ -846,13 +845,12 @@ int mmc_attach_sdio(struct mmc_host *host)
>                 if (err)
>                         goto remove_added;
>         }
> -
> +       mmc_claim_host(host);
>         return 0;
>
>
>  remove_added:
>         /* Remove without lock if the device has been added. */
> -       mmc_release_host(host);
>         mmc_sdio_remove(host);
>         mmc_claim_host(host);
>  remove:
>

Thanks, pushed to mmc-next for .39.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
