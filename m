From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: export function mmc_do_release_host
Date: Tue, 08 Mar 2011 14:44:50 -0500
Message-ID: <m362rtqtvx.fsf@pullcord.laptop.org>
References: <1299330464-12938-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41790 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755556Ab1CHTrD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Mar 2011 14:47:03 -0500
In-Reply-To: <1299330464-12938-1-git-send-email-linus.walleij@stericsson.com>
	(Linus Walleij's message of "Sat, 5 Mar 2011 14:07:44 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

Hi,

On Sat, Mar 05 2011, Linus Walleij wrote:
> From: Ulf Hansson <ulf.hansson@stericsson.com>
>
> When using mmc_try_claim_host the corresponding release
> function is mmc_do_release_host, which then also must
> be exported.
>
> Reviewed-by: Jonas Aberg <jonas.aberg@stericsson.com>
> Reviewed-by: Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/core.c  |    3 ++-
>  include/linux/mmc/core.h |    1 +
>  2 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 579ba1e..2521794 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -527,7 +527,7 @@ int mmc_try_claim_host(struct mmc_host *host)
>  }
>  EXPORT_SYMBOL(mmc_try_claim_host);
>  
> -static void mmc_do_release_host(struct mmc_host *host)
> +void mmc_do_release_host(struct mmc_host *host)
>  {
>  	unsigned long flags;
>  
> @@ -542,6 +542,7 @@ static void mmc_do_release_host(struct mmc_host *host)
>  		wake_up(&host->wq);
>  	}
>  }
> +EXPORT_SYMBOL(mmc_do_release_host);
>  
>  void mmc_host_deeper_disable(struct work_struct *work)
>  {

Would you mind adding a kerneldoc comment for mmc_do_release_host()?
The other public locking functions have them, so this should gain one
too when it becomes public.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
