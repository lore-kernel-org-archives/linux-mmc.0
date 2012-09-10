From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH v2] mmc: slot-gpio: Add support for power gpios
Date: Mon, 10 Sep 2012 23:48:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1209102340290.26171@axis700.grange>
References: <87oblfzypc.fsf@octavius.laptop.org> <Pine.LNX.4.64.1209092325350.11567@axis700.grange>
 <874nn6zilz.fsf_-_@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55765 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab2IJVsh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Sep 2012 17:48:37 -0400
In-Reply-To: <874nn6zilz.fsf_-_@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Chris

On Sun, 9 Sep 2012, Chris Ball wrote:

> A power gpio is a sideband output gpio that controls card power.

Thanks for the patch. It looks good formally now, thanks for taking into 
account my comments. However, I'm wondering: this GPIO is different from 
the previous two - it's an output. So, I've got a couple of doubts:

1. in mmc_gpio_request_pwr() you request GPIO as output and immediately 
turn power on. Is this really what we want to do?

2. since this is a card power GPIO, you also want to toggle it, so, you'd 
need a mmc_gpio_set_pwr() function too.

3. now, this is the biggest one. Are we sure we need this at all? I think, 
you should just set up a fixed (or a GPIO, if more than one voltage is 
possible, which isn't supported by this patch) regulator and use the 
mmc_regulator_*() API from your MMC host driver's .set_ios() method. Don't 
you think this would be a better option? Or it wouldn't work for you?

Thanks
Guennadi

> 
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
> Changelog:
> 
> v2, addressing Guennadi's review comments:
>  - More consistent comment and operator coding style
>  - Only store pwr_gpio in ctx if requesting it was successful
>  - Use GPIOF_OUT_INIT_{LOW,HIGH} directly
> 
>  drivers/mmc/core/slot-gpio.c  | 70 ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/mmc/host.h      |  1 +
>  include/linux/mmc/slot-gpio.h |  3 ++
>  3 files changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 08c6b3d..cf7e826 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -20,6 +20,8 @@
>  struct mmc_gpio {
>  	int ro_gpio;
>  	int cd_gpio;
> +	int pwr_gpio;
> +	char *pwr_label;
>  	char *ro_label;
>  	char cd_label[0];
>  };
> @@ -33,6 +35,10 @@ static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
>  
>  static int mmc_gpio_alloc(struct mmc_host *host)
>  {
> +	/*
> +	 * The "+ 4" is to leave room for a space, two-char identifier
> +	 * and \0 after each label in the mmc_gpio struct.
> +	 */
>  	size_t len = strlen(dev_name(host->parent)) + 4;
>  	struct mmc_gpio *ctx;
>  
> @@ -45,14 +51,19 @@ static int mmc_gpio_alloc(struct mmc_host *host)
>  		 * before device_add(), i.e., between mmc_alloc_host() and
>  		 * mmc_add_host()
>  		 */
> -		ctx = devm_kzalloc(&host->class_dev, sizeof(*ctx) + 2 * len,
> +
> +		/* len * 3 because we have 3 strings to allocate on the end. */
> +		ctx = devm_kzalloc(&host->class_dev, sizeof(*ctx) + len * 3,
>  				   GFP_KERNEL);
>  		if (ctx) {
>  			ctx->ro_label = ctx->cd_label + len;
> +			ctx->pwr_label = ctx->cd_label + len * 2;
>  			snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
>  			snprintf(ctx->ro_label, len, "%s ro", dev_name(host->parent));
> +			snprintf(ctx->pwr_label, len, "%s pw", dev_name(host->parent));
>  			ctx->cd_gpio = -EINVAL;
>  			ctx->ro_gpio = -EINVAL;
> +			ctx->pwr_gpio = -EINVAL;
>  			host->slot.handler_priv = ctx;
>  		}
>  	}
> @@ -74,6 +85,18 @@ int mmc_gpio_get_ro(struct mmc_host *host)
>  }
>  EXPORT_SYMBOL(mmc_gpio_get_ro);
>  
> +int mmc_gpio_get_pwr(struct mmc_host *host)
> +{
> +	struct mmc_gpio *ctx = host->slot.handler_priv;
> +
> +	if (!ctx || !gpio_is_valid(ctx->pwr_gpio))
> +		return -ENOSYS;
> +
> +	return !gpio_get_value_cansleep(ctx->pwr_gpio) ^
> +		!!(host->caps2 & MMC_CAP2_PWR_ACTIVE_HIGH);
> +}
> +EXPORT_SYMBOL(mmc_gpio_get_pwr);
> +
>  int mmc_gpio_get_cd(struct mmc_host *host)
>  {
>  	struct mmc_gpio *ctx = host->slot.handler_priv;
> @@ -110,6 +133,36 @@ int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
>  }
>  EXPORT_SYMBOL(mmc_gpio_request_ro);
>  
> +int mmc_gpio_request_pwr(struct mmc_host *host, unsigned int gpio)
> +{
> +	struct mmc_gpio *ctx;
> +	int ret;
> +	unsigned long gpio_flags;
> +
> +	if (!gpio_is_valid(gpio))
> +		return -EINVAL;
> +
> +	ret = mmc_gpio_alloc(host);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctx = host->slot.handler_priv;
> +
> +	if (host->caps2 & MMC_CAP2_PWR_ACTIVE_HIGH)
> +		gpio_flags = GPIOF_OUT_INIT_HIGH;
> +	else
> +		gpio_flags = GPIOF_OUT_INIT_LOW;
> +
> +	ret = gpio_request_one(gpio, gpio_flags, ctx->pwr_label);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctx->pwr_gpio = gpio;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(mmc_gpio_request_pwr);
> +
>  int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
>  {
>  	struct mmc_gpio *ctx;
> @@ -173,6 +226,21 @@ void mmc_gpio_free_ro(struct mmc_host *host)
>  }
>  EXPORT_SYMBOL(mmc_gpio_free_ro);
>  
> +void mmc_gpio_free_pwr(struct mmc_host *host)
> +{
> +	struct mmc_gpio *ctx = host->slot.handler_priv;
> +	int gpio;
> +
> +	if (!ctx || !gpio_is_valid(ctx->pwr_gpio))
> +		return;
> +
> +	gpio = ctx->pwr_gpio;
> +	ctx->pwr_gpio = -EINVAL;
> +
> +	gpio_free(gpio);
> +}
> +EXPORT_SYMBOL(mmc_gpio_free_pwr);
> +
>  void mmc_gpio_free_cd(struct mmc_host *host)
>  {
>  	struct mmc_gpio *ctx = host->slot.handler_priv;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index d5d9bd4..5a00cc1 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -257,6 +257,7 @@ struct mmc_host {
>  #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
>  #define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
>  #define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
> +#define MMC_CAP2_PWR_ACTIVE_HIGH (1 << 12)	/* Card power signal active high */
>  
>  	mmc_pm_flag_t		pm_caps;	/* supported pm features */
>  	unsigned int        power_notify_type;
> diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
> index 7d88d27..d083dfa 100644
> --- a/include/linux/mmc/slot-gpio.h
> +++ b/include/linux/mmc/slot-gpio.h
> @@ -21,4 +21,7 @@ int mmc_gpio_get_cd(struct mmc_host *host);
>  int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio);
>  void mmc_gpio_free_cd(struct mmc_host *host);
>  
> +int mmc_gpio_get_pwr(struct mmc_host *host);
> +int mmc_gpio_request_pwr(struct mmc_host *host, unsigned int gpio);
> +void mmc_gpio_free_pwr(struct mmc_host *host);
>  #endif
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
