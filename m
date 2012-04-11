From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Get rid of of_have_populated_dt() usage
Date: Wed, 11 Apr 2012 07:10:21 -0500
Message-ID: <4F8574AD.5040306@gmail.com>
References: <1334138593-9692-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1334138593-9692-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: cjb@laptop.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Balaji TK <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

On 04/11/2012 05:03 AM, Rajendra Nayak wrote:
> of_have_populated_dt() is not expected to be used in drivers but
> instead only in early platform init code.
> Drivers on the other hand should rely on dev->of_node or of_match_device().
> Besides usage of of_have_populated_dt() also throws up build error as below
> which was reported by Balaji TK, when omap_hsmmc is built as a module.
> 
> ERROR: "allnodes" [drivers/mmc/host/omap_hsmmc.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> So get rid of all of_have_populated_dt() usage in omap_hsmmc driver and
> instead use dev->of_node to make the same dicisions as earlier.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Reported-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Balaji TK <balajitk@ti.com>
> Cc: Rob Herring <rob.herring@calxeda.com>

Ack

Rob

> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index ecc9521..4254b6f 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -252,7 +252,7 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>  	 * the pbias cell programming support is still missing when
>  	 * booting with Device tree
>  	 */
> -	if (of_have_populated_dt() && !vdd)
> +	if (dev->of_node && !vdd)
>  		return 0;
>  
>  	if (mmc_slot(host).before_set_reg)
> @@ -1564,7 +1564,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  			 * can't be allowed when booting with device
>  			 * tree.
>  			 */
> -			(!of_have_populated_dt())) {
> +			!host->dev->of_node) {
>  				/*
>  				 * The mmc_select_voltage fn of the core does
>  				 * not seem to set the power_mode to

