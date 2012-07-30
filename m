From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] MMC/omap_hsmmc: handle failure of regulator_get better.
Date: Mon, 30 Jul 2012 10:50:36 +0530
Message-ID: <501619A4.50906@ti.com>
References: <20120730101245.7dbe72b0@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120730101245.7dbe72b0@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Chris Ball <cjb@laptop.org>, Venkatraman S <svenkatr@ti.com>, Balaji T K <balajitk@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Monday 30 July 2012 05:42 AM, NeilBrown wrote:
>
> 1/ if regulator_get fails, return an error.  This is important
>     if it failed with EPROBE_DEFER, as the probe needs to be
>     deferred.
>
> 2/ Don't set .set_power until the regulator has been found, or
>     the deferred probe will not bother calling omap_hsmmc_reg_get().

I am not very sure, but aren't the data structures re-allocated on a
re-probe (after it was deferred) causing .set_power to be lost anyway?

>
> Signed-off-by: NeilBrown<neilb@suse.de>
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 389a3ee..f052c29 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -299,12 +299,12 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>   	struct regulator *reg;
>   	int ocr_value = 0;
>
> -	mmc_slot(host).set_power = omap_hsmmc_set_power;
> -
>   	reg = regulator_get(host->dev, "vmmc");
>   	if (IS_ERR(reg)) {
>   		dev_dbg(host->dev, "vmmc regulator missing\n");
> +		return PTR_ERR(reg);
>   	} else {
> +		mmc_slot(host).set_power = omap_hsmmc_set_power;
>   		host->vcc = reg;
>   		ocr_value = mmc_regulator_get_ocrmask(reg);
>   		if (!mmc_slot(host).ocr_mask) {

