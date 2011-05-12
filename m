From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: clear MMC_PM_KEEP_POWER flag on resume
Date: Thu, 12 May 2011 18:19:51 -0400
Message-ID: <m3fwojwohk.fsf@pullcord.laptop.org>
References: <1304929951-30326-1-git-send-email-eliad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55933 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932786Ab1ELWRd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 May 2011 18:17:33 -0400
In-Reply-To: <1304929951-30326-1-git-send-email-eliad@wizery.com> (Eliad
	Peller's message of "Mon, 9 May 2011 11:32:31 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eliad Peller <eliad@wizery.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.org

Hi, (adding Nico to CC in case he has comments)

On Mon, May 09 2011, Eliad Peller wrote:
> Since the MMC_PM_KEEP_POWER flag should be set on each suspend,
> it should also cleared on each resume.
>
> Upon resuming, we have to know if power was kept
> (for re-initialization, etc.), so clear it just after resuming.
>
> Signed-off-by: Eliad Peller <eliad@wizery.com>
> ---
>  drivers/mmc/core/core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index c2350e4..99941eb 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1789,6 +1789,7 @@ int mmc_resume_host(struct mmc_host *host)
>  			err = 0;
>  		}
>  	}
> +	host->pm_flags &= ~MMC_PM_KEEP_POWER;
>  	mmc_bus_put(host);
>  
>  	return err;

Thanks, this looks correct to me, pushed to mmc-next for .40.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
