From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: print debug messages for runtime PM actions
Date: Mon, 18 Jul 2011 22:31:43 -0400
Message-ID: <m2pql79f1s.fsf@bob.laptop.org>
References: <20110717153841.D4BF29D401C@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55150 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551Ab1GSCbr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Jul 2011 22:31:47 -0400
In-Reply-To: <20110717153841.D4BF29D401C@zog.reactivated.net> (Daniel Drake's
	message of "Sun, 17 Jul 2011 16:38:41 +0100 (BST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Dan,

On Sun, Jul 17 2011, Daniel Drake wrote:
> At
> http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg08371.html
> we found and fixed a bug where mmc's runtime power management functions
> were not being called. We have now also made improvements to the SDIO
> powerup routine which could possibly mask this kind of issue in future.
>
> Add debug messages to the runtime PM hooks so that it is easy to verify
> if and when runtime PM is happening.
>
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  drivers/mmc/core/core.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
>
> For linux-3.1.
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0a04886..ad0c55a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1664,6 +1664,10 @@ int mmc_power_save_host(struct mmc_host *host)
>  {
>  	int ret = 0;
>  
> +#ifdef CONFIG_MMC_DEBUG
> +	pr_info("%s: %s: powering down\n", mmc_hostname(host), __func__);
> +#endif
> +

Did you consider just:

	pr_debug("%s: %s: powering down\n", mmc_hostname(host), __func__);

which gets you the same CONFIG_MMC_DEBUG semantics?  (The messages will
be at the debug loglevel rather than info, but that sounds right to me.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
