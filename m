From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: fixed wrong SD card detection
Date: Tue, 10 May 2011 23:54:16 -0400
Message-ID: <m362ph51uf.fsf@pullcord.laptop.org>
References: <4DC3C1A8.1050104@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35545 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134Ab1EKDvs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2011 23:51:48 -0400
In-Reply-To: <4DC3C1A8.1050104@samsung.com> (Jaehoon Chung's message of "Fri,
	06 May 2011 18:38:48 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Jaehoon,

On Fri, May 06 2011, Jaehoon Chung wrote:
> This patch added mmc_power_off after mmc_attach_sd()
>
> i found that didn't detect the second card insert.(using SDHCI)
> you can see the below log.
>
> i want to know that somebody know this issue...
>
> ->first card inserted (correct card detect)
> # mmc1: new SDHC card at address e624
> mmcblk1: mmc1:e624 SU04G 3.69 GiB
>  mmcblk1: p1
> #
> # mmc1: card e624 removed
> -> second card inserted
> mmc1: error -110 whilst initialising SD card
> mmc1: Card removed during transfer!
> mmc1: Resetting controller.
> -> third card inserted 
> mmc1: new SDHC card at address e624
> mmcblk1: mmc1:e624 SU04G 3.69 GiB
>  mmcblk1: p1
>
> I added mmc_power_off() after only mmc_attach_sd().
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/core/core.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1dbc185..d5d8ac0 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1522,8 +1522,10 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
>  	/* Order's important: probe SDIO, then SD, then MMC */
>  	if (!mmc_attach_sdio(host))
>  		return 0;
> -	if (!mmc_attach_sd(host))
> +	if (!mmc_attach_sd(host)) {
> +		mmc_power_off(host);
>  		return 0;
> +	}
>  	if (!mmc_attach_mmc(host))
>  		return 0;
>  

It looks to me like this patch says "if we successfully attach/power up
an SD card, then power it back off again immediately".  Why would that
make sense?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
