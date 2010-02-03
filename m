From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 0/10] omap_hsmmc changes V2
Date: Tue, 2 Feb 2010 18:17:30 -0800
Message-ID: <20100203021730.GU22747@atomide.com>
References: <1264149200.1920.11.camel@Nokia-N900-51-1>
 <20100122171427.GQ23467@atomide.com>
 <20100202031241.GP22747@atomide.com>
 <4B67EED7.8040801@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54232 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756308Ab0BCCRI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2010 21:17:08 -0500
Content-Disposition: inline
In-Reply-To: <4B67EED7.8040801@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "madhu.cr@ti.com" <madhu.cr@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

* Adrian Hunter <adrian.hunter@nokia.com> [100202 01:21]:
> From 10920ef5efbfced940eea0932e314b5a63ac706c Mon Sep 17 00:00:00 2001
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Tue, 2 Feb 2010 10:53:38 +0200
> Subject: [PATCH] omap_hsmmc: allow compile without regulator framework
> 
> It is still possible to use the omap_hsmmc module
> without the regulator framework.  Accordingly, ifdef
> out regulator-specific functions.

Thanks that fixes the 2430 compile issue. Adding this into omap for-next.

Regards,

Tony
 
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
> drivers/mmc/host/omap_hsmmc.c |  133 ++++++++++++++++++++++++-----------------
> 1 files changed, 79 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index af37477..83f0aff 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -236,6 +236,8 @@ static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
> 
> #endif
> 
> +#ifdef CONFIG_REGULATOR
> +
> static int omap_hsmmc_1_set_power(struct device *dev, int slot, int power_on,
> 				  int vdd)
> {
> @@ -357,59 +359,6 @@ static int omap_hsmmc_23_set_sleep(struct device *dev, int slot, int sleep,
> 		return regulator_enable(host->vcc_aux);
> }
> 
> -static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
> -{
> -	int ret;
> -
> -	if (gpio_is_valid(pdata->slots[0].switch_pin)) {
> -		pdata->suspend = omap_hsmmc_suspend_cdirq;
> -		pdata->resume = omap_hsmmc_resume_cdirq;
> -		if (pdata->slots[0].cover)
> -			pdata->slots[0].get_cover_state =
> -					omap_hsmmc_get_cover_state;
> -		else
> -			pdata->slots[0].card_detect = omap_hsmmc_card_detect;
> -		pdata->slots[0].card_detect_irq =
> -				gpio_to_irq(pdata->slots[0].switch_pin);
> -		ret = gpio_request(pdata->slots[0].switch_pin, "mmc_cd");
> -		if (ret)
> -			return ret;
> -		ret = gpio_direction_input(pdata->slots[0].switch_pin);
> -		if (ret)
> -			goto err_free_sp;
> -	} else
> -		pdata->slots[0].switch_pin = -EINVAL;
> -
> -	if (gpio_is_valid(pdata->slots[0].gpio_wp)) {
> -		pdata->slots[0].get_ro = omap_hsmmc_get_wp;
> -		ret = gpio_request(pdata->slots[0].gpio_wp, "mmc_wp");
> -		if (ret)
> -			goto err_free_cd;
> -		ret = gpio_direction_input(pdata->slots[0].gpio_wp);
> -		if (ret)
> -			goto err_free_wp;
> -	} else
> -		pdata->slots[0].gpio_wp = -EINVAL;
> -
> -	return 0;
> -
> -err_free_wp:
> -	gpio_free(pdata->slots[0].gpio_wp);
> -err_free_cd:
> -	if (gpio_is_valid(pdata->slots[0].switch_pin))
> -err_free_sp:
> -		gpio_free(pdata->slots[0].switch_pin);
> -	return ret;
> -}
> -
> -static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
> -{
> -	if (gpio_is_valid(pdata->slots[0].gpio_wp))
> -		gpio_free(pdata->slots[0].gpio_wp);
> -	if (gpio_is_valid(pdata->slots[0].switch_pin))
> -		gpio_free(pdata->slots[0].switch_pin);
> -}
> -
> static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
> {
> 	struct regulator *reg;
> @@ -488,6 +437,82 @@ static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
> 	mmc_slot(host).set_sleep = NULL;
> }
> 
> +static inline int omap_hsmmc_have_reg(void)
> +{
> +	return 1;
> +}
> +
> +#else
> +
> +static inline int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
> +{
> +}
> +
> +static inline int omap_hsmmc_have_reg(void)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
> +static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
> +{
> +	int ret;
> +
> +	if (gpio_is_valid(pdata->slots[0].switch_pin)) {
> +		pdata->suspend = omap_hsmmc_suspend_cdirq;
> +		pdata->resume = omap_hsmmc_resume_cdirq;
> +		if (pdata->slots[0].cover)
> +			pdata->slots[0].get_cover_state =
> +					omap_hsmmc_get_cover_state;
> +		else
> +			pdata->slots[0].card_detect = omap_hsmmc_card_detect;
> +		pdata->slots[0].card_detect_irq =
> +				gpio_to_irq(pdata->slots[0].switch_pin);
> +		ret = gpio_request(pdata->slots[0].switch_pin, "mmc_cd");
> +		if (ret)
> +			return ret;
> +		ret = gpio_direction_input(pdata->slots[0].switch_pin);
> +		if (ret)
> +			goto err_free_sp;
> +	} else
> +		pdata->slots[0].switch_pin = -EINVAL;
> +
> +	if (gpio_is_valid(pdata->slots[0].gpio_wp)) {
> +		pdata->slots[0].get_ro = omap_hsmmc_get_wp;
> +		ret = gpio_request(pdata->slots[0].gpio_wp, "mmc_wp");
> +		if (ret)
> +			goto err_free_cd;
> +		ret = gpio_direction_input(pdata->slots[0].gpio_wp);
> +		if (ret)
> +			goto err_free_wp;
> +	} else
> +		pdata->slots[0].gpio_wp = -EINVAL;
> +
> +	return 0;
> +
> +err_free_wp:
> +	gpio_free(pdata->slots[0].gpio_wp);
> +err_free_cd:
> +	if (gpio_is_valid(pdata->slots[0].switch_pin))
> +err_free_sp:
> +		gpio_free(pdata->slots[0].switch_pin);
> +	return ret;
> +}
> +
> +static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
> +{
> +	if (gpio_is_valid(pdata->slots[0].gpio_wp))
> +		gpio_free(pdata->slots[0].gpio_wp);
> +	if (gpio_is_valid(pdata->slots[0].switch_pin))
> +		gpio_free(pdata->slots[0].switch_pin);
> +}
> +
> /*
>  * Stop clock to the card
>  */
> @@ -2119,7 +2144,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
> 		}
> 	}
> 
> -	if (!mmc_slot(host).set_power) {
> +	if (omap_hsmmc_have_reg() && !mmc_slot(host).set_power) {
> 		ret = omap_hsmmc_reg_get(host);
> 		if (ret)
> 			goto err_reg;
> -- 
> 1.6.0.4
