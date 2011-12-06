From: Hein_Tibosch <hein_tibosch@yahoo.es>
Subject: Re: [PATCH 2/5 v2] MMC/core: Add f_min to mmc_power_on()
Date: Tue, 06 Dec 2011 20:13:14 +0800
Message-ID: <4EDE06DA.7010108@yahoo.es>
References: <1323163107-32619-1-git-send-email-r66093@freescale.com> <1323163107-32619-2-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bosmailout05.eigbox.net ([66.96.184.5]:40193 "EHLO
	bosmailout05.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933195Ab1LFMzU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 07:55:20 -0500
Received: from bosmailscan06.eigbox.net ([10.20.15.6])
	by bosmailout05.eigbox.net with esmtp (Exim)
	id 1RXtuj-0002sa-Tm
	for linux-mmc@vger.kernel.org; Tue, 06 Dec 2011 07:14:25 -0500
In-Reply-To: <1323163107-32619-2-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

Hi Jerry,

On 12/6/2011 5:18 PM, r66093@freescale.com wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>
> When f_init is zero, the SDHC can't work correctly. So f_min will replace
> f_init, when f_init is zero.
>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Chris Ball <cjb@laptop.org>
> ---
> changes for v2:
> 	- add the CC
>
>  drivers/mmc/core/core.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index a08e6b1..2d40c04 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1253,7 +1253,10 @@ static void mmc_power_up(struct mmc_host *host)
>  	 */
>  	mmc_delay(10);
>  
> -	host->ios.clock = host->f_init;
> +	if (host->f_init)
> +		host->ios.clock = host->f_init;
> +	else
> +		host->ios.clock = host->f_min;

Are you sure f_min can have a value of zero?
It should have been set mmc_rescan_try_freq(), when trying a list
of frequencies: 400000, 300000, 200000, 100000

>  
>  	host->ios.power_mode = MMC_POWER_ON;
>  	mmc_set_ios(host);
