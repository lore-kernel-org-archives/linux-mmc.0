From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: always save error codes in mmc_regulator_get_supply()
Date: Tue, 03 Jul 2012 19:01:53 -0400
Message-ID: <87pq8c78ke.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1206271714270.24173@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36537 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756428Ab2GCXB6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Jul 2012 19:01:58 -0400
In-Reply-To: <Pine.LNX.4.64.1206271714270.24173@axis700.grange> (Guennadi
	Liakhovetski's message of "Wed, 27 Jun 2012 17:18:32 +0200 (CEST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org

Hi,

On Wed, Jun 27 2012, Guennadi Liakhovetski wrote:
> If mmc_regulator_get_supply() fails to obtain any of the regulators, store
> the error codes in struct mmc_host to unify error reporting to the host
> driver.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> Chris, if you don't mind rebasing your mmc-next branch, feel free to roll 
> this patch into the original "mmc: add a function to get regulators, 
> supplying card's power". Otherwise, committing it as an incremental patch 
> is also ok.
>
>  drivers/mmc/core/core.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 385cadf..d0f17d8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1020,13 +1020,12 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
>  	int ret;
>  
>  	supply = devm_regulator_get(dev, "vmmc");
> +	mmc->supply.vmmc = supply;
> +	mmc->supply.vqmmc = devm_regulator_get(dev, "vqmmc");
>  
>  	if (IS_ERR(supply))
>  		return PTR_ERR(supply);
>  
> -	mmc->supply.vmmc = supply;
> -	mmc->supply.vqmmc = devm_regulator_get(dev, "vqmmc");
> -
>  	ret = mmc_regulator_get_ocrmask(supply);
>  	if (ret > 0)
>  		mmc->ocr_avail = ret;

Thanks, I rebased it and pushed out to mmc-next.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
